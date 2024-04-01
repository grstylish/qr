import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:registration_ui/features/app/ui/pages/app.dart';
import 'package:registration_ui/services/shared_preference.dart';
import 'translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await sharedPreference.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('kk'), Locale('ru'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: App(),
    ),
  );
}
