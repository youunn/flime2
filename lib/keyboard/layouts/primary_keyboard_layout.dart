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
    return Keyboard(
      preset: _preset,
    );
  }

  static final _preset = Preset(
    width: 0.1,
    height: 0.15,
    fontSize: 26,
    orientationFactor: 0.45,
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
        ..c(Sl.keyA, longClick: Lk.backquote, label: '', width: 0.05)
        ..c(Sl.keyA, longClick: Lk.backquote)
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
              if (status.shiftLock == true) {
                status
                  ..setModifier(KEvent.modifierShift, state: false)
                  ..shiftLock = null;
              } else if (status.shiftLock == false) {
                status.shiftLock = true;
              } else {
                status
                  ..setModifier(KEvent.modifierShift, state: true)
                  ..shiftLock = false;
              }
            },
          ),
          label: 'Shift',
          width: 0.15,
          functional: true,
          highlight: Highlight.shift,
        )
        ..k(
          click: KEvent(key: Sl.keyZ),
          label: 'z',
          longClick: KEvent(key: Sl.keyA, mask: KEvent.modifierControl),
          longClickLabel: 'V',
        )
        ..k(
          click: KEvent(key: Sl.keyX),
          label: 'x',
          longClick: KEvent(key: Sl.keyX, mask: KEvent.modifierControl),
          longClickLabel: 'D',
        )
        ..k(
          click: KEvent(key: Sl.keyC),
          label: 'c',
          longClick: KEvent(key: Sl.keyC, mask: KEvent.modifierControl),
          longClickLabel: 'Y',
        )
        ..k(
          click: KEvent(key: Sl.keyV),
          label: 'v',
          longClick: KEvent(key: Sl.keyV, mask: KEvent.modifierControl),
          longClickLabel: 'P',
        )
        ..c(Sl.keyB, longClick: Lk.backslash)
        ..c(Sl.keyN, longClick: Lk.question)
        ..c(Sl.keyM, longClick: Lk.slash)
        ..c(Lk.backspace, icon: Icons.backspace_outlined, repeatable: true, width: 0.15),
    )
    // 第四行
    ..r(
      (r) => r
        ..k(
          click: KEvent(
            command: (context, _) {
              // TODO: animation
              context.router.replace(const SymbolKeyboardRoute());
            },
          ),
          longClick: KEvent(
            command: (context, _) {
              context.router.replace(const NumberKeyboardRoute());
            },
          ),
          label: '',
          icon: Icons.onetwothree,
          width: 0.18,
          functional: true,
        )
        ..c(Lk.comma, width: 0.18, composing: KEvent(key: Lk.semicolon))
        ..c(Lk.space, label: '', repeatable: true, width: 0.34, functional: true, highlight: Highlight.space)
        ..c(
          Lk.period,
          width: 0.14,
          more: MoreKeysPanel(
            width: 0.1,
            height: 0.15,
            fontSize: 22,
            orientationFactor: 0.45,
            padding: 0.01,
            radius: 0.075,
          )
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
                ..c(Lk.exclamation)
                ..c(Lk.tilde)
                ..c(Lk.less)
                ..c(Lk.greater)
                ..c(Lk.bracketLeft)
                ..c(Lk.bracketRight)
                ..c(Lk.braceLeft)
                ..c(Lk.braceRight)
                ..c(Lk.bar),
            ),
          composing: KEvent(key: Lk.quoteSingle),
        )
        ..c(Lk.enter, label: 'Enter', highlight: Highlight.enter, functional: true, width: 0.16),
      height: 0.18,
    )
    // 初始化
    ..cache();
}
