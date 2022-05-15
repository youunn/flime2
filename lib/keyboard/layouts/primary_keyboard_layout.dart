import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
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
    height: 63,
    fontSize: 26,
  )
    // 第一行
    ..r(
      (r) => r
        ..c(Lk.keyQ)
        ..c(Lk.keyW)
        ..c(Lk.keyE)
        ..c(Lk.keyR)
        ..c(Lk.keyT)
        ..c(Lk.keyY)
        ..c(Lk.keyU)
        ..c(Lk.keyI)
        ..c(Lk.keyO)
        ..c(Lk.keyP),
    )
    // 第二行
    ..r(
      (r) => r
        ..c(Lk.keyA, label: '', width: 0.05)
        ..c(Lk.keyA)
        ..c(Lk.keyS)
        ..c(Lk.keyD)
        ..c(Lk.keyF)
        ..c(Lk.keyG)
        ..c(Lk.keyH)
        ..c(Lk.keyJ)
        ..c(Lk.keyK)
        ..c(Lk.keyL)
        ..c(Lk.keyL, label: '', width: 0.05),
    )
    // 第三行
    ..r(
      (r) => r
        ..c(Lk.shift, width: 0.15)
        ..c(Lk.keyZ)
        ..c(Lk.keyX)
        ..c(Lk.keyC)
        ..c(Lk.keyV)
        ..c(Lk.keyB)
        ..c(Lk.keyN)
        ..c(Lk.keyM)
        ..c(Lk.backspace, width: 0.15),
    )
    // 第四行
    ..r(
      (r) => r
        ..k(
          click: KEvent(command: Command()),
          label: '123',
          width: 0.18,
        )
        ..c(Lk.comma, width: 0.18)
        ..c(Lk.space, label: '', width: 0.34)
        ..c(Lk.period, width: 0.14)
        ..c(Lk.enter, label: '→', width: 0.16),
      height: 75,
    );
}
