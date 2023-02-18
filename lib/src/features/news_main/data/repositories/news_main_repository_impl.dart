import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/core/failures.dart';
import 'package:news_app/src/features/news_main/data/datasources/news_main_remote_datasource.dart';
import 'package:news_app/src/features/news_main/domain/entities/news_entities.dart';
import 'package:news_app/src/features/news_main/domain/repositories/news_main_repository.dart';

class NewsMainRepositoryImpl implements NewsMainRepository {
  final NewsMainRemoteDatasource remoteDatasource;
  final Logger logger;

  NewsMainRepositoryImpl(
      {required this.remoteDatasource, required this.logger});

  @override
  TaskEither<Failure, NewsResponseEntity> getCategorizedNews(String category,
          {String? query}) =>
      remoteDatasource.getCategorizedNews(category, query: query).chainEither(
            (r) => Either.tryCatch(
              () => r.toEntity(),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return EntityFormattingFailure(error, stackTrace);
              },
            ),
          );
}
