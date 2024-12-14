import 'package:flutter/material.dart';

import 'primary_button_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.style,
    required this.title,
    required this.disabled,
    this.onTap,
  });
  final PrimaryButtonStyle style;
  final String title;
  final bool disabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.0,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          backgroundColor: disabled
              ? WidgetStateProperty.all(style.backgroundColor.withOpacity(0.5))
              : WidgetStateProperty.all(style.backgroundColor),
        ),
        child: Text(
          title,
          style: style.textStyle,
        ),
      ),
    );
  }
}
