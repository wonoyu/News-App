import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/core/constants/themes.dart';
import 'package:news_app/src/core/di.dart' as di;

import 'package:news_app/src/core/router.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/get_categorized_news_bloc.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/search_categorized_news_bloc.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<GetCategorizedNewsBloc>()),
        BlocProvider(create: (_) => di.locator<SearchCategorizedNewsBloc>()),
      ],
      child: MaterialApp.router(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routerConfig: router,
      ),
    );
  }
}
