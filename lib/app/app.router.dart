// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/views/counter/counter_view.dart' as _i4;
import 'package:flutter_app_template/ui/views/gooey_edge_demo/gooey_edge_demo_view.dart'
    as _i6;
import 'package:flutter_app_template/ui/views/home/home_view.dart' as _i2;
import 'package:flutter_app_template/ui/views/login/login_view.dart' as _i5;
import 'package:flutter_app_template/ui/views/sparkle_party_demo/sparkle_party_demo_view.dart'
    as _i8;
import 'package:flutter_app_template/ui/views/squares_demo/squares_demo_view.dart'
    as _i11;
import 'package:flutter_app_template/ui/views/stars_demo/stars_demo_view.dart'
    as _i7;
import 'package:flutter_app_template/ui/views/startup/startup_view.dart' as _i3;
import 'package:flutter_app_template/ui/views/trigonometric/trigonometric_view.dart'
    as _i10;
import 'package:flutter_app_template/ui/views/verticle_page/verticle_page_view.dart'
    as _i9;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i13;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const counterView = '/counter-view';

  static const loginView = '/login-view';

  static const gooeyEdgeDemoView = '/gooey-edge-demo-view';

  static const starsDemoView = '/stars-demo-view';

  static const sparklePartyDemoView = '/sparkle-party-demo-view';

  static const verticlePageView = '/verticle-page-view';

  static const trigonometricView = '/trigonometric-view';

  static const squaresDemoView = '/squares-demo-view';

  static const all = <String>{
    homeView,
    startupView,
    counterView,
    loginView,
    gooeyEdgeDemoView,
    starsDemoView,
    sparklePartyDemoView,
    verticlePageView,
    trigonometricView,
    squaresDemoView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.counterView,
      page: _i4.CounterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.gooeyEdgeDemoView,
      page: _i6.GooeyEdgeDemoView,
    ),
    _i1.RouteDef(
      Routes.starsDemoView,
      page: _i7.StarsDemoView,
    ),
    _i1.RouteDef(
      Routes.sparklePartyDemoView,
      page: _i8.SparklePartyDemoView,
    ),
    _i1.RouteDef(
      Routes.verticlePageView,
      page: _i9.VerticlePageView,
    ),
    _i1.RouteDef(
      Routes.trigonometricView,
      page: _i10.TrigonometricView,
    ),
    _i1.RouteDef(
      Routes.squaresDemoView,
      page: _i11.SquaresDemoView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeView(key: args.key, startingIndex: args.startingIndex),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.CounterView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CounterView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.GooeyEdgeDemoView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.GooeyEdgeDemoView(),
        settings: data,
      );
    },
    _i7.StarsDemoView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.StarsDemoView(),
        settings: data,
      );
    },
    _i8.SparklePartyDemoView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.SparklePartyDemoView(),
        settings: data,
      );
    },
    _i9.VerticlePageView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.VerticlePageView(),
        settings: data,
      );
    },
    _i10.TrigonometricView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.TrigonometricView(),
        settings: data,
      );
    },
    _i11.SquaresDemoView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.SquaresDemoView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({
    this.key,
    required this.startingIndex,
  });

  final _i12.Key? key;

  final int startingIndex;

  @override
  String toString() {
    return '{"key": "$key", "startingIndex": "$startingIndex"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.startingIndex == startingIndex;
  }

  @override
  int get hashCode {
    return key.hashCode ^ startingIndex.hashCode;
  }
}

extension NavigatorStateExtension on _i13.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i12.Key? key,
    required int startingIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key, startingIndex: startingIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCounterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.counterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGooeyEdgeDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.gooeyEdgeDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStarsDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.starsDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSparklePartyDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.sparklePartyDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerticlePageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.verticlePageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTrigonometricView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.trigonometricView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSquaresDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.squaresDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i12.Key? key,
    required int startingIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key, startingIndex: startingIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCounterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.counterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGooeyEdgeDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.gooeyEdgeDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStarsDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.starsDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSparklePartyDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.sparklePartyDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerticlePageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.verticlePageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTrigonometricView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.trigonometricView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSquaresDemoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.squaresDemoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
