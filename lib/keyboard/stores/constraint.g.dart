// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constraint.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Constraint on _Constraint, Store {
  Computed<int>? _$totalHeightInPxComputed;

  @override
  int get totalHeightInPx =>
      (_$totalHeightInPxComputed ??= Computed<int>(() => super.totalHeightInPx,
              name: '_Constraint.totalHeightInPx'))
          .value;

  late final _$_heightAtom =
      Atom(name: '_Constraint._height', context: context);

  double get height {
    _$_heightAtom.reportRead();
    return super._height;
  }

  @override
  double get _height => height;

  @override
  set _height(double value) {
    _$_heightAtom.reportWrite(value, super._height, () {
      super._height = value;
    });
  }

  late final _$_dprAtom = Atom(name: '_Constraint._dpr', context: context);

  double get dpr {
    _$_dprAtom.reportRead();
    return super._dpr;
  }

  @override
  double get _dpr => dpr;

  @override
  set _dpr(double value) {
    _$_dprAtom.reportWrite(value, super._dpr, () {
      super._dpr = value;
    });
  }

  late final _$_ConstraintActionController =
      ActionController(name: '_Constraint', context: context);

  @override
  void setHeightAndDpr(double h, double d) {
    final _$actionInfo = _$_ConstraintActionController.startAction(
        name: '_Constraint.setHeightAndDpr');
    try {
      return super.setHeightAndDpr(h, d);
    } finally {
      _$_ConstraintActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalHeightInPx: ${totalHeightInPx}
    ''';
  }
}
