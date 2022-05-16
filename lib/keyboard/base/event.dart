import 'package:flime/utils/keyboard_maps.dart';
import 'package:flutter/services.dart';

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
  })  : code = key == null ? null : logicalKeyToX11Map[key],
        androidCode = key == null ? null : logicalKeyToAndroidMap[key];

  int get androidMask {
    if (_androidMask != null) return _androidMask!;
    if (mask == 0) return mask;
    var result = 0;
    if (mask | modifierShift != 0) {
      result |= RawKeyEventDataAndroid.modifierShift;
    }
    if (mask | modifierControl != 0) {
      result |= RawKeyEventDataAndroid.modifierControl;
    }
    if (mask | modifierAlt != 0) {
      result |= RawKeyEventDataAndroid.modifierAlt;
    }
    if (mask | modifierMeta != 0) {
      result |= RawKeyEventDataAndroid.modifierMeta;
    }
    _androidMask = result;
    return result;
  }

  static const modifierShift = GtkKeyHelper.modifierShift;
  static const modifierControl = GtkKeyHelper.modifierControl;
  static const modifierAlt = GtkKeyHelper.modifierMod1;
  static const modifierMeta = GtkKeyHelper.modifierMeta;
}

class Command {}

typedef Lk = LogicalKeyboardKey;
typedef Sl = SmallLetter;
