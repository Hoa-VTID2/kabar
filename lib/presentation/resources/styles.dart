import 'package:flutter/cupertino.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/themes.dart';

abstract class AppStyles {
  static final displayLarge = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 48,
    height: 72 / 48,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final displayMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 48 / 32,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final displaySmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 36 / 24,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final displayLargeBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 48,
    height: 72 / 48,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final displayMediumBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 48 / 32,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final displaySmallBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 36 / 24,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final textLarge = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 30 / 20,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final textMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final textSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final textXSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 19.5 / 13,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final linkLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 30 / 20,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final linkMedium = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final linkSmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static final linkXSmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    height: 19.5 / 13,
    letterSpacing: 0.12,
    color: AppColors.mainTextColor,
    fontFamily: AppTheme.appFontFamily,
  );

  static BoxShadow defaultShadow = BoxShadow(
    color: AppColors.black.withAlpha((0.05 * 255).round()),
    blurRadius: 8,
    offset: const Offset(0, 8),
  );
}
