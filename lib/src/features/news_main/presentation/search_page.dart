import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/core/router.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/get_categorized_news_bloc.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/search_categorized_news_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchCategorizedNewsPage extends StatefulWidget {
  const SearchCategorizedNewsPage({super.key, required this.category});

  final String category;

  @override
  State<SearchCategorizedNewsPage> createState() =>
      _SearchCategorizedNewsPageState();
}

class _SearchCategorizedNewsPageState extends State<SearchCategorizedNewsPage> {
  final _query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Categorized News'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<String>(
                  value: 'latest',
                  child: Text('Latest'),
                ),
                const PopupMenuItem<String>(
                  value: 'earliest',
                  child: Text('Earliest'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'latest') {
                context
                    .read<SearchCategorizedNewsBloc>()
                    .add(const SortSearchedNews(true));
                return;
              }
              context
                  .read<SearchCategorizedNewsBloc>()
                  .add(const SortSearchedNews(false));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            TextFormField(
              controller: _query,
              decoration: const InputDecoration(
                hintText: 'Search title, name or author...',
              ),
              onChanged: (query) =>
                  context.read<SearchCategorizedNewsBloc>().add(
                        SearchCategorizedNews(widget.category, query),
                      ),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<SearchCategorizedNewsBloc, SearchCategorizedNewsState>(
              builder: (context, state) {
                if (state.status == CategorizedNewsState.error) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state.status == CategorizedNewsState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.data == null) {
                  return const Center(
                    child: Text('No data matching query'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.data!.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.data!.articles[index];
                      return Card(
                        child: ListTile(
                          onTap: () => context.goNamed(
                              RouteNames.searchDetailNewsRoute,
                              extra: article,
                              params: {
                                'category': widget.category,
                                'title': article.title,
                              }),
                          title: Text(article.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Author: ${article.author}, Source: ${article.source.name}'),
                              Text(
                                DateFormat('EEEE, dd MMMM yyyy, HH:mm', 'id_ID')
                                    .format(article.publishedAt.toLocal()),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }
}
