import 'package:mobx/mobx.dart';

part 'settings.g.dart';

class SettingsStore = AbstractSettingsStore with _$SettingsStore;

abstract class AbstractSettingsStore with Store {
  @observable
  Duration longPressDuration = const Duration(milliseconds: 200);

  @observable
  Duration repeatInterval = const Duration(milliseconds: 50);
}
