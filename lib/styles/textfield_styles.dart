import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_match_meter/styles/colors.dart';

class CustomTextFieldStyle {
  CustomTextFieldStyle();
  CustomTextFieldStyle.from({
    required this.size,
    required this.backgroundColor,
    required this.border,
    required this.textStyle,
    required this.padding,
    required this.focusColor,
    required this.boxDecoration,
    required this.focusBorder,
    this.inputFormatters,
    this.keyboardType,
  });
  late String navigateToName;
  late Color backgroundColor;
  late Color focusColor;
  late Color foregroundColor;
  late Size size;
  late TextStyle? textStyle;
  late InputBorder? border;
  late InputBorder? focusBorder;
  late EdgeInsetsGeometry padding;
  late BoxDecoration boxDecoration;
  late List<TextInputFormatter>? inputFormatters;
  late TextInputType? keyboardType;

  static CustomTextFieldStyle getDefaultTextfieldStyle() {
    return CustomTextFieldStyle.from(
      size: const Size(double.infinity, 80),
      backgroundColor: AppColors.getColor(Place.textfieldBackgroundColor),
      focusColor: AppColors.getColor(Place.textfieldFocusColor),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.getColor(Place.textfieldBorderColor),
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      focusBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.getColor(Place.textfieldFocusBorderColor),
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      textStyle: TextStyle(
        color: AppColors.getColor(Place.textfieldForegroundColor),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.fromBorderSide(
          BorderSide(
            width: 5,
            color: AppColors.getColor(Place.textfieldBorderColor),
          ),
        ),
      ),
    );
  }
}
