import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flutter/material.dart';

class SymbolKeyboardLayout extends StatelessWidget {
  const SymbolKeyboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainKeyboard(
      preset: _preset,
    );
  }

  static final _preset = Preset(
    width: 0.23,
    height: 0.15,
    fontSize: 26,
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
        ..c(Lk.colon)
        ..c(Lk.digit0)
        ..c(Lk.period)
        ..c(Lk.enter, label: 'Enter', width: 0.16),
      height: 0.18,
    )
    ..cache();
}
