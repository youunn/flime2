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
  final Command? command;

  KEvent({
    LogicalKeyboardKey? key,
    this.command,
    this.mask = 0,
  })  : code = logicalKeyToX11Map[key],
        androidCode = (key is SmallLetter) ? logicalKeyToAndroidMap[upperCaseMap[key]] : logicalKeyToAndroidMap[key]
  // TODO: android replace code of symbol like '!' with '1' and 'shift'
  // TODO: X shift to the opposite
  ;

  KEvent.number(
    int index, {
    Command? command,
    int mask = 0,
  }) : this(
          key: numberToLogicalKeyMap[index],
          command: command,
          mask: mask,
        );

  int get androidMask => _androidMask ?? (_androidMask = toAndroidMask(mask));

  static int toAndroidMask(int mask) {
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
  static const modifierMeta = GtkKeyHelper.modifierMeta;
}

typedef Lk = LogicalKeyboardKey;
typedef Sl = SmallLetter;
