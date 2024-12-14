import 'package:flutter/material.dart';

import '../shared/widgets/buttons/primary_button_style.dart';
import '../shared/widgets/formfield/form_field_style.dart';
import 'app_colors.dart';
import 'text_styles.dart';

abstract class Styles {
  static TextStyle appBarTitleStyle(BuildContext context) {
    return AppTextStyles.heading2.bold.textColor(AppUIColors.white);
  }

  static PrimaryButtonStyle primaryButtonStyle(
    BuildContext context, {
    bool disabled = false,
  }) {
    final TextStyle textStyle = AppTextStyles.heading3.bold.copyWith(
      color: AppUIColors.white,
    );

    final Color backgroundColor =
        disabled ? AppUIColors.green.withOpacity(0.6) : AppUIColors.green;

    return PrimaryButtonStyle(
      backgroundColor: backgroundColor,
      textStyle: textStyle,
    );
  }

  static FormFieldStyle formFieldStyle(BuildContext context) {
    return FormFieldStyle(
      fillColor: AppUIColors.white,
      borderColor: AppUIColors.black,
      labelStyle: AppTextStyles.heading3.bold.textColor(AppUIColors.black),
      hintStyle: AppTextStyles.heading3.regular
          .textColor(AppUIColors.black.withOpacity(0.5)),
      inputTextStyle:
          AppTextStyles.heading3.regular.textColor(AppUIColors.black),
      iconColor: AppUIColors.white,
      disabledColor: AppUIColors.white,
    );
  }
}
