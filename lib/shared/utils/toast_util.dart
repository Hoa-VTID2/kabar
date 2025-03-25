import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';

class ToastUtil {
  static void showError(BuildContext context, String message) {
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;

    final toastWithButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorSchema?.warning,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            color: AppColors.white,
          ),
          const Gap(8),
          Flexible(
            child: Text(
              message,
              style: textTheme?.textMedium?.copyWith(
                color: AppColors.white,
                height: 18 / 14,
              ),
            ),
          ),
        ],
      ),
    );
    final fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: Center(child: toastWithButton),
      positionedToastBuilder: (context, child, _) {
        return Positioned(
          right: 24.0,
          left: 24.0,
          bottom: 48,
          child: child,
        );
      },
    );
  }

  static void showSuccess(BuildContext context, String message) {
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;

    final toastWithButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorSchema?.successColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.white,
          ),
          const Gap(8),
          Flexible(
            child: Text(
              message,
              style: textTheme?.textLarge?.copyWith(
                color: AppColors.white,
                height: 18 / 14,
              ),
            ),
          ),
        ],
      ),
    );
    final fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: Center(child: toastWithButton),
      positionedToastBuilder: (context, child, _) {
        return Positioned(
          right: 24.0,
          left: 24.0,
          bottom: 48,
          child: child,
        );
      },
    );
  }
}
