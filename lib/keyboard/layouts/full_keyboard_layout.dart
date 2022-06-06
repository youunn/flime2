import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
import 'package:flime/keyboard/components/keyboard_wrapper.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flutter/material.dart';

class FullKeyboardLayout extends StatelessWidget {
  const FullKeyboardLayout({Key? key}) : super(key: key);

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
    height: 0.13,
    fontSize: 20,
    orientationFactor: 0.45,
  )
    // 扩展行
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
    // 第一行
    ..r(
      (r) => r
        ..c(Sl.keyQ, longClick: Lk.tilde)
        ..c(Sl.keyW, longClick: Lk.tab)
        ..c(Sl.keyE, longClick: Lk.escape)
        ..c(Sl.keyR, longClick: Lk.less)
        ..c(Sl.keyT, longClick: Lk.greater)
        ..c(Sl.keyY, longClick: Lk.braceLeft)
        ..c(Sl.keyU, longClick: Lk.braceRight)
        ..c(Sl.keyI, longClick: Lk.bracketLeft)
        ..c(Sl.keyO, longClick: Lk.bracketRight)
        ..c(Sl.keyP, longClick: Lk.bar),
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
              context.router.navigate(const FunctionalKeyboardRoute());
            },
          ),
          longClick: KEvent(
            command: (context, _) {
              context.router.replace(
                const MainRoute(
                  children: [
                    PrimaryKeyboardRoute(),
                  ],
                ),
              );
            },
          ),
          label: '',
          icon: Icons.onetwothree,
          width: 0.15,
          functional: true,
        )
        ..k(
          click: KEvent(
            command: (_, status) {
              if (status.controlLock != null) {
                status.controlLock = null;
              } else {
                status
                  ..setModifier(KEvent.modifierControl, state: true)
                  ..controlLock = false;
              }
            },
          ),
          label: 'Ctrl',
          functional: true,
          highlight: Highlight.control,
        )
        ..k(
          click: KEvent(
            command: (_, status) {
              if (status.metaLock != null) {
                status.metaLock = null;
              } else {
                status
                  ..setModifier(KEvent.modifierMeta, state: true)
                  ..metaLock = false;
              }
            },
          ),
          label: 'Super',
          functional: true,
          highlight: Highlight.meta,
        )
        ..k(
          click: KEvent(
            command: (_, status) {
              if (status.altLock != null) {
                status.altLock = null;
              } else {
                status
                  ..setModifier(KEvent.modifierAlt, state: true)
                  ..altLock = false;
              }
            },
          ),
          label: 'Alt',
          functional: true,
          highlight: Highlight.alt,
        )
        ..c(Lk.space, label: '', repeatable: true, width: 0.20, functional: true, highlight: Highlight.space)
        ..c(Lk.comma, width: 0.10, composing: KEvent(key: Lk.semicolon))
        ..c(Lk.period, width: 0.10, composing: KEvent(key: Lk.quoteSingle))
        ..c(Lk.enter, label: 'Enter', highlight: Highlight.enter, functional: true, width: 0.15),
      height: 0.18,
    )
    // 初始化
    ..cache();
}
