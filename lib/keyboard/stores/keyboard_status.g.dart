// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$KeyboardStatus on _KeyboardStatus, Store {
  Computed<bool>? _$hasModifierComputed;

  @override
  bool get hasModifier =>
      (_$hasModifierComputed ??= Computed<bool>(() => super.hasModifier,
              name: '_KeyboardStatus.hasModifier'))
          .value;

  late final _$modifierStateAtom =
      Atom(name: '_KeyboardStatus.modifierState', context: context);

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

  late final _$_KeyboardStatusActionController =
      ActionController(name: '_KeyboardStatus', context: context);

  @override
  bool setModifier(int mask, {required bool state}) {
    final _$actionInfo = _$_KeyboardStatusActionController.startAction(
        name: '_KeyboardStatus.setModifier');
    try {
      return super.setModifier(mask, state: state);
    } finally {
      _$_KeyboardStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetModifier() {
    final _$actionInfo = _$_KeyboardStatusActionController.startAction(
        name: '_KeyboardStatus.resetModifier');
    try {
      return super.resetModifier();
    } finally {
      _$_KeyboardStatusActionController.endAction(_$actionInfo);
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
