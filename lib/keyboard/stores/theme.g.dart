// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeStore on AbstractThemeStore, Store {
  Computed<ThemeMode>? _$themeModeComputed;

  @override
  ThemeMode get themeMode =>
      (_$themeModeComputed ??= Computed<ThemeMode>(() => super.themeMode,
              name: 'AbstractThemeStore.themeMode'))
          .value;

  late final _$brightnessAtom =
      Atom(name: 'AbstractThemeStore.brightness', context: context);

  @override
  Brightness get brightness {
    _$brightnessAtom.reportRead();
    return super.brightness;
  }

  @override
  set brightness(Brightness value) {
    _$brightnessAtom.reportWrite(value, super.brightness, () {
      super.brightness = value;
    });
  }

  late final _$AbstractThemeStoreActionController =
      ActionController(name: 'AbstractThemeStore', context: context);

  @override
  void changeTheme(Brightness newMode) {
    final _$actionInfo = _$AbstractThemeStoreActionController.startAction(
        name: 'AbstractThemeStore.changeTheme');
    try {
      return super.changeTheme(newMode);
    } finally {
      _$AbstractThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brightness: ${brightness},
themeMode: ${themeMode}
    ''';
  }
}
