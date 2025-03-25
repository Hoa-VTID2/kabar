import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kabar/presentation/resources/theme_data.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/shared/extensions/theme_data_extensions.dart';

extension ContextExt on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you resize your screen (like on a browser or
  /// desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you resize your screen (like on a browser or
  /// desktop window)
  double get width => mediaQuerySize.width;

  /// similar to [MediaQuery.of(context).padding]
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  /// similar to [MediaQuery.of(context).padding]
  ThemeData get theme => Theme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => theme.brightness == Brightness.dark;

  AppThemeData themeOwn() {
    return Theme.of(this).own();
  }

  AppTextTheme? styleOwn() {
    return Theme.of(this).own().textTheme;
  }

  AppColorSchema? colorOwn() {
    return Theme.of(this).own().colorSchema;
  }

  void backToHome() {
    router.popUntil(
      (route) {
        return route.settings.name == HomeRoute.name;
      },
    );
  }
}
