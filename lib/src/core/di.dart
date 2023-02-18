import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:news_app/src/core/constants/api_uris.dart';
import 'package:news_app/src/core/env/app_env.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/features/news_main/data/datasources/news_main_remote_datasource.dart';
import 'package:news_app/src/features/news_main/data/repositories/news_main_repository_impl.dart';
import 'package:news_app/src/features/news_main/domain/repositories/news_main_repository.dart';
import 'package:news_app/src/features/news_main/domain/usecases/get_categorized_news_usecase.dart';
import 'package:news_app/src/features/news_main/presentation/bloc/get_categorized_news_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.I;

void init({required SharedPreferences prefs}) async {
  // core
  locator.registerLazySingleton<AppEnv>(() => AppEnv());
  locator.registerLazySingleton<http.Client>(() => http.Client());
  locator.registerLazySingleton<SharedPreferences>(() => prefs);
  locator.registerLazySingleton<ApiUris>(() => ApiUris(locator()));
  locator.registerLazySingleton<Logger>(
      () => Logger(printer: PrettyPrinter(colors: false)));

  // datasources
  locator.registerLazySingleton<NewsMainRemoteDatasource>(() =>
      NewsMainRemoteDatasourceImpl(
          client: locator(), apiUris: locator(), logger: locator()));

  // repositories
  locator.registerLazySingleton<NewsMainRepository>(() =>
      NewsMainRepositoryImpl(remoteDatasource: locator(), logger: locator()));

  // usecases
  locator.registerLazySingleton<GetCategorizedNewsUsecase>(
      () => GetCategorizedNewsUsecase(repository: locator()));

  // bloc
  locator.registerFactory(() => GetCategorizedNewsBloc(locator()));
}
