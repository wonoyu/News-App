import 'package:news_app/src/core/env/app_env_fields.dart';
import 'package:news_app/src/core/env/env.dart';

abstract class AppEnv implements AppEnvFields {
  factory AppEnv() => _instance;

  static final AppEnv _instance = Env();
}
