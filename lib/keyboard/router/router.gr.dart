// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$KeyboardRouter extends RootStackRouter {
  _$KeyboardRouter([GlobalKey<NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainLayout());
    },
    ExtendedRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ExtendedLayout());
    },
    PrimaryKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PrimaryKeyboardLayout());
    },
    SymbolKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SymbolKeyboardLayout());
    },
    NumberKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const NumberKeyboardLayout());
    },
    FullKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const FullKeyboardLayout());
    },
    FunctionalKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const FunctionalKeyboardLayout());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/main', fullMatch: true),
        RouteConfig(MainRoute.name, path: '/main', children: [
          RouteConfig('#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'primary',
              fullMatch: true),
          RouteConfig(PrimaryKeyboardRoute.name,
              path: 'primary', parent: MainRoute.name),
          RouteConfig(SymbolKeyboardRoute.name,
              path: 'symbol', parent: MainRoute.name),
          RouteConfig(NumberKeyboardRoute.name,
              path: 'number', parent: MainRoute.name)
        ]),
        RouteConfig(ExtendedRoute.name, path: '/extended', children: [
          RouteConfig(FullKeyboardRoute.name,
              path: 'full', parent: ExtendedRoute.name),
          RouteConfig(FunctionalKeyboardRoute.name,
              path: 'functional', parent: ExtendedRoute.name)
        ])
      ];
}

/// generated route for
/// [MainLayout]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(MainRoute.name, path: '/main', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [ExtendedLayout]
class ExtendedRoute extends PageRouteInfo<void> {
  const ExtendedRoute({List<PageRouteInfo>? children})
      : super(ExtendedRoute.name, path: '/extended', initialChildren: children);

  static const String name = 'ExtendedRoute';
}

/// generated route for
/// [PrimaryKeyboardLayout]
class PrimaryKeyboardRoute extends PageRouteInfo<void> {
  const PrimaryKeyboardRoute()
      : super(PrimaryKeyboardRoute.name, path: 'primary');

  static const String name = 'PrimaryKeyboardRoute';
}

/// generated route for
/// [SymbolKeyboardLayout]
class SymbolKeyboardRoute extends PageRouteInfo<void> {
  const SymbolKeyboardRoute() : super(SymbolKeyboardRoute.name, path: 'symbol');

  static const String name = 'SymbolKeyboardRoute';
}

/// generated route for
/// [NumberKeyboardLayout]
class NumberKeyboardRoute extends PageRouteInfo<void> {
  const NumberKeyboardRoute() : super(NumberKeyboardRoute.name, path: 'number');

  static const String name = 'NumberKeyboardRoute';
}

/// generated route for
/// [FullKeyboardLayout]
class FullKeyboardRoute extends PageRouteInfo<void> {
  const FullKeyboardRoute() : super(FullKeyboardRoute.name, path: 'full');

  static const String name = 'FullKeyboardRoute';
}

/// generated route for
/// [FunctionalKeyboardLayout]
class FunctionalKeyboardRoute extends PageRouteInfo<void> {
  const FunctionalKeyboardRoute()
      : super(FunctionalKeyboardRoute.name, path: 'functional');

  static const String name = 'FunctionalKeyboardRoute';
}
