class NewsResponseEntity {
  NewsResponseEntity({
    required this.status,
    required this.errorCode,
    required this.errorMessage,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final String? errorCode;
  final String? errorMessage;
  final int totalResults;
  final List<ArticleEntity> articles;
}

class ArticleEntity {
  ArticleEntity({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final ArticleSourceEntity source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
}

class ArticleSourceEntity {
  ArticleSourceEntity({
    required this.id,
    required this.name,
  });

  final String? id;
  final String name;
}
