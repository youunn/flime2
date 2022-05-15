import 'package:flutter/services.dart';

import 'event.dart';

class K {
  final Preset preset;
  final double height;
  final double width;
  final String label;
  final KEvent click;

  K({
    required this.preset,
    required this.height,
    required this.width,
    required this.label,
    required this.click,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0);
}

class KRow extends Iterable<K> {
  final double height;
  final Preset preset;
  final keys = <K>[];

  KRow({required this.height, required this.preset}) : assert(height >= 0);

  @override
  Iterator<K> get iterator => keys.iterator;

  void k({
    required KEvent click,
    required String label,
    double? width,
    double? height,
  }) {
    final key = K(
      preset: preset,
      height: height ?? this.height,
      width: width ?? preset.width,
      label: label,
      click: click,
    );
    keys.add(key);
  }

  void c(
    LogicalKeyboardKey logicalKey, {
    double? width,
    double? height,
    String? label,
  }) {
    final k = K(
      preset: preset,
      height: height ?? this.height,
      width: width ?? preset.width,
      label: label ?? logicalKey.keyLabel.toLowerCase(),
      click: KEvent(key: logicalKey),
    );
    keys.add(k);
  }
}

class Preset extends Iterable<KRow> {
  final double width;
  final double height;
  final double fontSize;
  final rows = <KRow>[];

  Preset({
    required this.width,
    required this.height,
    required this.fontSize,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0);

  @override
  Iterator<KRow> get iterator => rows.iterator;

  double get totalHeight =>
      rows.fold(0, (value, element) => value + element.height);

  void r(
    KRow Function(KRow) init, {
    double? height,
  }) {
    final row = KRow(
      height: height ?? this.height,
      preset: this,
    );
    rows.add(
      init(row),
    );
  }
}
