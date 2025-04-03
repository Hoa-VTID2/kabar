import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/string_extensions.dart';
import 'package:kabar/shared/utils/keyboard.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      this.label,
      this.required = false,
      this.hint,
      this.value,
      this.error,
      this.enabled = true,
      this.suffixIcon,
      this.prefixIcon,
      this.textInputAction = TextInputAction.done,
      this.focusNode,
      this.onFieldSubmitted,
      this.onTap,
      this.keyboardType,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.inputFormatters,
      this.onChanged,
      this.controller,
      this.disableTextColor,
      this.disableBackgroundColor,
      this.readOnly = false,
      this.isLoading = false,
      this.textDirection,
      this.validator});

  final String? label;
  final bool required;
  final String? hint;
  final String? value;
  final String? error;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onFieldSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Color? disableTextColor;
  final Color? disableBackgroundColor;
  final bool readOnly;
  final bool isLoading;
  final TextDirection? textDirection;
  final FormFieldValidator<String>? validator;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.value ?? '');

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    if (_controller.text != widget.value) {
      _controller.text = widget.value ?? '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.styleOwn();
    final colorSchema = context.colorOwn();
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.subTextColor, // Border color
      ),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.errorColor, // Border color
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RichText(
              text: TextSpan(
                text: widget.label,
                style: context
                    .themeOwn()
                    .textTheme
                    ?.textSmall
                    ?.copyWith(color: AppColors.subTextColor),
                children: [
                  if (widget.required)
                    TextSpan(
                      text: '*',
                      style: textTheme?.textSmall?.copyWith(
                        color: AppColors.errorColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              TextFormField(
                readOnly: widget.readOnly,
                onChanged: widget.onChanged,
                inputFormatters: widget.inputFormatters,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                maxLines: widget.maxLines ?? 1,
                keyboardType: widget.keyboardType,
                textDirection: widget.textDirection,
                onTap: widget.onTap,
                onTapOutside: (event) {
                  hideKeyboard();
                },
                onFieldSubmitted: (value) {
                  widget.onFieldSubmitted?.call();
                },
                focusNode: widget.focusNode,
                textInputAction: widget.textInputAction,
                controller: _controller,
                enabled: widget.enabled,
                style: textTheme?.textSmall?.copyWith(
                  height: 20 / 15,
                  color: widget.enabled ? null : widget.disableTextColor,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  suffixIconConstraints:
                      BoxConstraints.tight(const Size(48, 48)),
                  suffixIcon: (widget.suffixIcon == null &&
                          (_controller.text != '' && widget.error != null))
                      ? InkWell(
                          onTap: () {
                            _controller.text = '';
                          },
                          child: Center(
                            child: Assets.icons.esc.svg(
                                height: 13,
                                width: 13,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.errorColor, BlendMode.srcIn)),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(17.5),
                          child: widget.suffixIcon,
                        ),
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(40, 44)),
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                          child: widget.prefixIcon,
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: (widget.enabled && widget.error == null)
                      ? AppColors.white
                      : AppColors.errorColorLight,
                  hintText: widget.hint,
                  hintStyle: textTheme?.textSmall?.copyWith(
                    color: colorSchema?.replaceTextColor,
                  ),
                  enabledBorder: defaultBorder,
                  disabledBorder: defaultBorder,
                  focusedBorder: widget.readOnly
                      ? defaultBorder
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: colorSchema?.primary ??
                                AppColors.primaryColor, //lor
                          ),
                        ),
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  error: widget.error != null ? const SizedBox() : null,
                ),
                validator: widget.validator ??
                    (value) {
                      if (widget.required && (value == null || value.isEmpty)) {
                        return 'Invalid ${widget.label}';
                      }
                      return null;
                    },
              ),
              if (widget.isLoading) const CircularProgressIndicator()
            ],
          ),
        ),
        if (widget.error.isNotEmpty())
          Row(
            spacing: 4,
            children: [
              SvgPicture.asset(Assets.icons.warning.path),
              Text(
                widget.error!,
                style: textTheme?.textSmall?.copyWith(
                  color: AppColors.errorColor,
                ),
              ),
            ],
          )
      ],
    );
  }
}
