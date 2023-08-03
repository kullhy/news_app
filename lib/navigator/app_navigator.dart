import 'package:flutter/material.dart';
import 'package:learn_bloc_2/models/news/article.dart';
import 'package:learn_bloc_2/navigator/routes.dart';
import 'package:learn_bloc_2/pages/details/details_page.dart';
import 'package:learn_bloc_2/pages/login/login_page.dart';
import 'package:learn_bloc_2/pages/main_tab_bar/main_tab_bar.dart';
import 'package:learn_bloc_2/pages/splash/splash_page.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashPage:
        return _buildRoute(
          settings,
          const SplashPage(),
        );
      case Routes.logInPage:
        return _buildRoute(
          settings,
          const LoginPage(),
        );
      case Routes.homePage:
        return _buildRoute(
          settings,
          const MainTabBar(), 
        );
      case Routes.detailPage:
        final article = settings.arguments as Article;
        return _buildRoute(
          settings,
          DetailsPage(article: article,),
        );
      // case Routes.checkScreen:
      //   return _buildRoute(
      //     settings,
      //     const CheckWeatherScreen(),
      //   );
      default:
        return null;
    }
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
  ) {
    return MaterialPageRoute(
      builder: (context) => builder,
      settings: routeSettings,
    );
  }

  static Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future pushAndRemoveUntil<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future replaceWith<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) {
    state.popUntil(ModalRoute.withName(route));
  }

  static void pop([Object? arg]) {
    if (canPop) {
      state.pop(arg);
    }
  }

  static void popPush(
    String route, {
    Object? arguments,
  }) {
    if (canPop) {
      state.popAndPushNamed(route, arguments: arguments);
    }
  }

  static bool get canPop => state.canPop();

  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState get state => navigatorKey.currentState!;
}
