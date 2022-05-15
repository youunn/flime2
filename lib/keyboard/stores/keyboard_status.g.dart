// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$KeyboardStatus on AbstractKeyboardStatus, Store {
  Computed<bool>? _$hasModifierComputed;

  @override
  bool get hasModifier =>
      (_$hasModifierComputed ??= Computed<bool>(() => super.hasModifier,
              name: 'AbstractKeyboardStatus.hasModifier'))
          .value;

  late final _$modifierStateAtom =
      Atom(name: 'AbstractKeyboardStatus.modifierState', context: context);

  @override
  int get modifierState {
    _$modifierStateAtom.reportRead();
    return super.modifierState;
  }

  @override
  set modifierState(int value) {
    _$modifierStateAtom.reportWrite(value, super.modifierState, () {
      super.modifierState = value;
    });
  }

  late final _$AbstractKeyboardStatusActionController =
      ActionController(name: 'AbstractKeyboardStatus', context: context);

  @override
  bool setModifier(int mask, {required bool state}) {
    final _$actionInfo = _$AbstractKeyboardStatusActionController.startAction(
        name: 'AbstractKeyboardStatus.setModifier');
    try {
      return super.setModifier(mask, state: state);
    } finally {
      _$AbstractKeyboardStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetModifier() {
    final _$actionInfo = _$AbstractKeyboardStatusActionController.startAction(
        name: 'AbstractKeyboardStatus.resetModifier');
    try {
      return super.resetModifier();
    } finally {
      _$AbstractKeyboardStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
modifierState: ${modifierState},
hasModifier: ${hasModifier}
    ''';
  }
}
