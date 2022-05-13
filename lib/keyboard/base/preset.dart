import 'event.dart';

class K {
  final double height;
  final double width;
  final Preset preset;
  final String label;
  final KEvent click;

  K({
    required this.height,
    required this.width,
    required this.preset,
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

  void k(
    KEvent click, {
    required String label,
    double? width,
    double? height,
  }) {
    final key = K(
      height: height ?? this.height,
      width: width ?? preset.width,
      preset: preset,
      click: click,
      label: label,
    );
    keys.add(key);
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
