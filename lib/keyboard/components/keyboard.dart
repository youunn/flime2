import 'package:flime/api/platform_api.g.dart';
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
  K? currentK;

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
                    instance
                      ..onTapDown = (details) async {
                        final k = await widget.preset.detectKey(details.localPosition, screenWidth);
                        if (k != null) {
                          setState(() {
                            currentK = k;
                          });
                        }
                      }
                      ..onTapUp = (details) async {
                        final k = currentK;
                        if (k != null) {
                          if (k.click.code != null) {
                            if (inputService.processKey(k.click.code!, k.click.mask)) {
                              final commit = inputService.getCommit();
                              if (commit != '') {
                                await inputConnectionApi.commit(commit);
                              }
                            } else {
                              await inputConnectionApi.send(k.click.androidCode!, k.click.androidMask);
                            }
                          }
                          setState(() {
                            currentK = null;
                          });
                        }
                      };
                  },
                ),
                LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
                  () => LongPressGestureRecognizer(),
                  (instance) {},
                )
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
                  if (currentK != null)
                    () {
                      final k = currentK;
                      if (k == null) return Container();
                      return Positioned(
                        left: k.hitBox.left * screenWidth,
                        top: (k.hitBox.top - k.hitBox.height) * screenWidth,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: k.hitBox.height * screenWidth,
                                width: k.hitBox.width * screenWidth,
                                child: Center(
                                  child: Text(
                                    k.label,
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: k.hitBox.height * screenWidth,
                                width: k.hitBox.width * screenWidth,
                              ),
                            ],
                          ),
                        ),
                      );
                    }(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/*

 */
