import 'package:flutter/material.dart';
import 'package:tennis_match_meter/styles/colors.dart';

class CustomButtonStyle {
  CustomButtonStyle();
  CustomButtonStyle.from({
    required this.size,
    required this.backgroundColor,
    required this.boxDecoration,
    required this.textStyle,
  });
  late String navigateToName;
  late Color backgroundColor;
  late Size size;
  late TextStyle? textStyle;
  late Decoration? boxDecoration;

  static CustomButtonStyle getDefaultButtonStyle() {
    return CustomButtonStyle.from(
      size: const Size(250, 40),
      backgroundColor: AppColors.getColor(Place.buttonBackgroundColor),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.getColor(Place.buttonBackgroundColor),
      ),
      textStyle: TextStyle(
        color: AppColors.getColor(Place.buttonForegroundColor),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}
