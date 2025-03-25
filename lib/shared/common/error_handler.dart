import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/di/di.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/shared/common/failure.dart';
import 'package:kabar/shared/utils/toast_util.dart';
import 'package:provider/provider.dart';

class ErrorHandler {
  static Future<void> handle(Object? error) async {
    final context = getIt<AppRouter>().navigatorKey.currentContext;
    if (context == null) {
      return;
    }
    switch (error) {
      case final ApiFailure apiFailure:
        switch (apiFailure.httpCode) {
          case HttpStatus.unauthorized:
            final isLogined = context.read<AppState>().userInfo != null;
            if (isLogined) {
              await context.read<AppController>().clearAllData();
              if (context.mounted) {
                await context.router.replaceAll([const LoginRoute()]);
              }
            }
            if (context.mounted) {
              showError(context, error);
            }
          default:
            showError(context, error);
        }
      default:
        showError(context, error);
    }
  }

  static void showError(BuildContext context, Object? error) {
    switch (error) {
      case final ApiFailure apiFailure:
        if (apiFailure.message != null && apiFailure.message!.isNotEmpty) {
          ToastUtil.showError(context, apiFailure.message!);
        } else {
          ToastUtil.showError(
              context, LocaleKeys.error_something_went_wrong.tr());
        }
      case NoInternetFailure _:
        ToastUtil.showError(context, LocaleKeys.error_no_internet.tr());
      case ConnectionTimeoutFailure _:
        ToastUtil.showError(context, LocaleKeys.error_connection_timeout.tr());
      case UnknowFailure _:
        ToastUtil.showError(
            context, LocaleKeys.error_something_went_wrong.tr());
      default:
        return;
    }
  }
}
