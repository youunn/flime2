// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constraint.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConstraintStore on AbstractConstraintStore, Store {
  Computed<int>? _$totalHeightInPxComputed;

  @override
  int get totalHeightInPx =>
      (_$totalHeightInPxComputed ??= Computed<int>(() => super.totalHeightInPx,
              name: 'AbstractConstraintStore.totalHeightInPx'))
          .value;

  late final _$_heightAtom =
      Atom(name: 'AbstractConstraintStore._height', context: context);

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

  late final _$_dprAtom =
      Atom(name: 'AbstractConstraintStore._dpr', context: context);

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

  late final _$AbstractConstraintStoreActionController =
      ActionController(name: 'AbstractConstraintStore', context: context);

  @override
  void setHeightAndDpr(double h, double d) {
    final _$actionInfo = _$AbstractConstraintStoreActionController.startAction(
        name: 'AbstractConstraintStore.setHeightAndDpr');
    try {
      return super.setHeightAndDpr(h, d);
    } finally {
      _$AbstractConstraintStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalHeightInPx: ${totalHeightInPx}
    ''';
  }
}
