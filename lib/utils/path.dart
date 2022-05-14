import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';

Future<Directory> getRimeDirectory() async {
  // 天天踩坑
  if (Platform.isAndroid) {
    PathProviderAndroid.registerWith();
  } else {
    // do nothing yet
  }
  final d = await getExternalStorageDirectory();
  return Directory(join(d!.path, 'rime'));
}
