import 'package:mobx/mobx.dart';

part 'keyboard_status.g.dart';

// ignore_for_file: library_private_types_in_public_api

class KeyboardStatus = _KeyboardStatus with _$KeyboardStatus;

abstract class _KeyboardStatus with Store {
  @observable
  int modifierState = 0;

  @action
  bool setModifier(int mask, {required bool state}) {
    if ((modifierState & mask != 0) == state) return false;
    if (state) {
      modifierState |= mask;
    } else {
      modifierState &= ~mask;
    }
    return true;
  }

  @action
  void resetModifier() {
    if (modifierState != 0) modifierState = 0;
  }

  @computed
  bool get hasModifier => modifierState != 0;
}
