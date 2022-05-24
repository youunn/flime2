import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flutter/material.dart';

class NumberKeyboardLayout extends StatelessWidget {
  const NumberKeyboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Keyboard(
      preset: _preset,
      landscapePreset: _landscapePreset,
    );
  }

  static final _preset = Preset(
    width: 0.23,
    height: 0.15,
    fontSize: 26,
    orientationFactor: 0.45,
  )
    ..r(
      (r) => r
        ..c(Lk.add, width: 0.15)
        ..c(Lk.digit1)
        ..c(Lk.digit2)
        ..c(Lk.digit3)
        ..c(Lk.slash, width: 0.16),
    )
    ..r(
      (r) => r
        ..c(Lk.minus, width: 0.15)
        ..c(Lk.digit4)
        ..c(Lk.digit5)
        ..c(Lk.digit6)
        ..c(Lk.space, repeatable: true, icon: Icons.space_bar, width: 0.16),
    )
    ..r(
      (r) => r
        ..c(Lk.asterisk, width: 0.15)
        ..c(Lk.digit7)
        ..c(Lk.digit8)
        ..c(Lk.digit9)
        ..c(Lk.backspace, repeatable: true, icon: Icons.backspace_outlined, label: 'Back', width: 0.16),
    )
    ..r(
      (r) => r
        ..k(
          click: KEvent(
            command: (context, _) {
              context.router.replace(const PrimaryKeyboardRoute());
            },
          ),
          label: '',
          icon: Icons.abc,
          functional: true,
          width: 0.15,
        )
        ..c(Lk.colon)
        ..c(Lk.digit0)
        ..c(Lk.period)
        ..c(Lk.enter, label: 'Enter', functional: true, highlight: Highlight.enter, width: 0.16),
      height: 0.18,
    )
    ..cache();

  static final _landscapePreset = Preset(
    width: 0.23,
    height: 0.0675,
    fontSize: 26,
    orientationFactor: 1,
  )
    ..r(
      (r) => r
        ..c(Lk.add, width: 0.15)
        ..c(Lk.digit1)
        ..c(Lk.digit2)
        ..c(Lk.digit3)
        ..c(Lk.slash, width: 0.16),
    )
    ..r(
      (r) => r
        ..c(Lk.minus, width: 0.15)
        ..c(Lk.digit4)
        ..c(Lk.digit5)
        ..c(Lk.digit6)
        ..c(Lk.space, width: 0.16),
    )
    ..r(
      (r) => r
        ..c(Lk.asterisk, width: 0.15)
        ..c(Lk.digit7)
        ..c(Lk.digit8)
        ..c(Lk.digit9)
        ..c(Lk.backspace, repeatable: true, label: 'Back', width: 0.16),
    )
    ..r(
      (r) => r
        ..k(
          click: KEvent(
            command: (context, _) {
              context.router.replace(const PrimaryKeyboardRoute());
            },
          ),
          label: 'abc',
          width: 0.15,
        )
        ..c(Lk.digit0)
        ..c(Lk.colon)
        ..c(Lk.period)
        ..c(Lk.enter, label: 'Enter', width: 0.16),
      height: 0.81,
    )
    ..cache();
}
