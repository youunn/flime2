import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<Directory> getRimeDirectory() async {
  final d = await getExternalStorageDirectory();
  return Directory(join(d!.path, 'rime'));
}
