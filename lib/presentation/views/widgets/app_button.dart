import 'package:flutter/material.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/views/widgets/safe_click_widget.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';

const kDefaultPaddingButton = EdgeInsets.zero;

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    this.enable = true,
    this.minWidth,
    this.height = 0,
    this.backgroundColor = Colors.transparent,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 6,
    this.titleStyle = const TextStyle(color: AppColors.white),
    required this.onPressed,
    this.borderColor,
    this.padding = kDefaultPaddingButton,
    this.isIconButton = false,
    this.borderWidth,
    this.contentAlignment,
  });

  factory AppButton.primary({
    bool enable,
    required String title,
    TextStyle? titleStyle,
    required VoidCallback onPressed,
    MainAxisAlignment contextAlignment,
    Color? backgroundColor,
    double borderRadius,
    Widget? icon,
    EdgeInsets? iconPadding,
    double height,
    double? minWidth,
  }) = _AppButtonPrimary;

  factory AppButton.outline({
    required String title,
    required VoidCallback onPressed,
    double height,
    double minWidth,
    double borderRadius,
    Color backgroundColor,
    Color borderColor,
    double borderWidth,
  }) = _AppButtonOutline;

  const factory AppButton.icon({
    bool enable,
    required Widget child,
    required VoidCallback onPressed,
  }) = _AppButtonIcon;

  final Widget child;
  final TextStyle? titleStyle;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool enable;
  final double? minWidth;
  final double height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsets padding;
  final bool isIconButton;
  final MainAxisAlignment? contentAlignment;

  @override
  Widget build(BuildContext context) {
    final border = borderColor != null && enable
        ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
        : BorderSide.none;
    if (isIconButton) {
      return InkResponse(
        radius: 24,
        onTap: enable ? onPressed : null,
        child: child,
      );
    } else {
      return Material(
        color: enable
            ? backgroundColor
            : backgroundColor.withAlpha((0.5 * 255).round()),
        textStyle: titleStyle ?? const TextStyle(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: border,
        ),
        child: SafeClickWidget(
          onPressed: enable ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            constraints:
                BoxConstraints(minWidth: minWidth ?? 0, minHeight: height),
            padding: padding,
            child: Row(
              mainAxisAlignment: contentAlignment ?? MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) prefixIcon!,
                Flexible(child: child),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _AppButtonPrimary extends AppButton {
  _AppButtonPrimary({
    required String title,
    TextStyle? titleStyle,
    required super.onPressed,
    super.borderRadius = 12,
    Color? backgroundColor,
    MainAxisAlignment contextAlignment = MainAxisAlignment.center,
    super.enable,
    Widget? icon,
    EdgeInsets? iconPadding,
    super.height = 48,
    super.minWidth,
  }) : super(
          child: _AppButtonPrimaryChild(
            title: title,
            icon: icon,
            iconPadding: iconPadding,
            titleStyle: titleStyle,
          ),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          contentAlignment: contextAlignment,
        );
}

class _AppButtonPrimaryChild extends StatelessWidget {
  const _AppButtonPrimaryChild({
    required this.title,
    this.icon,
    this.iconPadding,
    this.titleStyle,
  });

  final String title;
  final TextStyle? titleStyle;
  final Widget? icon;
  final EdgeInsets? iconPadding;

  @override
  Widget build(BuildContext context) {
    final themOwn = context.themeOwn();
    final textStyle = titleStyle ??
          themOwn.textTheme?.linkMedium?.copyWith(color: AppColors.white);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
                padding: iconPadding ?? const EdgeInsets.only(right: 8),
                child: icon),
          Flexible(
            child: Text(
              title,
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppButtonIcon extends AppButton {
  const _AppButtonIcon({
    required super.child,
    required super.onPressed,
    super.enable,
  }) : super(
          backgroundColor: Colors.transparent,
          height: 0,
          isIconButton: true,
        );
}

class _AppButtonOutline extends AppButton {
  _AppButtonOutline({
    required String title,
    required super.onPressed,
    super.height,
    super.minWidth,
    super.borderRadius,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
  }) : super(
          child: _AppButtonOutlineChild(title: title),
        );
}

class _AppButtonOutlineChild extends StatelessWidget {
  const _AppButtonOutlineChild({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final themOwn = context.themeOwn();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: themOwn.textTheme?.linkMedium?.copyWith(
          color: themOwn.colorSchema?.primary,
        ),
      ),
    );
  }
}
