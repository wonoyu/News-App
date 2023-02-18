import 'package:flutter/material.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.article});

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (article.urlToImage != null)
                  Image.network(
                    article.urlToImage!,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) =>
                            child,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null ||
                          loadingProgress.expectedTotalBytes == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: (loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!),
                        ),
                      );
                    },
                  ),
                if (article.urlToImage == null) ...[
                  const Icon(
                    Icons.image_not_supported_outlined,
                    size: 100,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Image not found',
                    style: theme.textTheme.headline6,
                  )
                ],
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    article.title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline6,
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Author: ${article.author}, Source: ${article.source.name}',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    article.content ??
                        article.description ??
                        'Article content cannot be found!!!',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
