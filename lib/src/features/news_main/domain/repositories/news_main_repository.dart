import 'package:fpdart/fpdart.dart';
import 'package:news_app/src/core/failures.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';

abstract class NewsMainRepository {
  TaskEither<Failure, NewsResponseEntity> getCategorizedNews(String category,
      {String? query});
}
