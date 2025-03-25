import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/widgets/safe_click_widget.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';

Future<void> showAlertPopup(
  BuildContext context,
  Widget image,
  String message, {
  String? buttonLabel,
  void Function(BuildContext context)? onClickButton,
}) {
  final textTheme = context.themeOwn().textTheme;
  final colorSchema = context.themeOwn().colorSchema;

  return showGeneralDialog(
    context: context,
    barrierColor: AppColors.black.withAlpha((0.8 * 255).round()),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (ctx, __, ___) {
      return PopScope(
        canPop: false,
        child: Center(
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(horizontal: 48),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(24),
                  image,
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      message,
                      style:
                          textTheme?.linkMedium?.copyWith(height: 20 / 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    height: 44,
                    child: SafeClickWidget(
                      onPressed: () {
                        if (onClickButton != null) {
                          onClickButton.call(ctx);
                        } else {
                          Navigator.pop(ctx);
                        }
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            buttonLabel ?? LocaleKeys.popup_close.tr(),
                            style: textTheme?.linkMedium?.copyWith(
                              height: 24 / 16,
                              color: colorSchema?.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

const dialogColorScheme = ColorScheme.light(
  primary: AppColors.primaryColor,
  onSurface: AppColors.subTextColor,
  surfaceTint: AppColors.white,
);
