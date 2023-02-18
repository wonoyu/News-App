import 'package:news_app/src/core/env/app_env.dart';

class ApiUris {
  final AppEnv env;

  ApiUris(this.env);

  Map<String, String> headers() => {
        'Authorization': 'Bearer ${env.apiKey}',
      };

  Uri categorizedNewsUri(String category, {String? query}) {
    Map<String, String> queryParameters = {
      'country': 'id',
      'category': category,
    };
    if (query != null) {
      queryParameters['query'] = query;
    }
    return Uri(
      scheme: 'https',
      host: env.baseUrl,
      path: env.topHeadlinesEndpoint,
      queryParameters: queryParameters,
    );
  }
}
