import 'package:mobx/mobx.dart';

part 'keyboard_status.g.dart';

class KeyboardStatus = AbstractKeyboardStatus with _$KeyboardStatus;

abstract class AbstractKeyboardStatus with Store {
  @observable
  int modifierState = 0;

  @observable
  bool isComposing = false;

  @observable
  bool isAsciiMode = false;

  @observable
  String? schemaId;

  @observable
  String? schemaName;

  @observable
  List<String?> candidates = [];
  @observable
  List<String?> comments = [];
  @observable
  String? preedit;
  @observable
  String? preview;

  @observable
  bool? shiftLock;
  @observable
  bool? controlLock;
  @observable
  bool? metaLock;
  @observable
  bool? altLock;

  @observable
  int editorAction = 0;

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

  bool hasModifier(int mask) {
    return modifierState & mask != 0;
  }

  @action
  void resetModifier() {
    if (modifierState != 0) modifierState = 0;
  }
}
