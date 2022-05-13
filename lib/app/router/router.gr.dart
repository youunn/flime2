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

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    InputRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const InputPage());
    },
    GalleryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const GalleryPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/'),
        RouteConfig(InputRoute.name, path: '/input'),
        RouteConfig(GalleryRoute.name, path: '/gallery')
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [InputPage]
class InputRoute extends PageRouteInfo<void> {
  const InputRoute() : super(InputRoute.name, path: '/input');

  static const String name = 'InputRoute';
}

/// generated route for
/// [GalleryPage]
class GalleryRoute extends PageRouteInfo<void> {
  const GalleryRoute() : super(GalleryRoute.name, path: '/gallery');

  static const String name = 'GalleryRoute';
}
