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
    PrimaryKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PrimaryKeyboardLayout());
    },
    NumberKeyboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const NumberKeyboardLayout());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MainRoute.name, path: '/', children: [
          RouteConfig('#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'primary',
              fullMatch: true),
          RouteConfig(PrimaryKeyboardRoute.name,
              path: 'primary', parent: MainRoute.name),
          RouteConfig(NumberKeyboardRoute.name,
              path: 'number', parent: MainRoute.name)
        ])
      ];
}

/// generated route for
/// [MainLayout]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(MainRoute.name, path: '/', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [PrimaryKeyboardLayout]
class PrimaryKeyboardRoute extends PageRouteInfo<void> {
  const PrimaryKeyboardRoute()
      : super(PrimaryKeyboardRoute.name, path: 'primary');

  static const String name = 'PrimaryKeyboardRoute';
}

/// generated route for
/// [NumberKeyboardLayout]
class NumberKeyboardRoute extends PageRouteInfo<void> {
  const NumberKeyboardRoute() : super(NumberKeyboardRoute.name, path: 'number');

  static const String name = 'NumberKeyboardRoute';
}
