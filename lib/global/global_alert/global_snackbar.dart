import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/extra_colors.dart';

class GlobalSnackbar {
  static success({String? title, required String msg}) => Get
    ..closeAllSnackbars()
    ..snackbar(title ?? "Success", msg,
        backgroundColor: ExtraColors.SUCCESS_600,
        colorText: Colors.white,
        snackStyle: SnackStyle.GROUNDED,
        margin: EdgeInsets.zero);

  static error({String? title, required String msg}) => Get
    ..closeAllSnackbars()
    ..snackbar(title ?? "Success", msg,
        backgroundColor: ExtraColors.DANGER_500,
        colorText: Colors.white,
        snackStyle: SnackStyle.GROUNDED,
        margin: EdgeInsets.zero);
}
