import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData({
    this.textTheme,
    this.colorSchema,
  });

  final AppTextTheme? textTheme;
  final AppColorSchema? colorSchema;
}

class AppTextTheme {
  AppTextTheme(
      {this.displayLarge,
      this.displayMedium,
      this.displaySmall,
      this.displayLargeBold,
      this.displayMediumBold,
      this.displaySmallBold,
      this.textLarge,
      this.textMedium,
      this.textSmall,
      this.textXSmall,
      this.linkLarge,
      this.linkMedium,
      this.linkSmall,
      this.linkXSmall});

  final TextStyle? displayLargeBold;
  final TextStyle? displayMediumBold;
  final TextStyle? displaySmallBold;
  final TextStyle? displayLarge;
  final TextStyle? displayMedium;
  final TextStyle? displaySmall;
  final TextStyle? textLarge;
  final TextStyle? textMedium;
  final TextStyle? textSmall;
  final TextStyle? textXSmall;
  final TextStyle? linkLarge;
  final TextStyle? linkMedium;
  final TextStyle? linkSmall;
  final TextStyle? linkXSmall;
}

class AppColorSchema {
  AppColorSchema({
    this.primary,
    this.mainText,
    this.successColor,
    this.mainStrokeColor,
    this.mainBackgroundColor,
    this.secondaryStrokeColor,
    this.secondaryBackgroundColors,
    this.subTextColor,
    this.secondary1,
    this.secondary2,
    this.secondary3,
    this.secondary4,
    this.secondary5,
    this.warning,
    this.replaceTextColor,
  });

  final Color? primary;
  final Color? mainText;
  final Color? successColor;
  final Color? mainStrokeColor;
  final Color? mainBackgroundColor;
  final Color? secondary1;
  final Color? secondary2;
  final Color? secondary3;
  final Color? secondary4;
  final Color? secondary5;
  final Color? secondaryStrokeColor;
  final Color? secondaryBackgroundColors;
  final Color? subTextColor;
  final Color? warning;
  final Color? replaceTextColor;
}
