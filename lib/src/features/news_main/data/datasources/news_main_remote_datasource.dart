import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/core/constants/api_uris.dart';
import 'package:news_app/src/core/failures.dart';
import 'package:news_app/src/core/util_functions.dart';
import 'package:news_app/src/features/news_main/data/models/news_models.dart';
import 'package:http/http.dart' as http;

abstract class NewsMainRemoteDatasource {
  TaskEither<Failure, NewsResponseModel> getCategorizedNews(String category,
      {String? query});
}

class NewsMainRemoteDatasourceImpl implements NewsMainRemoteDatasource {
  final http.Client client;
  final ApiUris apiUris;
  final Logger logger;

  NewsMainRemoteDatasourceImpl(
      {required this.client, required this.apiUris, required this.logger});

  @override
  TaskEither<Failure, NewsResponseModel> getCategorizedNews(String category,
          {String? query}) =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async => await http.get(
            apiUris.categorizedNewsUri(category, query: query),
            headers: apiUris.headers()),
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          // check if status code is 200, otherwise returns failure
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          // check if body is a valid json format
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          // converts json to dart map, returns failure if fails
          .chainEither(
            (json) => Either<Failure, Map<String, dynamic>>.safeCast(
              json,
              (error) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(json);
              },
            ),
          )
          // format dart map to corresponding data model
          .chainEither(
            (map) => Either<Failure, NewsResponseModel>.tryCatch(
              () => NewsResponseModel.fromJson(map),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return FormattingFailure(error, stackTrace);
              },
            ),
          );
}
