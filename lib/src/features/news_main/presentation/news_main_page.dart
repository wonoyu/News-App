import 'package:flutter/material.dart';
import 'package:news_app/src/core/constants/colors.dart';
import 'package:news_app/src/core/constants/constant_data.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/router.dart';

class NewsMainPage extends StatelessWidget {
  const NewsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: AppBar(
        title: const Text('News Categories'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          itemCount: ConstantData.newsCategories.length,
          itemBuilder: (context, index) {
            final categories = ConstantData.newsCategories.entries.toList();
            final category = categories[index].key;
            final icon = categories[index].value;
            return SizedBox(
              width: size.width,
              height:
                  ((size.height - kToolbarHeight - 56.0) / categories.length),
              child: Card(
                color: antiqueWhite,
                child: ListTile(
                  onTap: () {
                    if (index != 0) {
                      context.goNamed(RouteNames.categorizedNewsRoute,
                          extra: category);
                      return;
                    }
                    context.goNamed(RouteNames.allNewsRoute);
                  },
                  title: Text(
                    '${category[0].toUpperCase()}${category.substring(1)}',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: darkMagenta,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    icon,
                    color: cardinalRed,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
