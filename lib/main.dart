import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/src/app.dart';
import 'package:news_app/src/core/di.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  final prefs = await SharedPreferences.getInstance();
  await initializeDateFormatting('id_ID');
  di.init(prefs: prefs);

  FlutterNativeSplash.remove();

  runApp(
    const NewsApp(),
  );
}
