import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InputDecorations {
  static InputDecoration inputDecoration(
      { String hintText,
       String labelText,
       Icon icon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: icon);
  }
}
