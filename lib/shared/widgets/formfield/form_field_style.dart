import 'package:flutter/material.dart';

class FormFieldStyle {
  const FormFieldStyle({
    required this.fillColor,
    required this.borderColor,
    required this.labelStyle,
    required this.hintStyle,
    required this.inputTextStyle,
    required this.iconColor,
    required this.disabledColor,
  });
  final Color? fillColor;
  final Color borderColor;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle inputTextStyle;
  final Color? iconColor;
  final Color? disabledColor;

  /// method created to pass own styles
  /// can be extended in the future with more parameters
  FormFieldStyle copyWith({
    Color? borderColor,
    Color? labelColor,
    double? labelFontSize,
  }) {
    return FormFieldStyle(
      fillColor: fillColor,
      borderColor: borderColor ?? this.borderColor,
      labelStyle: (labelColor == null)
          ? labelStyle
          : labelStyle.copyWith(
              color: labelColor,
              fontSize: labelFontSize ?? labelStyle.fontSize,
            ),
      hintStyle: hintStyle,
      inputTextStyle: inputTextStyle,
      iconColor: iconColor,
      disabledColor: disabledColor,
    );
  }
}
