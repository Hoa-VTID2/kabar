import 'package:flutter/material.dart';
import 'package:kabar/gen/fonts.gen.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/styles.dart';
import 'package:kabar/presentation/resources/theme_data.dart';
import 'package:kabar/shared/extensions/theme_data_extensions.dart';

const kDefaultPaddingLabelTabBar = 8.0;

abstract class AppTheme {
  static const _dividerTheme = DividerThemeData(
    space: 0,
    thickness: 1,
    color: AppColors.pattensBlue,
  );

  static String? get appFontFamily {
    return FontFamily.poppins;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor, primary: AppColors.primaryColor),
      fontFamily: appFontFamily,
      appBarTheme: AppBarTheme(
        color: AppColors.white,
        titleTextStyle: AppStyles.linkMedium,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thickness: WidgetStateProperty.all(6.0),
        radius: const Radius.circular(3),
        minThumbLength: 90,
        thumbColor: WidgetStateProperty.all(AppColors.pattensBlue),
      ),
      scaffoldBackgroundColor: AppColors.background,
      dividerTheme: _dividerTheme,
      indicatorColor: AppColors.primaryColor,
      tabBarTheme: TabBarTheme(
        labelStyle: AppStyles.textMedium,
        unselectedLabelStyle: AppStyles.textMedium.copyWith(
          color: AppColors.subTextColor
        ),
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.atlantis,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddingLabelTabBar,
        ),
      ),
      textTheme: const TextTheme(
      )
    )..addOwn(
        Brightness.light,
        AppThemeData(
          textTheme: AppTextTheme(
            displayLarge: AppStyles.displayLarge,
            displayMedium: AppStyles.displayMedium,
            displaySmall: AppStyles.displaySmall,
            displayLargeBold: AppStyles.displayLargeBold,
            displayMediumBold: AppStyles.displayMediumBold,
            displaySmallBold: AppStyles.displaySmallBold,
            textLarge: AppStyles.textLarge,
            textMedium: AppStyles.textMedium,
            textSmall: AppStyles.textSmall,
            textXSmall: AppStyles.textXSmall,
            linkLarge: AppStyles.linkLarge,
            linkMedium: AppStyles.linkMedium,
            linkSmall: AppStyles.linkSmall,
            linkXSmall: AppStyles.linkXSmall,
          ),
          colorSchema: AppColorSchema(
            primary: AppColors.primaryColor,
            mainText: AppColors.mainTextColor,
            successColor: AppColors.successColor,
            mainStrokeColor: AppColors.mainStrokeColor,
            secondaryStrokeColor: AppColors.secondaryStrokeColor,
            mainBackgroundColor: AppColors.mainBackgroundColor,
            replaceTextColor: AppColors.replaceTextColor,
            warning: AppColors.warningColor,
            subTextColor: AppColors.subTextColor,
            secondaryBackgroundColors: AppColors.secondaryBackgroundColors,
          ),
        ),
      );
  }

  static ThemeData get darkTheme {
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: AppBarTheme(
        color: AppColors.darkBackground,
        titleTextStyle: AppStyles.linkMedium.copyWith(color: Colors.white),
      ),
      textTheme: lightTheme.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    )..addOwn(Brightness.dark,
      AppThemeData(
        textTheme: AppTextTheme(
          displayLarge: AppStyles.displayLarge.copyWith(color: AppColors.white),
          displayMedium: AppStyles.displayMedium.copyWith(color: AppColors.white),
          displaySmall: AppStyles.displaySmall.copyWith(color: AppColors.white),
          displayLargeBold: AppStyles.displayLargeBold.copyWith(color: AppColors.white),
          displayMediumBold: AppStyles.displayMediumBold.copyWith(color: AppColors.white),
          displaySmallBold: AppStyles.displaySmallBold.copyWith(color: AppColors.white),
          textLarge: AppStyles.textLarge.copyWith(color: AppColors.white),
          textMedium: AppStyles.textMedium.copyWith(color: AppColors.white),
          textSmall: AppStyles.textSmall.copyWith(color: AppColors.white),
          textXSmall: AppStyles.textXSmall.copyWith(color: AppColors.white),
          linkLarge: AppStyles.linkLarge.copyWith(color: AppColors.white),
          linkMedium: AppStyles.linkMedium.copyWith(color: AppColors.white),
          linkSmall: AppStyles.linkSmall.copyWith(color: AppColors.white),
          linkXSmall: AppStyles.linkXSmall.copyWith(color: AppColors.white),
        ),
        colorSchema: AppColorSchema(
          primary: AppColors.primaryColor,
          mainText: AppColors.mainTextColor,
          successColor: AppColors.successColor,
          mainStrokeColor: AppColors.mainStrokeColor,
          secondaryStrokeColor: AppColors.secondaryStrokeColor,
          mainBackgroundColor: AppColors.mainBackgroundColor,
          replaceTextColor: AppColors.replaceTextColor,
          warning: AppColors.warningColor,
          subTextColor: AppColors.subTextColor,
          secondaryBackgroundColors: AppColors.secondaryBackgroundColors,
        ),
      ),
    );
  }
}
