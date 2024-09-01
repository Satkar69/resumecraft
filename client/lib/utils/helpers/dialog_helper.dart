import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:resumecraft/config.dart';

class DialogHelper {
  static void displayDialog(
    BuildContext context,
    String message, {
    String? routeName, // Optional route name for navigation
  }) {
    FormHelper.showSimpleAlertDialog(
      context,
      Config.appName,
      message,
      "OK",
      () {
        if (routeName != null) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, routeName);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
