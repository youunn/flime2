import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flutter/material.dart';

class PrimaryKeyboardLayout extends StatelessWidget {
  const PrimaryKeyboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainKeyboard(
      preset: _preset,
    );
  }

  static final _preset = Preset(
    width: 0.1,
    height: 0.15,
    fontSize: 26,
  )
    // 第一行
    ..r(
      (r) => r
        ..c(Sl.keyQ, longClick: Lk.digit1)
        ..c(Sl.keyW, longClick: Lk.digit2)
        ..c(Sl.keyE, longClick: Lk.digit3)
        ..c(Sl.keyR, longClick: Lk.digit4)
        ..c(Sl.keyT, longClick: Lk.digit5)
        ..c(Sl.keyY, longClick: Lk.digit6)
        ..c(Sl.keyU, longClick: Lk.digit7)
        ..c(Sl.keyI, longClick: Lk.digit8)
        ..c(Sl.keyO, longClick: Lk.digit9)
        ..c(Sl.keyP, longClick: Lk.digit0),
    )
    // 第二行
    ..r(
      (r) => r
        ..c(Sl.keyA, longClick: Lk.exclamation, label: '', width: 0.05)
        ..c(Sl.keyA, longClick: Lk.exclamation)
        ..c(Sl.keyS, longClick: Lk.minus)
        ..c(Sl.keyD, longClick: Lk.underscore)
        ..c(Sl.keyF, longClick: Lk.equal)
        ..c(Sl.keyG, longClick: Lk.add)
        ..c(Sl.keyH, longClick: Lk.quoteSingle)
        ..c(Sl.keyJ, longClick: Lk.quote)
        ..c(Sl.keyK, longClick: Lk.semicolon)
        ..c(Sl.keyL, longClick: Lk.colon)
        ..c(Sl.keyL, longClick: Lk.colon, label: '', width: 0.05),
    )
    // 第三行
    ..r(
      (r) => r
        ..k(
            click: KEvent(
              command: (_, status) {
                status.setModifier(KEvent.modifierShift, state: !status.hasModifier(KEvent.modifierShift));
              },
            ),
            label: 'Shift',
            width: 0.15)
        ..c(Sl.keyZ)
        ..c(Sl.keyX)
        ..c(Sl.keyC)
        ..c(Sl.keyV)
        ..c(Sl.keyB, longClick: Lk.backslash)
        ..c(Sl.keyN, longClick: Lk.question)
        ..c(Sl.keyM, longClick: Lk.slash)
        ..c(Lk.backspace, label: 'Back', repeatable: true, width: 0.15),
    )
    // 第四行
    ..r(
      (r) => r
        ..k(
          click: KEvent(
            command: (context, _) {
              // TODO: animation
              context.router.replace(const NumberKeyboardRoute());
            },
          ),
          label: '123',
          width: 0.18,
        )
        ..c(Lk.comma, width: 0.18)
        ..c(Lk.space, label: '', repeatable: true, width: 0.34)
        ..c(
          Lk.period,
          width: 0.14,
          more: MoreKeysPanel(width: 0.1, height: 0.15, fontSize: 26)
            ..r(
              (r) => r
                ..c(Lk.at)
                ..c(Lk.numberSign)
                ..c(Lk.dollar)
                ..c(Lk.percent)
                ..c(Lk.caret)
                ..c(Lk.ampersand)
                ..c(Lk.asterisk)
                ..c(Lk.parenthesisLeft)
                ..c(Lk.parenthesisRight),
            )
            ..r(
              (r) => r
                ..c(Lk.backquote)
                ..c(Lk.tilde)
                ..c(Lk.less)
                ..c(Lk.greater)
                ..c(Lk.bracketLeft)
                ..c(Lk.bracketRight)
                ..c(Lk.braceLeft)
                ..c(Lk.braceRight)
                ..c(Lk.bar),
            ),
        )
        ..c(Lk.enter, label: 'Enter', width: 0.16),
      height: 0.18,
    )
    // 初始化
    ..cache();
}
