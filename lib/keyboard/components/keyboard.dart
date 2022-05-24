import 'dart:async';
import 'dart:math';

import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flime/keyboard/stores/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Keyboard extends StatefulWidget {
  final Preset preset;
  final Preset? landscapePreset;

  const Keyboard({Key? key, required this.preset, this.landscapePreset}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  late K _dummy;
  late K _currentK;
  late K _selectedK;
  var _longPressed = false;

  @override
  void initState() {
    super.initState();
    _dummy = K.dummy(widget.preset);
    _currentK = _dummy;
    _selectedK = _dummy;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer4<SettingsStore, ConstraintStore, KeyboardStatus, InputService>(
      builder: (_, settings, constraint, status, inputService, child) {
        // 有点偷懒
        return RawGestureDetector(
          behavior: HitTestBehavior.translucent,
          gestures: {
            TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (instance) {
                instance
                  ..onTapUp = (details) async {
                    final preset = constraint.orientation == Orientation.landscape
                        ? widget.landscapePreset ?? widget.preset
                        : widget.preset;
                    final k = await preset.detectKey(
                      details.localPosition,
                      screenWidth,
                      orientation: constraint.orientation,
                    );
                    if (k != null) {
                      setState(() {
                        _currentK = k;
                      });

                      final event = status.isComposing ? k.composing ?? k.click : k.click;
                      await inputService.handleEvent(event, this.context);
                      setState(() {
                        _currentK = _dummy;
                      });
                    }
                  }
                  ..onTapCancel = () {
                    final k = _currentK;
                    if (k != _dummy) {
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
                    final preset = constraint.orientation == Orientation.landscape
                        ? widget.landscapePreset ?? widget.preset
                        : widget.preset;
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
                  ..onLongPressStart = (details) async {
                    final preset = constraint.orientation == Orientation.landscape
                        ? widget.landscapePreset ?? widget.preset
                        : widget.preset;
                    final k = await preset.detectKey(
                      details.localPosition,
                      screenWidth,
                      orientation: constraint.orientation,
                    );
                    if (k != null) {
                      setState(() {
                        _currentK = k;
                      });

                      setState(() {
                        _longPressed = true;
                      });

                      if (k.repeatable) {
                        while (_longPressed) {
                          final event = status.isComposing ? k.composing ?? k.click : k.click;
                          await inputService.handleEvent(event, this.context);
                          await Future.delayed(settings.repeatInterval);
                        }
                      } else {
                        final more = k.more;
                        final box = k.moreKeysPanelBox;
                        if (more != null && box != null) {
                          var minDistance = double.maxFinite;
                          K? selected;

                          final orientationFactor =
                              constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1;
                          final x = details.localPosition.dx / screenWidth - box.left - more.padding;
                          final y =
                              details.localPosition.dy / (screenWidth * orientationFactor) - box.top - more.padding;
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
                            setState(() {
                              _selectedK = selected!;
                            });
                          }
                        }
                      }
                    }
                  }
                  ..onLongPressEnd = (details) async {
                    final k = _currentK;

                    if (k != _dummy) {
                      final selected = _selectedK;
                      if (selected != _dummy) {
                        final event = status.isComposing ? selected.composing ?? selected.click : selected.click;
                        await inputService.handleEvent(event, context);
                        setState(() {
                          _selectedK = _dummy;
                        });
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
                    final ck = _currentK;
                    if (ck != _dummy) {
                      setState(() {
                        _currentK = _dummy;
                      });
                    }
                    final sk = _selectedK;
                    if (sk != _dummy) {
                      setState(() {
                        _selectedK = _dummy;
                      });
                    }
                  }
                  ..onLongPressMoveUpdate = (details) {
                    final preset = constraint.orientation == Orientation.landscape
                        ? widget.landscapePreset ?? widget.preset
                        : widget.preset;
                    final k = _currentK;
                    final more = k.more;
                    final box = k.moreKeysPanelBox;
                    if (k == _dummy || k.repeatable || more == null || box == null) return;

                    var minDistance = double.maxFinite;
                    K? selected;

                    final orientationFactor =
                        constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1;
                    final x = details.localPosition.dx / screenWidth - box.left - more.padding;
                    final y = details.localPosition.dy / (screenWidth * orientationFactor) - box.top - more.padding;
                    for (final r in more) {
                      for (final k in r.keys) {
                        final distance = k.getSquaredDistance(x, y);
                        if (distance < minDistance && distance < Preset.threshold) {
                          minDistance = distance;
                          selected = k;
                        }
                      }
                    }

                    // cancel long press
                    if (selected == null) {
                      if (_longPressed) {
                        setState(() {
                          _longPressed = false;
                        });
                      }
                      if (k != _dummy) {
                        setState(() {
                          _currentK = _dummy;
                        });
                      }
                    } else {
                      if (_selectedK != selected) {
                        setState(() {
                          _selectedK = selected!;
                        });
                      }
                    }
                  };
              },
            )
          },
          child: Observer(
            builder: (context) {
              final preset = constraint.orientation == Orientation.landscape
                  ? widget.landscapePreset ?? widget.preset
                  : widget.preset;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // keyboard
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
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: k.hitBox.height *
                                            screenWidth *
                                            (constraint.orientation == Orientation.landscape
                                                ? preset.orientationFactor
                                                : 1) *
                                            2 /
                                            3,
                                        width: k.hitBox.width * screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                          ),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondaryContainer,
                                              borderRadius: BorderRadius.circular(
                                                k.hitBox.height *
                                                    screenWidth *
                                                    (constraint.orientation == Orientation.landscape
                                                        ? preset.orientationFactor
                                                        : 1) /
                                                    2 *
                                                    (2 / 3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: k.hitBox.height *
                                            screenWidth *
                                            (constraint.orientation == Orientation.landscape
                                                ? preset.orientationFactor
                                                : 1),
                                        width: k.hitBox.width * screenWidth,
                                        child: Center(
                                          child: Builder(
                                            builder: (context) {
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
                                              return Icon(
                                                iconData,
                                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
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
                                else if (k.highlight == Highlight.space)
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: k.hitBox.height *
                                            screenWidth *
                                            (constraint.orientation == Orientation.landscape
                                                ? preset.orientationFactor
                                                : 1) *
                                            2 /
                                            3,
                                        width: k.hitBox.width * screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                          ),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.background,
                                              borderRadius: BorderRadius.circular(
                                                k.hitBox.height *
                                                    screenWidth *
                                                    (constraint.orientation == Orientation.landscape
                                                        ? preset.orientationFactor
                                                        : 1) /
                                                    2 *
                                                    (2 / 3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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
                                      ),
                                    ],
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
                  if (_currentK != _dummy)
                    if (_currentK.more == null || !_longPressed)
                      // preview
                      Builder(
                        builder: (context) {
                          final width = _currentK.hitBox.width * screenWidth;
                          final height = _currentK.hitBox.height *
                              screenWidth *
                              (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1);
                          final left = _currentK.hitBox.left * screenWidth;
                          final top = (_currentK.hitBox.top - _currentK.hitBox.height) *
                              screenWidth *
                              (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1);
                          return Positioned(
                            left: left,
                            top: top,
                            child: Column(
                              children: [
                                if (!_currentK.functional)
                                  SizedOverflowBox(
                                    alignment: Alignment.center,
                                    size: Size(width, height),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.background,
                                            borderRadius: BorderRadius.circular(height / 2),
                                          ),
                                          child: SizedBox(
                                            height: height,
                                            width: max(width, height),
                                          ),
                                        ),
                                        _currentK.composing == null
                                            ? _currentK.icon != null
                                                ? Icon(_currentK.icon)
                                                : Text(
                                                    _currentK.label,
                                                    style: TextStyle(fontSize: preset.fontSize),
                                                  )
                                            : Observer(
                                                builder: (context) {
                                                  return _currentK.icon != null
                                                      ? Icon(_currentK.icon)
                                                      : Text(
                                                          status.isComposing
                                                              ? _currentK.composingLabel ?? _currentK.label
                                                              : _currentK.label,
                                                          style: TextStyle(fontSize: preset.fontSize),
                                                        );
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                if (!_currentK.functional)
                                  SizedBox(
                                    height: height,
                                    width: width,
                                    child: Center(
                                      child: _currentK.composing == null
                                          ? _currentK.icon != null
                                              ? Icon(
                                                  _currentK.icon,
                                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                                )
                                              : Text(
                                                  _currentK.label,
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.surfaceVariant,
                                                    fontSize: preset.fontSize,
                                                  ),
                                                )
                                          : Observer(
                                              builder: (context) {
                                                return _currentK.icon != null
                                                    ? Icon(
                                                        _currentK.icon,
                                                        color: Theme.of(context).colorScheme.surfaceVariant,
                                                      )
                                                    : Text(
                                                        status.isComposing
                                                            ? _currentK.composingLabel ?? _currentK.label
                                                            : _currentK.label,
                                                        style: TextStyle(
                                                          fontSize: preset.fontSize,
                                                          color: Theme.of(context).colorScheme.surfaceVariant,
                                                        ),
                                                      );
                                              },
                                            ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      )
                    else ...[
                      // more keys panel
                      Builder(
                        builder: (context) {
                          final more = _currentK.more!;
                          final moreBox = _currentK.moreKeysPanelBox!;
                          final left = moreBox.left * screenWidth;
                          final factor = screenWidth *
                              (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1);
                          final top = moreBox.top * factor;
                          final height = _currentK.hitBox.height * factor;
                          final width = _currentK.hitBox.width * screenWidth;

                          return Positioned(
                            left: left,
                            top: top,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(more.radius * screenWidth),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  SizedOverflowBox(
                                    size: Size(width, height),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.background,
                                        borderRadius: BorderRadius.circular(height / 2),
                                      ),
                                      child: SizedBox(
                                        height: height,
                                        width: max(height, width),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(more.padding * screenWidth),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: more.totalHeight * factor,
                                          child: Column(
                                            children: [
                                              for (final r in more)
                                                SizedBox(
                                                  height: r.height * factor,
                                                  child: Row(
                                                    children: [
                                                      for (final k in r)
                                                        SizedBox(
                                                          width: k.hitBox.width * screenWidth,
                                                          height: k.hitBox.height * factor,
                                                          child: Center(
                                                            child: Text(
                                                              k.label,
                                                              style: TextStyle(fontSize: k.preset.fontSize),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final k = _selectedK;
                                            final left = k.hitBox.left * screenWidth;
                                            final top = k.hitBox.top *
                                                screenWidth *
                                                (constraint.orientation == Orientation.landscape
                                                    ? preset.orientationFactor
                                                    : 1);
                                            return AnimatedPositioned(
                                              left: left,
                                              top: top,
                                              curve: Curves.fastOutSlowIn,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              child: SizedBox(
                                                width: k.hitBox.width * screenWidth,
                                                height: k.hitBox.height * factor,
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  alignment: Alignment.center,
                                                  children: [
                                                    DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                                        borderRadius: BorderRadius.circular(
                                                          min(
                                                                k.hitBox.width * screenWidth,
                                                                k.hitBox.height * factor,
                                                              ) /
                                                              2,
                                                        ),
                                                      ),
                                                      child: SizedBox.square(
                                                        dimension: min(
                                                          k.hitBox.width * screenWidth,
                                                          k.hitBox.height * factor,
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        k.label,
                                                        style: TextStyle(
                                                          fontSize: k.preset.fontSize + 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final k = _selectedK;
                                            final left = k.hitBox.left * screenWidth;
                                            final top = k.hitBox.top *
                                                screenWidth *
                                                (constraint.orientation == Orientation.landscape
                                                    ? preset.orientationFactor
                                                    : 1);
                                            return Positioned(
                                              left: left,
                                              top: top,
                                              child: SizedBox(
                                                width: k.hitBox.width * screenWidth,
                                                height: k.hitBox.height * factor,
                                                child: Center(
                                                  child: Text(
                                                    k.label,
                                                    style: TextStyle(
                                                      fontSize: k.preset.fontSize + 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Builder(
                        builder: (context) {
                          final factor = screenWidth *
                              (constraint.orientation == Orientation.landscape ? preset.orientationFactor : 1);
                          final left = _currentK.hitBox.left * screenWidth;
                          final top = _currentK.hitBox.top * factor;
                          final width = _currentK.hitBox.width * screenWidth;
                          final height = _currentK.hitBox.height * factor;
                          final label =
                              status.isComposing ? _currentK.composingLabel ?? _currentK.label : _currentK.label;
                          return Positioned(
                            left: left,
                            top: top,
                            child: SizedBox(
                              height: height,
                              width: width,
                              child: Center(
                                child: _currentK.composing == null
                                    ? _currentK.icon != null
                                        ? Icon(
                                            _currentK.icon,
                                            color: Theme.of(context).colorScheme.surfaceVariant,
                                          )
                                        : Text(
                                            _currentK.label,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.surfaceVariant,
                                              fontSize: preset.fontSize,
                                            ),
                                          )
                                    : Observer(
                                        builder: (context) {
                                          return _currentK.icon != null
                                              ? Icon(
                                                  _currentK.icon,
                                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                                )
                                              : Text(
                                                  label,
                                                  style: TextStyle(
                                                    fontSize: preset.fontSize,
                                                    color: Theme.of(context).colorScheme.surfaceVariant,
                                                  ),
                                                );
                                        },
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                ],
              );
            },
          ),
        );
      },
    );
  }
}
