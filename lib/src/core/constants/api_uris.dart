import 'package:news_app/src/core/env/app_env.dart';

class ApiUris {
  final AppEnv env;

  ApiUris(this.env);

  Map<String, String> headers() => {
        'Authorization': 'Bearer ${env.apiKey}',
      };

  Uri categorizedNewsUri(String category) => Uri(
        scheme: 'https',
        host: env.baseUrl,
        path: env.topHeadlinesEndpoint,
        queryParameters: {'country': 'id', 'category': category},
      );
}
