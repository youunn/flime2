import 'package:flime/api/platform_api.g.dart';
import 'package:mobx/mobx.dart';

part 'constraint.g.dart';

class ConstraintStore = AbstractConstraintStore with _$ConstraintStore;

abstract class AbstractConstraintStore with Store {
  @observable
  double height = 262;
  @observable
  double dpr = 1;
  @observable
  double toolbarHeight = 40;

  final LayoutApi layoutApi;

  AbstractConstraintStore(this.layoutApi);

  @computed
  double get totalHeight => height + toolbarHeight;

  @computed
  int get totalHeightInPx => (totalHeight * dpr).toInt();
  int _cachedHeight = 0;

  void updatePlatformHeight() {
    final h = totalHeightInPx;
    if (h != _cachedHeight) {
      layoutApi.updateHeight(h);
      _cachedHeight = h;
    }
  }
}
