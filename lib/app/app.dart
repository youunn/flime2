import 'dart:convert';
import 'dart:io';

import 'package:flime/api/native.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Button(
            child: const Text('Load Assets'),
            onPressed: () async {
              final d = await getExternalStorageDirectory();
              if (d == null) return;
              final dataDirectory = Directory(join(d.path, 'rime'));
              if (await dataDirectory.exists()) return;
              await dataDirectory.create(recursive: true);

              final Map<String, dynamic> assets =
                  jsonDecode(await rootBundle.loadString('AssetManifest.json'));
              const pattern = 'assets/rime/';
              final paths =
                  assets.keys.where((k) => k.contains(pattern)).toList();
              for (final p in paths) {
                final data = await rootBundle.load(p);
                final bytes = data.buffer
                    .asUint8List(data.offsetInBytes, data.lengthInBytes);

                final f = p.substring(p.indexOf(pattern) + pattern.length);
                if (f.contains('/')) {
                  final d = Directory(f.substring(f.lastIndexOf('/') + 1));
                  if (!await d.exists()) {
                    await d.create(recursive: true);
                  }
                }

                debugPrint(dataDirectory.path);
                debugPrint(f);
                await File(join(dataDirectory.path, f))
                    .writeAsBytes(bytes, flush: true);
              }
            },
          ),
          Button(
            child: const Text('Start Rime'),
            onPressed: () async {
              final d = await getExternalStorageDirectory();
              if (d == null) return;
              final dataDirectory = Directory(join(d.path, 'rime'));

              rimeBridge
                ..init()
                ..start(dataDirectory.path.cast());
            },
          ),
          Button(
            child: const Text('Type A'),
            onPressed: () {
              rimeBridge.process_key_name('a'.cast());
            },
          ),
          Button(
            child: const Text('Type Space'),
            onPressed: () {
              rimeBridge.process_key_name('space'.cast());
            },
          ),
          Button(
            child: const Text('Get Commit'),
            onPressed: () {
              debugPrint(rimeBridge.get_commit().toDartString());
            },
          ),
        ],
      ),
    );
  }
}
