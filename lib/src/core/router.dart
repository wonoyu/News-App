import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/features/news_main/presentation/all_news_page.dart';
import 'package:news_app/src/features/news_main/presentation/categorized_news_page.dart';
import 'package:news_app/src/features/news_main/presentation/news_main_page.dart';

class RouteNames {
  static const mainRoute = 'main-route';
  static const categorizedNewsRoute = 'categorized-route';
  static const allNewsRoute = 'all-route';
}

class RoutePaths {
  // top-level paths
  static const main = '/';
  static const categorizedNews = 'news/categorized';
  static const allNews = 'news/all';
}

final routeObserver = RouteObserver();

final router = GoRouter(
  initialLocation: RoutePaths.main,
  observers: [routeObserver],
  routes: [
    GoRoute(
      path: RoutePaths.main,
      name: RouteNames.mainRoute,
      pageBuilder: (context, state) => const MaterialPage(
        child: NewsMainPage(),
      ),
      routes: [
        GoRoute(
          path: RoutePaths.categorizedNews,
          name: RouteNames.categorizedNewsRoute,
          pageBuilder: (context, state) {
            final category = state.extra as String;
            return CupertinoPage(
              child: CategorizedNewsPage(category: category),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.allNews,
          name: RouteNames.allNewsRoute,
          pageBuilder: (context, state) => const CupertinoPage(
            child: AllNewsPage(),
          ),
        ),
      ],
    ),
  ],
);
