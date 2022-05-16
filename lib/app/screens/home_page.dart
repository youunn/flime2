import 'package:auto_route/auto_route.dart';
import 'package:flime/api/platform_api.g.dart';
import 'package:flime/app/router/router.dart';
import 'package:flime/utils/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flime'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('启用'),
            onTap: () {
              context.read<InputMethodApi>().enable();
            },
          ),
          ListTile(
            title: const Text('选择'),
            onTap: () {
              context.read<InputMethodApi>().pick();
            },
          ),
          ListTile(
            title: const Text('部署'),
            onTap: () {
              copyAssets();
            },
          ),
          ListTile(
            title: const Text('输入'),
            onTap: () {
              router.push(const InputRoute());
            },
          ),
          ListTile(
            title: const Text('测试'),
            onTap: () {
              router.push(const GalleryRoute());
            },
          ),
        ],
      ),
    );
  }
}
