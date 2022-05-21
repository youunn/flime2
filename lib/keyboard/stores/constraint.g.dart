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

  late final _$toolbarHeightFactorAtom = Atom(
      name: 'AbstractConstraintStore.toolbarHeightFactor', context: context);

  @override
  double get toolbarHeightFactor {
    _$toolbarHeightFactorAtom.reportRead();
    return super.toolbarHeightFactor;
  }

  @override
  set toolbarHeightFactor(double value) {
    _$toolbarHeightFactorAtom.reportWrite(value, super.toolbarHeightFactor, () {
      super.toolbarHeightFactor = value;
    });
  }

  late final _$orientationFactorAtom =
      Atom(name: 'AbstractConstraintStore.orientationFactor', context: context);

  @override
  double get orientationFactor {
    _$orientationFactorAtom.reportRead();
    return super.orientationFactor;
  }

  @override
  set orientationFactor(double value) {
    _$orientationFactorAtom.reportWrite(value, super.orientationFactor, () {
      super.orientationFactor = value;
    });
  }

  late final _$orientationAtom =
      Atom(name: 'AbstractConstraintStore.orientation', context: context);

  @override
  Orientation get orientation {
    _$orientationAtom.reportRead();
    return super.orientation;
  }

  @override
  set orientation(Orientation value) {
    _$orientationAtom.reportWrite(value, super.orientation, () {
      super.orientation = value;
    });
  }

  @override
  String toString() {
    return '''
height: ${height},
dpr: ${dpr},
toolbarHeight: ${toolbarHeight},
toolbarHeightFactor: ${toolbarHeightFactor},
orientationFactor: ${orientationFactor},
orientation: ${orientation},
totalHeight: ${totalHeight},
totalHeightInPx: ${totalHeightInPx}
    ''';
  }
}
