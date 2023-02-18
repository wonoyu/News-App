import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/core/router.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/get_categorized_news_bloc.dart';
import 'package:go_router/go_router.dart';

class CategorizedNewsPage extends StatefulWidget {
  const CategorizedNewsPage({super.key, required this.category});

  final String category;

  @override
  State<CategorizedNewsPage> createState() => _CategorizedNewsPageState();
}

class _CategorizedNewsPageState extends State<CategorizedNewsPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetCategorizedNewsBloc>()
        .add(GetCategorizedNews(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.category[0].toUpperCase()}${widget.category.substring(1)} News'),
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
                    .read<GetCategorizedNewsBloc>()
                    .add(const SortCategorizedNews(true));
                return;
              }
              context
                  .read<GetCategorizedNewsBloc>()
                  .add(const SortCategorizedNews(false));
            },
          ),
        ],
      ),
      body: BlocBuilder<GetCategorizedNewsBloc, GetCategorizedNewsState>(
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
              child: Text('News cannot be found'),
            );
          }
          return ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            itemCount: state.data!.articles.length,
            itemBuilder: (context, index) {
              final article = state.data!.articles[index];
              return Card(
                child: ListTile(
                  onTap: () => context.goNamed(RouteNames.detailNewsRoute,
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RouteNames.searchNewsRoute,
            params: {'category': widget.category}),
        child: const Icon(Icons.search_outlined),
      ),
    );
  }
}
