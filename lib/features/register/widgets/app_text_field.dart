import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// 64px translucent input. The [label] floats above the text once the
/// field has content; [onToggleObscure] adds the eye toggle on the right.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.label,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.obscureText = false,
    this.onToggleObscure,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? label;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final bool autofocus;

  static const height = 64.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.controlSecondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, _) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null && value.text.isNotEmpty)
                    Text(label!, style: _labelStyle),
                  _input(),
                ],
              ),
            ),
          ),
          if (onToggleObscure != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onToggleObscure,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 22,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static final _labelStyle = AppTextStyles.caption.copyWith(
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  static const _selectionTheme = TextSelectionThemeData(
    cursorColor: AppColors.textPrimary,
    selectionColor: Color(0x3DFFFFFF),
    selectionHandleColor: AppColors.textPrimary,
  );

  Widget _input() {
    return TextSelectionTheme(
      data: _selectionTheme,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        autofillHints: autofillHints,
        obscureText: obscureText,
        obscuringCharacter: '•',
        autocorrect: false,
        enableSuggestions: !obscureText,
        style: obscureText
            ? AppTextStyles.body.copyWith(letterSpacing: 4)
            : AppTextStyles.body,
        cursorColor: AppColors.textPrimary,
        cursorWidth: 1,
        cursorHeight: 20,
        decoration: const InputDecoration.collapsed(hintText: null),
      ),
    );
  }
}
