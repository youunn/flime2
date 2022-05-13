import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flime/app/api/api.dart';
import 'package:flime/app/router/router.dart';
import 'package:flime/utils/path.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return ScaffoldPage(
      header: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          PageHeader(
            title: Text('Flime'),
          ),
        ],
      ),
      content: ListView(
        children: [
          TappableListTile(
            title: const Text('启用'),
            onTap: () {
              inputMethodApi.enable();
            },
          ),
          TappableListTile(
            title: const Text('选择'),
            onTap: () {
              inputMethodApi.pick();
            },
          ),
          TappableListTile(
            title: const Text('部署'),
            onTap: () {
              _copyAssets();
            },
          ),
          TappableListTile(
            title: const Text('输入'),
            onTap: () {
              router.push(const InputRoute());
            },
          ),
          TappableListTile(
            title: const Text('测试'),
            onTap: () {
              router.push(const GalleryRoute());
            },
          ),
        ],
      ),
    );
  }

  Future _copyAssets() async {
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
}
