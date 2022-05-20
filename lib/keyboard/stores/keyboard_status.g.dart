// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$KeyboardStatus on AbstractKeyboardStatus, Store {
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

  late final _$isComposingAtom =
      Atom(name: 'AbstractKeyboardStatus.isComposing', context: context);

  @override
  bool get isComposing {
    _$isComposingAtom.reportRead();
    return super.isComposing;
  }

  @override
  set isComposing(bool value) {
    _$isComposingAtom.reportWrite(value, super.isComposing, () {
      super.isComposing = value;
    });
  }

  late final _$candidatesAtom =
      Atom(name: 'AbstractKeyboardStatus.candidates', context: context);

  @override
  List<String?> get candidates {
    _$candidatesAtom.reportRead();
    return super.candidates;
  }

  @override
  set candidates(List<String?> value) {
    _$candidatesAtom.reportWrite(value, super.candidates, () {
      super.candidates = value;
    });
  }

  late final _$commentsAtom =
      Atom(name: 'AbstractKeyboardStatus.comments', context: context);

  @override
  List<String?> get comments {
    _$commentsAtom.reportRead();
    return super.comments;
  }

  @override
  set comments(List<String?> value) {
    _$commentsAtom.reportWrite(value, super.comments, () {
      super.comments = value;
    });
  }

  late final _$preeditAtom =
      Atom(name: 'AbstractKeyboardStatus.preedit', context: context);

  @override
  String? get preedit {
    _$preeditAtom.reportRead();
    return super.preedit;
  }

  @override
  set preedit(String? value) {
    _$preeditAtom.reportWrite(value, super.preedit, () {
      super.preedit = value;
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
isComposing: ${isComposing},
candidates: ${candidates},
comments: ${comments},
preedit: ${preedit}
    ''';
  }
}
