import 'package:dynamic_color/dynamic_color.dart';
import 'package:flime/api/platform_api.g.dart';
import 'package:flime/keyboard/router/router.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';


class KeyboardView extends StatelessWidget {
  KeyboardView({Key? key}) : super(key: key);

  final _keyboardRouter = KeyboardRouter();

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MultiProvider(
          providers: [
            Provider<LayoutApi>(
              create: (_) => LayoutApi(),
            ),
            Provider<InputConnectionApi>(
              create: (_) => InputConnectionApi(),
            ),
            Provider<InputService>(
              create: (_) => RimeService()..init(),
              lazy: false,
            ),
            Provider<ThemeStore>(
              create: (_) => ThemeStore(
                lightDynamic,
                darkDynamic,
              ),
            ),
            ProxyProvider<LayoutApi,ConstraintStore>(
              update: (_, layoutApi, __) => ConstraintStore(layoutApi)..setupReactions(),
            ),
          ],
          child: Consumer<ThemeStore>(
            builder: (context, theme, child) {
              return Observer(
                builder: (context) {
                  return MaterialApp.router(
                    theme: theme.lightTheme,
                    darkTheme: theme.darkTheme,
                    themeMode: theme.themeMode,
                    debugShowCheckedModeBanner: false,
                    routerDelegate: _keyboardRouter.delegate(),
                    routeInformationParser:
                        _keyboardRouter.defaultRouteParser(),
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
