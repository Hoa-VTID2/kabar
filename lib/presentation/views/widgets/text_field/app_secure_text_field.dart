import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/string_extensions.dart';
import 'package:kabar/shared/utils/keyboard.dart';

class AppSecureTextField extends StatefulWidget {
  const AppSecureTextField({
    super.key,
    this.label,
    this.required = false,
    this.hint,
    this.value,
    this.error,
    this.enabled = true,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onFieldSubmitted,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.controller,
    this.disableTextColor,
    this.disableBackgroundColor,
  });

  final String? label;
  final bool required;
  final String? hint;
  final String? value;
  final String? error;
  final bool enabled;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onFieldSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Color? disableTextColor;
  final Color? disableBackgroundColor;

  @override
  State<AppSecureTextField> createState() => _AppSecureTextFieldState();
}

class _AppSecureTextFieldState extends State<AppSecureTextField> {
  late TextEditingController _controller;
  var _obscure = true;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.value ?? '');

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSecureTextField oldWidget) {
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
                style: textTheme?.textSmall?.copyWith(
                  color: AppColors.subTextColor,
                ),
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
          child: TextFormField(
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
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
              color: widget.enabled ? null : widget.disableTextColor,
            ),
            decoration: InputDecoration(
              counterText: '',
              suffixIconConstraints: BoxConstraints.tight(const Size(40, 44)),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 12, 12),
                  child: _obscure
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ),
              ),
              prefixIconConstraints: BoxConstraints.tight(const Size(40, 44)),
              prefixIcon: (widget.prefixIcon != null)
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
              fillColor: widget.enabled
                  ? AppColors.white
                  : (widget.disableBackgroundColor ?? AppColors.white),
              hintText: widget.hint,
              hintStyle: textTheme?.textSmall?.copyWith(
                color: colorSchema?.replaceTextColor,
              ),
              enabledBorder: defaultBorder,
              disabledBorder: defaultBorder,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: colorSchema?.primary ?? AppColors.primaryColor, //lor
                ),
              ),
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              error: widget.error != null ? const SizedBox() : null,
            ),
            obscuringCharacter: '*',
            obscureText: _obscure,
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
