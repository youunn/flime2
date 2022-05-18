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
    height: 0.15,
    fontSize: 26,
  )
    // 第一行
    ..r(
      (r) => r
        ..c(Sl.keyQ)
        ..c(Sl.keyW)
        ..c(Sl.keyE)
        ..c(Sl.keyR)
        ..c(Sl.keyT)
        ..c(Sl.keyY)
        ..c(Sl.keyU)
        ..c(Sl.keyI)
        ..c(Sl.keyO)
        ..c(Sl.keyP),
    )
    // 第二行
    ..r(
      (r) => r
        ..c(Sl.keyA, label: '', width: 0.05)
        ..c(Sl.keyA)
        ..c(Sl.keyS)
        ..c(Sl.keyD)
        ..c(Sl.keyF)
        ..c(Sl.keyG)
        ..c(Sl.keyH)
        ..c(Sl.keyJ)
        ..c(Sl.keyK)
        ..c(Sl.keyL)
        ..c(Sl.keyL, label: '', width: 0.05),
    )
    // 第三行
    ..r(
      (r) => r
        ..c(Lk.shift, width: 0.15)
        ..c(Sl.keyZ)
        ..c(Sl.keyX)
        ..c(Sl.keyC)
        ..c(Sl.keyV)
        ..c(Sl.keyB)
        ..c(Sl.keyN)
        ..c(Sl.keyM)
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
      height: 0.18,
    )
    // 初始化
    ..cache();
}
