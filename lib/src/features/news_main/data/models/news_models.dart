import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';

class NewsResponseModel {
  NewsResponseModel({
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
  final List<ArticleModel> articles;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsResponseModel(
        status: json['status'],
        errorCode: json['code'],
        errorMessage: json['message'],
        totalResults: json['totalResults'],
        articles: json['articles'] == null
            ? []
            : List<ArticleModel>.from(
                json['articles'].map((e) => ArticleModel.fromJson(e))),
      );

  NewsResponseEntity toEntity() => NewsResponseEntity(
        status: status,
        errorCode: errorCode,
        errorMessage: errorMessage,
        totalResults: totalResults,
        articles: List<ArticleEntity>.from(articles.map((e) => e.toEntity())),
      );
}

class ArticleModel {
  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final ArticleSourceModel source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: ArticleSourceModel.fromJson(json['source']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: DateTime.parse(json['publishedAt']).toLocal(),
        content: json['content'],
      );

  ArticleEntity toEntity() => ArticleEntity(
        source: source.toEntity(),
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );
}

class ArticleSourceModel {
  ArticleSourceModel({
    required this.id,
    required this.name,
  });

  final String? id;
  final String name;

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) =>
      ArticleSourceModel(
        id: json['id'],
        name: json['name'],
      );

  ArticleSourceEntity toEntity() => ArticleSourceEntity(id: id, name: name);
}
