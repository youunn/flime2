import 'package:dynamic_color/dynamic_color.dart';
import 'package:flime/app/router/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColor, _) => MaterialApp.router(
        theme: ThemeData(
          colorSchemeSeed: lightColor?.primary ?? const Color(0xff6750a4),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
