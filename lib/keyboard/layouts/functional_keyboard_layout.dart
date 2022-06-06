import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/components/keyboard.dart';
import 'package:flime/keyboard/components/keyboard_wrapper.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flutter/material.dart';

class FunctionalKeyboardLayout extends StatelessWidget {
  const FunctionalKeyboardLayout({Key? key}) : super(key: key);

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
    fontSize: 20,
    orientationFactor: 0.45,
  )
    ..r(
      (r) => r
        ..c(Lk.f1, label: 'F1')
        ..c(Lk.f2, label: 'F2')
        ..c(Lk.f3, label: 'F3')
        ..c(Lk.f4, label: 'F4')
        ..c(Lk.f5, label: 'F5')
        ..c(Lk.f6, label: 'F6')
        ..c(Lk.home, icon: Icons.home_outlined)
        ..c(Lk.end, icon: Icons.stop_outlined)
        ..c(Lk.insert, icon: Icons.edit_outlined)
        ..c(Lk.delete, icon: Icons.delete_outlined),
    )
    ..r(
      (r) => r
        ..c(Lk.f7, label: 'F7')
        ..c(Lk.f8, label: 'F9')
        ..c(Lk.f9, label: 'F9')
        ..c(Lk.f10, label: 'FA')
        ..c(Lk.f11, label: 'FB')
        ..c(Lk.f12, label: 'FC')
        ..c(Lk.printScreen, icon: Icons.fullscreen)
        ..c(Lk.pause, icon: Icons.pause)
        ..c(Lk.pageUp, icon: Icons.first_page)
        ..c(Lk.pageDown, icon: Icons.last_page),
    )
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
          functional: true,
          highlight: Highlight.shift,
        )
        ..c(Lk.shift, icon: Icons.keyboard_arrow_up)
        ..c(Lk.control, icon: Icons.keyboard_control_key)
        ..c(Lk.meta, icon: Icons.keyboard_command_key)
        ..c(Lk.alt, icon: Icons.keyboard_option_key)
        ..c(Lk.arrowLeft, icon: Icons.keyboard_arrow_left)
        ..c(Lk.arrowDown, icon: Icons.keyboard_arrow_down)
        ..c(Lk.arrowUp, icon: Icons.keyboard_arrow_up)
        ..c(Lk.arrowRight, icon: Icons.keyboard_arrow_right)
        ..c(Lk.backspace, icon: Icons.backspace_outlined, repeatable: true),
    )
    ..r(
      (r) => r
        ..k(
          click: KEvent(
            command: (context, _) {
              context.router.replace(const FullKeyboardRoute());
            },
          ),
          label: '',
          icon: Icons.abc,
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
        ..c(Lk.space, label: '', repeatable: true, width: 0.30, functional: true, highlight: Highlight.space)
        ..c(Lk.tab, icon: Icons.keyboard_tab)
        ..c(Lk.escape, icon: Icons.arrow_back)
        ..c(Lk.enter, label: 'Enter', icon: Icons.keyboard_return, functional: true),
    )
    ..cache();
}
