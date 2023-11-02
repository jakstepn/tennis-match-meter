import 'package:flutter/material.dart';
import 'package:tennis_match_meter/styles/colors.dart';

class TextStyles {
  TextStyles();
  TextStyles.from({
    required this.textStyle,
    required this.errorTextStyle,
  });
  late TextStyle textStyle;
  late TextStyle errorTextStyle;

  static TextStyles getDefaultTextStyle() {
    return TextStyles.from(
      errorTextStyle: TextStyle(
        color: AppColors.getColor(Place.errorTextColor),
        fontWeight: FontWeight.bold,
      ),
      textStyle: TextStyle(
        color: AppColors.getColor(Place.textColor),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}
