import 'package:envied/envied.dart';
import 'package:news_app/src/core/env/app_env.dart';
import 'package:news_app/src/core/env/app_env_fields.dart';

part 'env.g.dart';

@Envied(name: 'Env', path: '.env')
class Env implements AppEnv, AppEnvFields {
  Env();

  @override
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  final String apiKey = _Env.apiKey;

  @override
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  final String baseUrl = _Env.baseUrl;

  @override
  @EnviedField(varName: 'EVERYTHING_ENDPOINT', obfuscate: true)
  final String everythingEndpoint = _Env.everythingEndpoint;

  @override
  @EnviedField(varName: 'TOP_HEADLINES_ENDPOINT', obfuscate: true)
  final String topHeadlinesEndpoint = _Env.topHeadlinesEndpoint;
}
