import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class LayoutApi {
  void updateHeight(int height);
}

@HostApi()
abstract class InputMethodApi {
  void enable();

  void pick();
}
