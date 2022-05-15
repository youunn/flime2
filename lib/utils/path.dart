import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
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

Future copyAssets() async {
  final dataDirectory = await getRimeDirectory();

  if (await dataDirectory.exists()) return;
  await dataDirectory.create(recursive: true);

  final Map<String, dynamic> assets =
      jsonDecode(await rootBundle.loadString('AssetManifest.json'));
  const pattern = 'assets/rime/';
  final paths = assets.keys.where((k) => k.contains(pattern)).toList();
  for (final p in paths) {
    final data = await rootBundle.load(p);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    final f = p.substring(p.indexOf(pattern) + pattern.length);
    if (f.contains('/')) {
      final d = Directory(f.substring(f.lastIndexOf('/') + 1));
      if (!await d.exists()) {
        await d.create(recursive: true);
      }
    }

    await File(join(dataDirectory.path, f)).writeAsBytes(bytes, flush: true);
  }
}
