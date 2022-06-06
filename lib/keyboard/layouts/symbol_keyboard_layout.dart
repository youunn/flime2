import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
import 'package:flime/keyboard/components/keyboard_wrapper.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flutter/material.dart';

class SymbolKeyboardLayout extends StatelessWidget {
  const SymbolKeyboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardWrapper(
      child: Keyboard(
        preset: _preset,
      ),
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
        ..c(Lk.digit1, longClick: Lk.exclamation)
        ..c(Lk.digit2, longClick: Lk.at)
        ..c(Lk.digit3, longClick: Lk.numberSign)
        ..c(Lk.digit4, longClick: Lk.dollar)
        ..c(Lk.digit5, longClick: Lk.percent)
        ..c(Lk.digit6, longClick: Lk.caret)
        ..c(Lk.digit7, longClick: Lk.ampersand)
        ..c(Lk.digit8, longClick: Lk.asterisk)
        ..c(Lk.digit9, longClick: Lk.parenthesisLeft)
        ..c(Lk.digit0, longClick: Lk.parenthesisRight),
    )
    // 第二行
    ..r(
      (r) => r
        ..c(Lk.backquote, label: '', width: 0.05)
        ..c(Lk.backquote)
        ..c(Lk.minus)
        ..c(Lk.underscore)
        ..c(Lk.equal)
        ..c(Lk.add)
        ..c(Lk.quoteSingle)
        ..c(Lk.quote)
        ..c(Lk.semicolon)
        ..c(Lk.colon)
        ..c(Lk.colon, label: '', width: 0.05),
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
        ..c(Lk.tilde)
        ..c(Lk.bracketLeft)
        ..c(Lk.bracketRight)
        ..c(Lk.braceLeft)
        ..c(Lk.braceRight)
        ..c(Lk.question)
        ..c(
          Lk.slash,
          more: MoreKeysPanel(
            width: 0.1,
            height: 0.15,
            fontSize: 22,
            orientationFactor: 0.45,
            padding: 0.01,
            radius: 0.075,
          )..r(
              (r) => r
                ..c(Lk.backslash)
                ..c(Lk.bar),
            ),
        )
        ..c(Lk.backspace, icon: Icons.backspace_outlined, repeatable: true, width: 0.15),
    )
    // 第四行
    ..r(
      (r) => r
        ..k(
          click: KEvent(
            command: (context, _) {
              context.router.navigate(const PrimaryKeyboardRoute());
            },
          ),
          longClick: KEvent(
            command: (context, _) {
              context.router.replace(
                const ExtendedRoute(
                  children: [
                    FullKeyboardRoute(),
                  ],
                ),
              );
            },
          ),
          label: '',
          icon: Icons.abc,
          width: 0.18,
          functional: true,
        )
        ..c(Lk.comma, longClick: Lk.less, width: 0.18)
        ..c(Lk.space, label: '', repeatable: true, width: 0.34, functional: true, highlight: Highlight.space)
        ..c(Lk.period, longClick: Lk.greater, width: 0.14)
        ..c(Lk.enter, label: 'Enter', highlight: Highlight.enter, functional: true, width: 0.16),
      height: 0.18,
    )
    // 初始化
    ..cache();
}
