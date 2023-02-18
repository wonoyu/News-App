import 'package:fpdart/fpdart.dart';
import 'package:news_app/src/core/failures.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';
import 'package:news_app/src/features/news_main/domain/repositories/news_main_repository.dart';

class SearchCategorizedNewsUsecase {
  final NewsMainRepository repository;

  SearchCategorizedNewsUsecase({required this.repository});

  Future<Either<Failure, NewsResponseEntity>> execute(
          String category, String query) =>
      repository.getCategorizedNews(category, query: query).run();
}
