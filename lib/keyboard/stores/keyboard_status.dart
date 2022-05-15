import 'package:mobx/mobx.dart';

part 'keyboard_status.g.dart';

class KeyboardStatus = AbstractKeyboardStatus with _$KeyboardStatus;

abstract class AbstractKeyboardStatus with Store {
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
