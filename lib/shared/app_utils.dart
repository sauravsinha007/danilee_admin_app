import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/text_styles.dart';

class AppUtils {
  const AppUtils();

  static Future<void> showCustomDialog({
    required BuildContext context,
    required Text title,
    required Text? subtitle,
    required List<Widget> actions,
  }) async {
    // ignore: inference_failure_on_function_invocation
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        surfaceTintColor: AppUIColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        title: title,
        content: subtitle,
        actions: actions,
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowAlignment: OverflowBarAlignment.center,
      ),
    );
  }

  static void showCustomToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.body,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegEx.hasMatch(value);
  }
}
