import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';
import 'package:news_app/src/features/news_main/presentation/categorized_news_page.dart';
import 'package:news_app/src/features/news_main/presentation/news_detail_page.dart';
import 'package:news_app/src/features/news_main/presentation/news_main_page.dart';
import 'package:news_app/src/features/news_main/presentation/search_page.dart';

class RouteNames {
  static const mainRoute = 'main-route';
  static const categorizedNewsRoute = 'categorized-route';
  static const detailNewsRoute = 'detail-route';
  static const searchDetailNewsRoute = 'search-detail-route';
  static const searchNewsRoute = 'search-route';
}

class RoutePaths {
  // top-level paths
  static const main = '/';
  static const categorizedNews = 'news/categorized/:category';
  static const searchDetailNews = 'detail/:title';
  static const detailNews = 'detail/:title';
  static const searchNews = 'search';
}

final routeObserver = RouteObserver();

final router = GoRouter(
  initialLocation: RoutePaths.main,
  observers: [routeObserver],
  routes: [
    GoRoute(
      path: RoutePaths.main,
      name: RouteNames.mainRoute,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const NewsMainPage(),
      ),
      routes: [
        GoRoute(
          path: RoutePaths.categorizedNews,
          name: RouteNames.categorizedNewsRoute,
          pageBuilder: (context, state) {
            final category = state.params['category'] as String;
            return CupertinoPage(
              key: state.pageKey,
              child: CategorizedNewsPage(category: category),
            );
          },
          routes: [
            GoRoute(
              path: RoutePaths.detailNews,
              name: RouteNames.detailNewsRoute,
              pageBuilder: (context, state) {
                final article = state.extra as ArticleEntity;
                return CupertinoPage(
                  key: state.pageKey,
                  child: NewsDetailPage(article: article),
                );
              },
            ),
            GoRoute(
              path: RoutePaths.searchNews,
              name: RouteNames.searchNewsRoute,
              pageBuilder: (context, state) {
                final category = state.params['category'] as String;
                return MaterialPage(
                    key: state.pageKey,
                    child: SearchCategorizedNewsPage(category: category));
              },
              routes: [
                GoRoute(
                  path: RoutePaths.searchDetailNews,
                  name: RouteNames.searchDetailNewsRoute,
                  pageBuilder: (context, state) {
                    final article = state.extra as ArticleEntity;
                    return CupertinoPage(
                      key: state.pageKey,
                      child: NewsDetailPage(article: article),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
