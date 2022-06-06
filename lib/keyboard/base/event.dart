import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flime/utils/keyboard_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Command = void Function(BuildContext context, KeyboardStatus status);

class KEvent {
  final int? code; // linux
  final int? androidCode;
  final int mask; // X11
  int? _androidMask;
  final bool _androidShiftOn;
  final LogicalKeyboardKey? key;
  final Command? command;

  // TODO: add const constructor
  KEvent({
    this.key,
    this.command,
    this.mask = 0,
  })  : code = logicalKeyToX11Map[key],
        androidCode = (() {
          LogicalKeyboardKey? realKey;

          if (key is SmallLetter) {
            realKey = upperCaseMap[key];
            return logicalKeyToAndroidMap[realKey];
          }

          realKey = specialLogicalKeyAndroidMap[key];
          if (realKey != null) return logicalKeyToAndroidMap[realKey];

          realKey = withShiftMap[key];
          if (realKey != null) return logicalKeyToAndroidMap[realKey];

          return logicalKeyToAndroidMap[key];
        }()),
        _androidShiftOn = specialLogicalKeyShiftMaskAndroidMap[key] ?? withShiftMap.containsKey(key);

  KEvent.number(
    int index, {
    Command? command,
    int mask = 0,
  }) : this(
          key: numberToLogicalKeyMap[index],
          command: command,
          mask: mask,
        );

  int get androidMask {
    _androidMask ??= getAndroidMask(mask);
    var result = _androidMask ?? 0;
    if (_androidShiftOn) result |= RawKeyEventDataAndroid.modifierShift;
    return result;
  }

  static int getAndroidMask(int mask) {
    if (mask == 0) return mask;
    var result = 0;
    if (mask & modifierShift != 0) {
      result |= RawKeyEventDataAndroid.modifierShift;
    }
    if (mask & modifierControl != 0) {
      result |= RawKeyEventDataAndroid.modifierControl;
    }
    if (mask & modifierAlt != 0) {
      result |= RawKeyEventDataAndroid.modifierAlt;
    }
    if (mask & modifierMeta != 0) {
      result |= RawKeyEventDataAndroid.modifierMeta;
    }
    return result;
  }

  static const modifierShift = GtkKeyHelper.modifierShift;
  static const modifierControl = GtkKeyHelper.modifierControl;
  static const modifierAlt = GtkKeyHelper.modifierMod1;
  static const modifierMeta = 1 << 28;

  // TODO: const events and commands
}

typedef Lk = LogicalKeyboardKey;
typedef Sl = SmallLetter;
