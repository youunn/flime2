import 'dart:async';

import 'package:flime/api/platform_api.g.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flime/keyboard/stores/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainKeyboard extends StatefulWidget {
  final Preset preset;
  final Preset? landscapePreset;

  const MainKeyboard({Key? key, required this.preset, this.landscapePreset}) : super(key: key);

  @override
  State<MainKeyboard> createState() => _MainKeyboardState();
}

class _MainKeyboardState extends State<MainKeyboard> {
  late K _dummy;
  late K _currentK;
  var _longPressed = false;

  @override
  void initState() {
    super.initState();
    _dummy = K.dummy(widget.preset);
    _currentK = _dummy;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer4<SettingsStore, ConstraintStore, KeyboardStatus, InputService>(
      builder: (_, settings, constraint, status, inputService, child) {
        // 有点偷懒
        return Observer(
          builder: (context) {
            final preset = constraint.orientation == Orientation.landscape
                ? widget.landscapePreset ?? widget.preset
                : widget.preset;
            // TODO: replace with custom RenderObject
            return RawGestureDetector(
              behavior: HitTestBehavior.translucent,
              gestures: {
                TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                  () => TapGestureRecognizer(),
                  (instance) {
                    instance.onTapUp = (_) async {
                      final k = _currentK;
                      if (k != _dummy) {
                        final event = status.isComposing ? k.composing ?? k.click : k.click;
                        await inputService.handleEvent(event, context);
                        setState(() {
                          _currentK = _dummy;
                        });
                      }
                    };
                  },
                ),
                LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
                  () => LongPressGestureRecognizer(duration: settings.longPressDuration),
                  (instance) {
                    instance
                      ..onLongPressDown = (details) async {
                        final k = await preset.detectKey(
                          details.localPosition,
                          screenWidth,
                          orientation: constraint.orientation,
                        );
                        if (k != null) {
                          setState(() {
                            _currentK = k;
                          });
                        }
                      }
                      ..onLongPressStart = (_) async {
                        setState(() {
                          _longPressed = true;
                        });

                        final k = _currentK;
                        if (k.repeatable) {
                          while (_longPressed) {
                            final event = status.isComposing ? k.composing ?? k.click : k.click;
                            await inputService.handleEvent(event, context);
                            await Future.delayed(settings.repeatInterval);
                          }
                        }
                      }
                      ..onLongPressEnd = (details) async {
                        final k = _currentK;
                        final more = k.more;
                        final moreBox = k.moreKeysPanelBox;

                        if (k != _dummy) {
                          if (k.repeatable) {
                            // ignore
                          } else if (more == null || moreBox == null) {
                            final event = k.longClick ?? (status.isComposing ? k.composing ?? k.click : k.click);
                            await inputService.handleEvent(event, context);
                          } else {
                            // TODO: extract method or use detectKey
                            var minDistance = double.maxFinite;
                            K? selected;

                            final orientationFactor =
                                constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1;
                            final x = details.localPosition.dx / screenWidth - moreBox.left;
                            final y = details.localPosition.dy / (screenWidth * orientationFactor) - moreBox.top;
                            for (final r in more) {
                              for (final k in r.keys) {
                                final distance = k.getSquaredDistance(x, y);
                                if (distance < minDistance && distance < Preset.threshold) {
                                  minDistance = distance;
                                  selected = k;
                                }
                              }
                            }

                            if (selected != null) {
                              final event = status.isComposing ? selected.composing ?? selected.click : selected.click;
                              await inputService.handleEvent(event, context);
                            }
                          }

                          setState(() {
                            _currentK = _dummy;
                          });
                        }

                        if (_longPressed) {
                          setState(() {
                            _longPressed = false;
                          });
                        }
                      }
                      ..onLongPressCancel = () {
                        if (_longPressed) {
                          setState(() {
                            _longPressed = false;
                          });
                        }
                      }
                      ..onLongPressMoveUpdate = (details) {
                        // TODO: animation
                      };
                  },
                )
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      for (final r in preset)
                        SizedBox(
                          height: r.height *
                              screenWidth *
                              (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                          child: Row(
                            children: [
                              for (final k in r)
                                if (k.highlight == Highlight.enter)
                                  SizedBox(
                                    height: k.hitBox.height *
                                        screenWidth *
                                        (constraint.orientation == Orientation.landscape
                                            ? preset.orientationFactor
                                            : 1),
                                    width: k.hitBox.width * screenWidth,
                                    child: Center(
                                      child: Builder(
                                        builder: (_) {
                                          const imeActionNone = 1;
                                          const imeActionGo = 2;
                                          const imeActionSearch = 3;
                                          const imeActionSend = 4;
                                          const imeActionNext = 5;
                                          const imeActionDone = 6;
                                          const imeActionPrevious = 7;
                                          IconData iconData;
                                          if (status.editorAction == imeActionNone) {
                                            iconData = Icons.keyboard_return;
                                          } else if (status.editorAction == imeActionGo) {
                                            iconData = Icons.arrow_right_alt;
                                          } else if (status.editorAction == imeActionSearch) {
                                            iconData = Icons.search;
                                          } else if (status.editorAction == imeActionSend) {
                                            iconData = Icons.send;
                                          } else if (status.editorAction == imeActionNext) {
                                            iconData = Icons.chevron_right;
                                          } else if (status.editorAction == imeActionDone) {
                                            iconData = Icons.done;
                                          } else if (status.editorAction == imeActionPrevious) {
                                            iconData = Icons.chevron_left;
                                          } else {
                                            iconData = Icons.keyboard_return;
                                          }
                                          return Icon(iconData);
                                        },
                                      ),
                                    ),
                                  )
                                else if (k.highlight == Highlight.shift)
                                  SizedBox(
                                    height: k.hitBox.height *
                                        screenWidth *
                                        (constraint.orientation == Orientation.landscape
                                            ? preset.orientationFactor
                                            : 1),
                                    width: k.hitBox.width * screenWidth,
                                    child: Center(
                                      child: Observer(
                                        builder: (context) {
                                          return Icon(
                                            status.shiftLock == null
                                                ? Icons.keyboard_arrow_up
                                                : status.shiftLock == false
                                                    ? Icons.keyboard_capslock
                                                    : Icons.keyboard_double_arrow_up,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                else if (k.highlight == Highlight.symbol)
                                  SizedBox(
                                    height: k.hitBox.height *
                                        screenWidth *
                                        (constraint.orientation == Orientation.landscape
                                            ? preset.orientationFactor
                                            : 1),
                                    width: k.hitBox.width * screenWidth,
                                    child: Center(
                                      child: k.icon != null
                                          ? Icon(k.icon)
                                          : Text(
                                              k.label,
                                              style: TextStyle(fontSize: preset.fontSize),
                                            ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    height: k.hitBox.height *
                                        screenWidth *
                                        (constraint.orientation == Orientation.landscape
                                            ? preset.orientationFactor
                                            : 1),
                                    width: k.hitBox.width * screenWidth,
                                    child: Center(
                                      child: k.composing == null
                                          ? k.icon != null
                                              ? Icon(k.icon)
                                              : Text(
                                                  k.label,
                                                  style: TextStyle(fontSize: preset.fontSize),
                                                )
                                          : Observer(
                                              builder: (context) {
                                                return k.icon != null
                                                    ? Icon(k.icon)
                                                    : Text(
                                                        status.isComposing ? k.composingLabel ?? k.label : k.label,
                                                        style: TextStyle(fontSize: preset.fontSize),
                                                      );
                                              },
                                            ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  // TODO: style
                  if (_currentK != _dummy)
                    if (_currentK.more == null || !_longPressed)
                      // preview
                      Positioned(
                        left: _currentK.hitBox.left * screenWidth,
                        top: (_currentK.hitBox.top - _currentK.hitBox.height) *
                            screenWidth *
                            (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Column(
                            children: [
                              if (!_currentK.functional || _longPressed && _currentK.longClickLabel != null)
                                SizedBox(
                                  height: _currentK.hitBox.height *
                                      screenWidth *
                                      (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                                  width: _currentK.hitBox.width * screenWidth,
                                  child: Center(
                                    child: _currentK.composing == null
                                        ? _longPressed && _currentK.longClickLabel != null
                                            ? Text(
                                                _currentK.longClickLabel ?? '',
                                                style: TextStyle(fontSize: preset.fontSize),
                                              )
                                            : _currentK.icon != null
                                                ? Icon(_currentK.icon)
                                                : Text(
                                                    _currentK.label,
                                                    style: TextStyle(fontSize: preset.fontSize),
                                                  )
                                        : Observer(
                                            builder: (context) {
                                              return _longPressed && _currentK.longClickLabel != null
                                                  ? Text(
                                                      _currentK.longClickLabel ?? '',
                                                      style: TextStyle(fontSize: preset.fontSize),
                                                    )
                                                  : _currentK.icon != null
                                                      ? Icon(_currentK.icon)
                                                      : Text(
                                                          status.isComposing
                                                              ? _currentK.composingLabel ?? _currentK.label
                                                              : _currentK.label,
                                                          style: TextStyle(fontSize: preset.fontSize),
                                                        );
                                            },
                                          ),
                                  ),
                                ),
                              if (!_currentK.functional)
                                SizedBox(
                                  height: _currentK.hitBox.height *
                                      screenWidth *
                                      (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                                  width: _currentK.hitBox.width * screenWidth,
                                ),
                            ],
                          ),
                        ),
                      )
                    else ...[
                      // more keys panel
                      Builder(
                        builder: (context) {
                          final more = _currentK.more!;
                          final moreBox = _currentK.moreKeysPanelBox!;

                          return Positioned(
                            left: moreBox.left * screenWidth,
                            top: moreBox.top *
                                screenWidth *
                                (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                  child: SizedBox(
                                    height: more.totalHeight *
                                        screenWidth *
                                        (constraint.orientation == Orientation.landscape
                                            ? preset.orientationFactor
                                            : 1),
                                    child: Column(
                                      children: [
                                        for (final r in more)
                                          SizedBox(
                                            height: r.height *
                                                screenWidth *
                                                (constraint.orientation == Orientation.landscape
                                                    ? preset.orientationFactor
                                                    : 1),
                                            child: Row(
                                              children: [
                                                for (final k in r)
                                                  SizedBox(
                                                    width: k.hitBox.width * screenWidth,
                                                    height: k.hitBox.height *
                                                        screenWidth *
                                                        (constraint.orientation == Orientation.landscape
                                                            ? preset.orientationFactor
                                                            : 1),
                                                    child: Center(
                                                      child: Text(
                                                        k.label,
                                                        style: TextStyle(fontSize: k.preset.fontSize),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: _currentK.hitBox.left * screenWidth,
                        top: _currentK.hitBox.top *
                            screenWidth *
                            (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: SizedBox(
                            height: _currentK.hitBox.height *
                                screenWidth *
                                (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1),
                            width: _currentK.hitBox.width * screenWidth,
                          ),
                        ),
                      ),
                    ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
