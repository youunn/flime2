import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:synchronized/extension.dart';

import 'event.dart';

class K {
  final Preset preset;
  final String label;
  final KEvent click;
  final Rectangle<double> hitBox;

  K({
    required this.preset,
    required this.label,
    required this.click,
    required this.hitBox,
  });

  double getSquaredDistance(double x, double y) {
    final double dx;
    if (x < hitBox.left) {
      dx = hitBox.left - x;
    } else if (x <= hitBox.right) {
      dx = 0;
    } else {
      dx = x - hitBox.right;
    }

    final double dy;
    if (y < hitBox.top) {
      dy = hitBox.top - y;
    } else if (y <= hitBox.bottom) {
      dy = 0;
    } else {
      dy = y - hitBox.bottom;
    }

    return dx * dx + dy * dy;
  }
}

class KRow extends Iterable<K> {
  final double height;
  final Preset preset;
  final double y;
  final keys = <K>[];

  KRow({
    required this.height,
    required this.preset,
    required this.y,
  })  : assert(height >= 0),
        assert(y >= 0);

  @override
  Iterator<K> get iterator => keys.iterator;

  void k({
    required KEvent click,
    required String label,
    double? width,
    double? height,
  }) {
    final x = keys.isNotEmpty ? keys.last.hitBox.right : 0.0;
    final w = width ?? preset.width;
    final h = height ?? this.height;
    final hitBox = Rectangle<double>(x, y, w, h);
    final key = K(
      preset: preset,
      label: label,
      click: click,
      hitBox: hitBox,
    );
    keys.add(key);
  }

  void c(
    LogicalKeyboardKey logicalKey, {
    double? width,
    double? height,
    String? label,
  }) {
    final x = keys.isNotEmpty ? keys.last.hitBox.right : 0.0;
    final w = width ?? preset.width;
    final h = height ?? this.height;
    final hitBox = Rectangle<double>(x, y, w, h);
    final k = K(
      preset: preset,
      label: label ?? logicalKey.keyLabel.toLowerCase(),
      click: KEvent(key: logicalKey),
      hitBox: hitBox,
    );
    keys.add(k);
  }
}

class Preset extends Iterable<KRow> {
  final double width;
  final double height;
  final double fontSize;
  final rows = <KRow>[];
  var _cached = false;
  late List<List<K>> neighborsOfCells;

  // 迷之数字，可能会改
  static const _defaultWidth = 0.1;
  static const _searchFactor = 1.2; // 迷之数字
  static const _threshold = _defaultWidth * _searchFactor;
  static const _thresholdSquared = _threshold * _threshold;
  static const _hGridCount = 30;
  static const _vGridCount = 20;
  static const _cellsCount = _hGridCount * _vGridCount;
  static const _cellWidth = 1 / _hGridCount;
  late final double _cachedTotalHeight;
  late final double _cachedCellHeight;

  Preset({
    required this.width,
    required this.height,
    required this.fontSize,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0);

  @override
  Iterator<KRow> get iterator => rows.iterator;

  // double get totalHeight =>
  //     rows.fold(0, (value, element) => value + element.height);

  double get totalHeight => rows.isNotEmpty ? rows.last.height + rows.last.y : 0;

  int get keyCount => rows.fold(0, (prev, curr) => prev + curr.keys.length);

  void r(
    KRow Function(KRow) init, {
    double? height,
  }) {
    final row = KRow(
      height: height ?? this.height,
      preset: this,
      y: rows.isNotEmpty ? rows.last.y + rows.last.height : 0,
    );
    rows.add(
      init(row),
    );
  }

  Future<K?> detectKey(Offset offset, double screenWidth) async {
    if (!_cached) await cache();
    final x = offset.dx / screenWidth;
    final y = offset.dy / screenWidth;

    var minDistance = double.maxFinite;
    K? resultK;

    for (final k in await getNearestKeys(offset, screenWidth)) {
      if (!k.hitBox.containsPoint(Point(x, y))) {
        continue;
      }
      final distance = k.getSquaredDistance(x, y);
      if (distance > minDistance) {
        continue;
      }

      minDistance = distance;
      resultK = k;
    }

    return resultK;
  }

  Future<List<K>> getNearestKeys(Offset offset, double screenWidth) async {
    if (!_cached) await cache();
    final x = offset.dx / screenWidth;
    final y = offset.dy / screenWidth;

    if (x >= 0 && x <= 1 && y >= 0 && y <= _cachedTotalHeight) {
      final index = y ~/ _cachedCellHeight * _hGridCount + x ~/ _cellWidth;
      if (index < _cellsCount) {
        return neighborsOfCells[index];
      }
    }

    return [];
  }

  Future cache() async {
    return synchronized(() async {
      if (_cached) return;

      final maxHeight = totalHeight;
      const halfCellWidth = _cellWidth / 2;
      final cellHeight = maxHeight / _vGridCount;
      final halfCellHeight = cellHeight / 2;

      neighborsOfCells = List<List<K>>.generate(_cellsCount, (_) => [], growable: false);

      for (final r in this) {
        for (final k in r) {
          // vertical
          final topPixel = k.hitBox.top - _threshold;
          final yDeltaToGrid = topPixel % cellHeight;
          final yMiddleOfTopCell = topPixel - yDeltaToGrid + halfCellHeight;
          final roundUpFlag = yDeltaToGrid <= halfCellHeight ? 0 : 1;
          final yStart = max(halfCellHeight, yMiddleOfTopCell + roundUpFlag * cellHeight);
          final yEnd = min(maxHeight, k.hitBox.top + _threshold);

          // horizontal
          final leftPixel = k.hitBox.left - _threshold;
          final xDeltaToGrid = leftPixel % _cellWidth;
          final xMiddleOfLeftCell = leftPixel - xDeltaToGrid + halfCellWidth;
          final roundLeftFlag = xDeltaToGrid <= halfCellWidth ? 0 : 1;
          final xStart = max(halfCellWidth, xMiddleOfLeftCell + roundLeftFlag * _cellWidth);
          final xEnd = min(1, k.hitBox.right + _threshold);

          var baseIndex = yStart ~/ cellHeight * _hGridCount + xStart ~/ _cellWidth;
          for (var centerY = yStart; centerY <= yEnd; centerY += cellHeight) {
            var index = baseIndex;
            for (var centerX = xStart; centerX <= xEnd; centerX += _cellWidth) {
              if (k.getSquaredDistance(centerX, centerY) < _thresholdSquared) {
                neighborsOfCells[index].add(k);
              }
              index += 1;
            }
            baseIndex += _hGridCount;
          }
        }
      }

      _cachedTotalHeight = maxHeight;
      _cachedCellHeight = cellHeight;
      _cached = true;
    });
  }
}
