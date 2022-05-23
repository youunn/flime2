import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class LayoutApi {
  void updateHeight(int height);

  void toggleFullScreen();
}

@HostApi()
abstract class InputMethodApi {
  void enable();

  void pick();
}

@HostApi()
abstract class InputConnectionApi {
  void commit(String text);

  void send(int code, int mask);

  void performEnter();

  void handleBack();

  int getActionId();
}

@FlutterApi()
abstract class InputServiceApi {
  void startInputView();
  void finalize();
}
