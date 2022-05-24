import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:synchronized/extension.dart';

import 'event.dart';

class K {
  final Preset preset;
  final Rectangle<double> hitBox;
  final String label;
  final KEvent click;
  final bool repeatable;
  final MoreKeysPanel? more;
  final KEvent? composing;
  final String? composingLabel;
  late final Rectangle<double>? moreKeysPanelBox;
  final IconData? icon;
  final bool functional;
  final Highlight? highlight;

  static const _emptyHitBox = Rectangle<double>(0, 0, 0, 0);

  K({
    required this.preset,
    required this.hitBox,
    required this.label,
    required this.click,
    this.repeatable = false,
    this.more,
    this.composing,
    this.composingLabel,
    this.icon,
    this.functional = false,
    this.highlight,
  }) {
    final more = this.more;
    if (more == null) {
      moreKeysPanelBox = null;
    } else {
      final h = more.totalHeight + more.padding * 2;
      final w = more.maxRowWidth + more.padding * 2;
      final realTop = hitBox.top - h;
      final left = hitBox.left + hitBox.width / 2 - (w / 2);
      final right = hitBox.right - hitBox.width / 2 + (w / 2);
      final double realLeft;
      if (left < 0) {
        realLeft = 0;
      } else if (right > 1) {
        realLeft = left + 1 - right;
      } else {
        realLeft = left;
      }
      moreKeysPanelBox = Rectangle(realLeft, realTop, w, h);
    }
  }

  K.dummy(Preset preset)
      : this(
          preset: preset,
          hitBox: _emptyHitBox,
          label: '',
          click: KEvent(),
        );

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
    KEvent? longClick,
    String? longClickLabel,
    bool repeatable = false,
    double? width,
    double? height,
    MoreKeysPanel? more,
    KEvent? composing,
    String? composingLabel,
    IconData? icon,
    bool functional = false,
    Highlight? highlight,
  }) {
    final x = keys.isNotEmpty ? keys.last.hitBox.right : 0.0;
    final w = width ?? preset.width;
    final h = height ?? this.height;
    final hitBox = Rectangle<double>(x, y, w, h);

    if (more == null && longClick != null) {
      more = MoreKeysPanel(
        width: width ?? preset.width,
        height: height ?? preset.height,
        fontSize: preset.fontSize,
        orientationFactor: preset.orientationFactor,
        radius: (height ?? preset.height) / 2,
      )..r((r) {
          return r..k(click: longClick, label: longClickLabel ?? '');
        });
    }

    final key = K(
      preset: preset,
      label: label,
      click: click,
      repeatable: repeatable,
      hitBox: hitBox,
      more: more,
      composing: composing,
      composingLabel: composingLabel,
      icon: icon,
      functional: functional,
      highlight: highlight,
    );
    keys.add(key);
  }

  void c(
    LogicalKeyboardKey logicalKey, {
    String? label,
    LogicalKeyboardKey? longClick,
    KEvent? longClickEvent,
    String? longClickLabel,
    bool repeatable = false,
    double? width,
    double? height,
    MoreKeysPanel? more,
    KEvent? composing,
    String? composingLabel,
    IconData? icon,
    bool functional = false,
    Highlight? highlight,
  }) {
    k(
      click: KEvent(key: logicalKey),
      label: label ?? logicalKey.keyLabel.toLowerCase(),
      longClick: longClickEvent ?? (longClick != null ? KEvent(key: longClick) : null),
      longClickLabel: longClickLabel ?? longClick?.keyLabel.toLowerCase(),
      repeatable: repeatable,
      width: width,
      height: height,
      more: more,
      composing: composing,
      composingLabel: composingLabel,
      icon: icon,
      functional: functional,
      highlight: highlight,
    );
  }
}

class Preset extends Iterable<KRow> {
  final double width;
  final double height;
  final double fontSize;
  final double orientationFactor;
  final rows = <KRow>[];
  var _cached = false;
  late List<List<K>> neighborsOfCells;

  static const _defaultWidth = 0.1;
  static const _searchFactor = 1.2; // 迷之数字
  static const threshold = _defaultWidth * _searchFactor;
  static const _thresholdSquared = threshold * threshold;
  static const _hGridCount = 30;
  static const _vGridCount = 20;
  static const _cellsCount = _hGridCount * _vGridCount;
  static const _cellWidth = 1 / _hGridCount;
  double? _cachedTotalHeight;
  late final double _cachedCellHeight;

  Preset({
    required this.width,
    required this.height,
    required this.fontSize,
    required this.orientationFactor,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0);

  @override
  Iterator<KRow> get iterator => rows.iterator;

  double get totalHeight =>
      _cachedTotalHeight ?? (_cachedTotalHeight = rows.isNotEmpty ? rows.last.height + rows.last.y : 0.0);

  double get maxRowWidth => rows.fold(
        0,
        (prev, curr) {
          if (curr.isNotEmpty) {
            final rowWidth = curr.keys.last.hitBox.right;
            if (rowWidth > prev) {
              return rowWidth;
            }
          }
          return prev;
        },
      );

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

  Future<K?> detectKey(
    Offset offset,
    double screenWidth, {
    Orientation orientation = Orientation.portrait,
  }) async {
    if (!_cached) await cache();
    final x = offset.dx / screenWidth;
    final factor = orientation == Orientation.landscape ? orientationFactor : 1;
    final y = offset.dy / (screenWidth * factor);

    var minDistance = double.maxFinite;
    K? resultK;

    for (final k in await getNearestKeys(offset, screenWidth, orientation: orientation)) {
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

  Future<List<K>> getNearestKeys(
    Offset offset,
    double screenWidth, {
    Orientation orientation = Orientation.portrait,
  }) async {
    if (!_cached) await cache();
    final x = offset.dx / screenWidth;
    final factor = orientation == Orientation.landscape ? orientationFactor : 1;
    final y = offset.dy / (screenWidth * factor);

    if (x >= 0 && x <= 1 && y >= 0 && y <= totalHeight) {
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
          final areaTop = k.hitBox.top - threshold;
          final yDeltaToGrid = areaTop % cellHeight;
          final yMiddleOfTopCell = areaTop - yDeltaToGrid + halfCellHeight;
          final roundUpFlag = yDeltaToGrid <= halfCellHeight ? 0 : 1;
          final yStart = max(halfCellHeight, yMiddleOfTopCell + roundUpFlag * cellHeight);
          final yEnd = min(maxHeight, k.hitBox.bottom + threshold);

          // horizontal
          final areaLeft = k.hitBox.left - threshold;
          final xDeltaToGrid = areaLeft % _cellWidth;
          final xMiddleOfLeftCell = areaLeft - xDeltaToGrid + halfCellWidth;
          final roundLeftFlag = xDeltaToGrid <= halfCellWidth ? 0 : 1;
          final xStart = max(halfCellWidth, xMiddleOfLeftCell + roundLeftFlag * _cellWidth);
          final xEnd = min(1, k.hitBox.right + threshold);

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

      _cachedCellHeight = cellHeight;
      _cached = true;
    });
  }
}

class MoreKeysPanel extends Preset {
  final double padding;
  final double radius;
  MoreKeysPanel({
    required super.width,
    required super.height,
    required super.fontSize,
    required super.orientationFactor,
    this.padding = 0,
    this.radius = 0,
  });
}

enum Highlight {
  shift,
  enter,
  space,
}
