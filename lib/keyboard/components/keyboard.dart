import 'package:flime/api/platform_api.g.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainKeyboard extends StatefulWidget {
  final Preset preset;

  const MainKeyboard({Key? key, required this.preset}) : super(key: key);

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
    return Consumer3<SettingsStore, InputService, InputConnectionApi>(
      builder: (_, settings, inputService, inputConnectionApi, child) {
        return Observer(
          builder: (_) {
            // TODO: replace with custom RenderObject
            return RawGestureDetector(
              behavior: HitTestBehavior.translucent,
              gestures: {
                TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                  () => TapGestureRecognizer(),
                  (instance) {
                    instance.onTapUp = (details) async {
                      final k = _currentK;
                      if (k != _dummy) {
                        await processKey(k.click, inputService, inputConnectionApi);
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
                        final k = await widget.preset.detectKey(details.localPosition, screenWidth);
                        if (k != null) {
                          setState(() {
                            _currentK = k;
                          });
                        }
                      }
                      ..onLongPressStart = (details) {
                        setState(() {
                          _longPressed = true;
                        });
                      }
                      ..onLongPressEnd = (details) async {
                        final k = _currentK;
                        if (k != _dummy) {
                          final more = k.more;
                          final moreBox = k.moreKeysPanelBox;
                          if (more == null || moreBox == null) {
                            await processKey(k.longClick ?? k.click, inputService, inputConnectionApi);
                          } else {
                            // TODO: extract method or use detectKey
                            var minDistance = double.maxFinite;
                            K? selected;
                            final x = details.localPosition.dx / screenWidth - moreBox.left;
                            final y = details.localPosition.dy / screenWidth - moreBox.top;
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
                              await processKey(selected.click, inputService, inputConnectionApi);
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
              child: child,
            );
          },
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              for (final r in widget.preset)
                SizedBox(
                  height: r.height * screenWidth,
                  child: Row(
                    children: [
                      for (final k in r)
                        SizedBox(
                          height: k.hitBox.height * screenWidth,
                          width: k.hitBox.width * screenWidth,
                          child: Center(
                            child: Text(
                              k.label,
                              style: TextStyle(fontSize: widget.preset.fontSize),
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
              Positioned(
                left: _currentK.hitBox.left * screenWidth,
                top: (_currentK.hitBox.top - _currentK.hitBox.height) * screenWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _currentK.hitBox.height * screenWidth,
                        width: _currentK.hitBox.width * screenWidth,
                        child: Center(
                          child: Text(
                            _longPressed ? _currentK.longClickLabel ?? _currentK.label : _currentK.label,
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _currentK.hitBox.height * screenWidth,
                        width: _currentK.hitBox.width * screenWidth,
                      ),
                    ],
                  ),
                ),
              )
            else
              Builder(
                builder: (BuildContext context) {
                  final more = _currentK.more!;
                  final moreBox = _currentK.moreKeysPanelBox!;

                  return Positioned(
                    left: moreBox.left * screenWidth,
                    top: moreBox.top * screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: SizedBox(
                            height: more.totalHeight * screenWidth,
                            child: Column(
                              children: [
                                for (final r in more)
                                  SizedBox(
                                    height: r.height * screenWidth,
                                    child: Row(
                                      children: [
                                        for (final k in r)
                                          SizedBox(
                                            width: k.hitBox.width * screenWidth,
                                            height: k.hitBox.height * screenWidth,
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
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: SizedBox(
                            height: _currentK.hitBox.height * screenWidth,
                            width: _currentK.hitBox.width * screenWidth,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }

  Future<void> processKey(KEvent event, InputService inputService, InputConnectionApi inputConnectionApi) async {
    if (event.code != null) {
      if (inputService.processKey(event.code!, event.mask)) {
        final commit = inputService.getCommit();
        if (commit != '') {
          await inputConnectionApi.commit(commit);
        }
      } else {
        await inputConnectionApi.send(event.androidCode!, event.androidMask);
      }
    }
  }
}
