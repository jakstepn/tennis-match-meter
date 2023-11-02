import 'package:flutter/material.dart';
import 'package:tennis_match_meter/styles/colors.dart';

class BackgroundStyle {
  BackgroundStyle();
  BackgroundStyle.from({
    required this.backgroundColor,
  });
  late Color backgroundColor;

  static BackgroundStyle getDefaultStyle() {
    return BackgroundStyle.from(
      backgroundColor: AppColors.getColor(Place.defaultBackgroundColor),
    );
  }
}
