import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:kabar/app.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/di/di.dart';
import 'package:kabar/shared/constants.dart';
import 'package:kabar/shared/extensions/int_extensions.dart';
import 'package:kabar/shared/utils/logger.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

// void setupPrerequisites(FirebaseOptions? options) {}

void setupPrerequisites() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning,
    ];
    await EasyLocalization.ensureInitialized();
    configureDependencies();

    timeago.setLocaleMessages('en', timeago.ViMessages());
    timeago.setDefaultLocale(APP_LOCALE.languageCode);

    await Future<void>.delayed(2.seconds);

    final appController = getIt<AppController>();

    // Get init data
    await appController.getInitData();
    _startApp(appController);
  }, (error, stackTrace) {
    logger.e('Error', error: error, stackTrace: stackTrace);
  });
}

void _startApp(AppController appController) {
  runApp(EasyLocalization(
    supportedLocales: const [APP_LOCALE],
    path: 'assets/translations',
    fallbackLocale: APP_LOCALE,
    child: StateNotifierProvider<AppController, AppState>(
      create: (_) => appController,
      child: const MyApp(),
    ),
  ));
}
