import 'package:danilee/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/styles.dart';
import 'form_field_style.dart';

class AppFormField extends StatefulWidget {
  const AppFormField({
    super.key,
    this.keyName,
    this.labelText,
    required this.textEditingController,
    required this.hintText,
    this.isPasswordField = false,
    this.formFieldStyle,
    this.isEnabled = true,
    this.onTap,
    required this.onChanged,
    required this.validate,
    this.validateMode = AutovalidateMode.disabled,
    this.keyboardType = TextInputType.text,
    this.autofillHints = const <String>[],
    this.focusNode,
    this.inputFormatters,
    this.textInputAction,
    this.maxLines = 1,
    this.onSubmitted,
  });

  final Key? keyName;
  final String? labelText;
  final String hintText;
  final bool isPasswordField;
  final FormFieldStyle? formFieldStyle;
  final bool isEnabled;
  final TextEditingController textEditingController;
  final void Function()? onTap;
  final ValueChanged<String> onChanged;
  final String? Function(String?) validate;
  final AutovalidateMode validateMode;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final int maxLines;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppFormField> createState() => _TxbFormFieldState();
}

class _TxbFormFieldState extends State<AppFormField> {
  // used to toggle password icon and obscure text(hide/show password)
  // set true as initial value
  bool passwordToggle = false;

  FormFieldStyle get formFieldStyle =>
      widget.formFieldStyle ?? Styles.formFieldStyle(context);

  InputBorder get inputBorder => OutlineInputBorder(
        borderSide: BorderSide(color: formFieldStyle.borderColor),
      );

  TextStyle get textStyle => (widget.isEnabled)
      ? formFieldStyle.inputTextStyle
      : formFieldStyle.inputTextStyle
          .copyWith(color: formFieldStyle.hintStyle.color);

  TextStyle get hintStyle => (widget.isEnabled)
      ? formFieldStyle.hintStyle
      : formFieldStyle.hintStyle.copyWith(color: formFieldStyle.disabledColor);

  Widget? get suffixIcon => (widget.isPasswordField)
      ? GestureDetector(
          onTap: () {
            setState(() {
              passwordToggle = !passwordToggle;
            });
          },
          child: Icon(
            passwordToggle ? Icons.visibility_off : Icons.visibility,
            size: 25.0,
            color: (widget.isEnabled)
                ? formFieldStyle.iconColor
                : formFieldStyle.disabledColor,
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.labelText ?? '',
                style: formFieldStyle.labelStyle,
              ),
            )
          else
            const SizedBox.shrink(),
          TextFormField(
            key: widget.keyName,
            autocorrect: false,
            autofillHints: widget.autofillHints,
            autovalidateMode: widget.validateMode,
            controller: widget.textEditingController,
            maxLines: widget.maxLines,
            focusNode: widget.focusNode,
            cursorColor: AppUIColors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: formFieldStyle.fillColor,
              hintText: widget.hintText,
              hintStyle: hintStyle,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 12.0,
              ),
              suffixIcon: suffixIcon,
              disabledBorder: inputBorder.copyWith(
                borderSide: inputBorder.borderSide.copyWith(
                  color: formFieldStyle.disabledColor,
                ),
              ),
              errorBorder: inputBorder,
              focusedErrorBorder: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
            ),
            enabled: widget.isEnabled,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPasswordField &&
                !passwordToggle &&
                widget.maxLines <= 1,
            onTap: widget.onTap,
            onFieldSubmitted: (String str) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted?.call(str);
              }
            },
            onChanged: (String str) {
              widget.onChanged(str);
            },
            style: textStyle,
            validator: (String? value) {
              return widget.validate(value);
            },
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
          ),
        ],
      ),
    );
  }
}
