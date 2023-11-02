import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_match_meter/styles/background_style.dart';
import 'package:tennis_match_meter/styles/button_styles.dart';
import 'package:tennis_match_meter/styles/colors.dart';
import 'package:tennis_match_meter/styles/text_styles.dart';
import 'package:tennis_match_meter/styles/textfield_styles.dart';

class PageStyle {
  PageStyle({
    required this.textStyle,
    required this.buttonStyle,
    required this.textFieldStyle,
    required this.backgroundStyle,
  });

  final TextStyles textStyle;
  final CustomButtonStyle buttonStyle;
  final CustomTextFieldStyle textFieldStyle;
  final BackgroundStyle backgroundStyle;

  static PageStyle defaultStyle() {
    return PageStyle(
      textStyle: TextStyles.getDefaultTextStyle(),
      buttonStyle: CustomButtonStyle.getDefaultButtonStyle(),
      textFieldStyle: CustomTextFieldStyle.getDefaultTextfieldStyle(),
      backgroundStyle: BackgroundStyle.getDefaultStyle(),
    );
  }

  static PageStyle courtPageStyle() {
    CustomButtonStyle defaultButtonStyle =
        CustomButtonStyle.getDefaultButtonStyle();
    return PageStyle(
      textStyle: TextStyles.from(
        textStyle: TextStyle(
          color: AppColors.getColor(Place.courtPateTextColor),
        ),
        errorTextStyle: TextStyles.getDefaultTextStyle().errorTextStyle,
      ),
      buttonStyle: CustomButtonStyle.from(
        size: defaultButtonStyle.size,
        backgroundColor: defaultButtonStyle.backgroundColor,
        boxDecoration: defaultButtonStyle.boxDecoration,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.getColor(Place.buttonForegroundColor),
          fontSize: 10,
        ),
      ),
      textFieldStyle: CustomTextFieldStyle.getDefaultTextfieldStyle(),
      backgroundStyle: BackgroundStyle.from(
        backgroundColor: AppColors.getColor(Place.courtPageBackgroundColor),
      ),
    );
  }

  static PageStyle blackTextSmallTextfieldStyle() {
    CustomTextFieldStyle textFieldStyle =
        CustomTextFieldStyle.getDefaultTextfieldStyle();
    return PageStyle(
      textStyle: TextStyles.from(
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        errorTextStyle: TextStyles.getDefaultTextStyle().errorTextStyle,
      ),
      buttonStyle: CustomButtonStyle.getDefaultButtonStyle(),
      textFieldStyle: CustomTextFieldStyle.from(
        size: const Size(150, 60),
        backgroundColor: textFieldStyle.backgroundColor,
        border: textFieldStyle.border,
        textStyle: textFieldStyle.textStyle,
        padding: textFieldStyle.padding,
        focusColor: textFieldStyle.focusColor,
        boxDecoration: textFieldStyle.boxDecoration,
        focusBorder: textFieldStyle.focusBorder,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]'),
          ),
        ],
        keyboardType: TextInputType.number,
      ),
      backgroundStyle: BackgroundStyle.getDefaultStyle(),
    );
  }

  static PageStyle blackText() {
    CustomTextFieldStyle textFieldStyle =
        CustomTextFieldStyle.getDefaultTextfieldStyle();
    return PageStyle(
      textStyle: TextStyles.from(
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        errorTextStyle: TextStyles.getDefaultTextStyle().errorTextStyle,
      ),
      buttonStyle: CustomButtonStyle.getDefaultButtonStyle(),
      textFieldStyle: textFieldStyle,
      backgroundStyle: BackgroundStyle.getDefaultStyle(),
    );
  }
}
