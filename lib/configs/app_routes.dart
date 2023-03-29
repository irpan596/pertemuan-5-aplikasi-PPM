import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipan/modul/news_detail/news_detail.dart';
import 'package:ipan/modul/splash_screen/splash_screen.dart';

import '../models/user.dart';
import '../modul/home_screen/home_screen.dart';

class AppRoutes {
  static const String splash = "splash";
  static const String home = "home";
  static const String profile = "profile";
  static const String newsDetail = "news-detail";

  static Page _splashScreenRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      key: state.pageKey,
      child: const SplashScreen(),
    );
  }

  static Page _homeScreenRoutePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    late User user;
    if (state.extra != null && state.extra is User) {
      user = state.extra as User;
    } else {
      user = User(
      id: 012,
      name: "Nurul Irpan",
      userName: "KUCINGTERIAK",
      email: "2006012@itg.ac.id",
      profileImage: "https://i.ibb.co/zxg4brm/271907646-953883455566677-5164685909961204627-n.jpg",
      phoneNumber: "081312238362",
      );
    }
    return CustomTransitionPage(
      child: HomeScreen(
        key: state.pageKey,
        user: user,
      ),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Page _newsDetailScreenRouteBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    if (state.params["id"] != null) {
      return MaterialPage(
        key: state.pageKey,
        child: NewsDetailScreen(
          newsId: state.params["id"]!,
        ),
      );
    } else {
      return const MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text("Data Not Found"),
          ),
        ),
      );
    }
  }

  static final GoRouter goRouter = GoRouter(
    routerNeglect: true,
    routes: [
      GoRoute(
        name: splash,
        path: "/splash",
        pageBuilder: _splashScreenRouteBuilder,
      ),
      GoRoute(
        name: home,
        path: "/home",
        pageBuilder: _homeScreenRoutePageBuilder,
        routes: [
          GoRoute(
            name: newsDetail,
            path: "news-detail/:id",
            pageBuilder: _newsDetailScreenRouteBuilder,
          ),
        ],
      ),
    ],
    initialLocation: "/splash",
  );
}
