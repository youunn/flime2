import 'package:flime/keyboard/api/api.dart';
import 'package:mobx/mobx.dart';

part 'constraint.g.dart';

// ignore_for_file: library_private_types_in_public_api

class Constraint = _Constraint with _$Constraint;

abstract class _Constraint with Store {
  @readonly
  double _height = 192;
  @readonly
  double _dpr = 1;

  final layoutApi = scopedLayoutApi;

  @computed
  int get totalHeightInPx => (_height * _dpr).toInt();

  // ignore: unused_field
  late final ReactionDisposer _notifyNative;

  void setupReactions() {
    _notifyNative = reaction(
      (_) => totalHeightInPx,
      (int h) {
        if (h != 0) {
          layoutApi.updateHeight(h);
        }
      },
      delay: 100,
    );
  }

  @action
  void setHeightAndDpr(double h, double d) {
    _dpr = d;
    _height = h;
  }
}
