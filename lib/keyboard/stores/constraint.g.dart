// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constraint.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConstraintStore on AbstractConstraintStore, Store {
  Computed<double>? _$totalHeightComputed;

  @override
  double get totalHeight =>
      (_$totalHeightComputed ??= Computed<double>(() => super.totalHeight,
              name: 'AbstractConstraintStore.totalHeight'))
          .value;
  Computed<int>? _$totalHeightInPxComputed;

  @override
  int get totalHeightInPx =>
      (_$totalHeightInPxComputed ??= Computed<int>(() => super.totalHeightInPx,
              name: 'AbstractConstraintStore.totalHeightInPx'))
          .value;

  late final _$heightAtom =
      Atom(name: 'AbstractConstraintStore.height', context: context);

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$dprAtom =
      Atom(name: 'AbstractConstraintStore.dpr', context: context);

  @override
  double get dpr {
    _$dprAtom.reportRead();
    return super.dpr;
  }

  @override
  set dpr(double value) {
    _$dprAtom.reportWrite(value, super.dpr, () {
      super.dpr = value;
    });
  }

  late final _$toolbarHeightAtom =
      Atom(name: 'AbstractConstraintStore.toolbarHeight', context: context);

  @override
  double get toolbarHeight {
    _$toolbarHeightAtom.reportRead();
    return super.toolbarHeight;
  }

  @override
  set toolbarHeight(double value) {
    _$toolbarHeightAtom.reportWrite(value, super.toolbarHeight, () {
      super.toolbarHeight = value;
    });
  }

  @override
  String toString() {
    return '''
height: ${height},
dpr: ${dpr},
toolbarHeight: ${toolbarHeight},
totalHeight: ${totalHeight},
totalHeightInPx: ${totalHeightInPx}
    ''';
  }
}
