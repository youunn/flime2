import 'package:flime/api/platform_api.g.dart';
import 'package:mobx/mobx.dart';

part 'constraint.g.dart';

class ConstraintStore = AbstractConstraintStore with _$ConstraintStore;

abstract class AbstractConstraintStore with Store {
  @readonly
  double _height = 192;
  @readonly
  double _dpr = 1;

  final LayoutApi layoutApi;

  AbstractConstraintStore(this.layoutApi);

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
