import 'package:dynamic_color/dynamic_color.dart';
import 'package:flime/app/router/router.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MultiProvider(
          providers: [
            Provider<ThemeStore>(
                create: (_) => ThemeStore(
                      lightDynamic,
                      darkDynamic,
                    )),
          ],
          child: Consumer<ThemeStore>(
            builder: (_, theme, __) {
              return Observer(
                builder: (context) {
                  return MaterialApp.router(
                    theme: theme.lightTheme,
                    darkTheme: theme.darkTheme,
                    themeMode: theme.themeMode,
                    routerDelegate: _appRouter.delegate(),
                    routeInformationParser: _appRouter.defaultRouteParser(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
