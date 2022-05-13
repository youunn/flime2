import 'package:flime/api/native.dart';

class KEvent {
  int? _code;
  int mask;
  String? name;
  Command? command;

  KEvent({
    this.name,
    this.command,
    this.mask = 0,
  }) : assert(name != null || command != null) {
    if (command != null) _code = keycodeCommand;
  }

  int get code {
    if (name == null) return _code ?? keycodeVoid;
    return _code ??= rimeBridge.get_keycode(name!.cast());
  }
}

class Command {}

// const values

const keycodeVoid = 0xffffff;
const keycodeCommand = -1;

const _controlMaskName = 'Control';
const _shiftMaskName = 'Shift';
const _altMaskName = 'Alt';
const _metaMaskName = 'Meta';

int? _controlMask;
int? _shiftMask;
int? _altMask;
int? _metaMask;

int get controlMask {
  return _controlMask ??= rimeBridge.get_modifier(_controlMaskName.cast());
}

int get shiftMask {
  return _shiftMask ??= rimeBridge.get_modifier(_shiftMaskName.cast());
}

int get altMask {
  return _altMask ??= rimeBridge.get_modifier(_altMaskName.cast());
}

int get metaMask {
  return _metaMask ??= rimeBridge.get_modifier(_metaMaskName.cast());
}
