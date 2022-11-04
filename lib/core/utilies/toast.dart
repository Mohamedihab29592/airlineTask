import 'package:air_line_task/core/utilies/values_manger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 8,
      backgroundColor: chooseToastColor(state),
      textColor: AppColors.white,
      fontSize: AppSize.s15);
}

enum ToastStates { success, error, }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = AppColors.blue;
      break;
    case ToastStates.error:
      color = AppColors.red;
      break;
  }
  return color;
}
