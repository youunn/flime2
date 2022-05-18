import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme.g.dart';

class ThemeStore = AbstractThemeStore with _$ThemeStore;

abstract class AbstractThemeStore with Store {
  late final ThemeData lightTheme;
  late final ThemeData darkTheme;

  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;

  AbstractThemeStore(this.lightDynamic, this.darkDynamic) {
    final lightColors = _colors(Brightness.light);
    lightTheme = ThemeData.light().copyWith(
      // pageTransitionsTheme: const PageTransitionsTheme(),
      colorScheme: lightColors,
      scaffoldBackgroundColor: lightColors.background,
      useMaterial3: true,
    );

    final darkColors = _colors(Brightness.dark);
    darkTheme = ThemeData.dark().copyWith(
      // pageTransitionsTheme: const PageTransitionsTheme(),
      colorScheme: darkColors,
      scaffoldBackgroundColor: darkColors.background,
      useMaterial3: true,
    );
  }

  @observable
  Brightness brightness = Brightness.dark;

  @computed
  ThemeMode get themeMode => brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;

  @action
  void changeTheme(Brightness newMode) {
    brightness = newMode;
  }

  ColorScheme _colors(Brightness brightness) {
    final dynamicPrimary = brightness == Brightness.light ? lightDynamic?.primary : darkDynamic?.primary;
    final fallbackColor = brightness == Brightness.light ? 0x6750A4 : 0xD0BCFF;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? Color(fallbackColor),
      brightness: brightness,
    );
  }
}
