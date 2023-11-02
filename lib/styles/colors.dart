import 'package:flutter/material.dart';

enum Place {
  defaultBackgroundColor,
  buttonBackgroundColor,
  buttonForegroundColor,
  textfieldHintForegroundColor,
  textfieldForegroundColor,
  textfieldBackgroundColor,
  textfieldFocusColor,
  textfieldBorderColor,
  textfieldFocusBorderColor,
  logoColor,
  appTitleColor,
  logoContainer,
  containerShadowColor,
  textColor,
  errorTextColor,
  courtPageBackgroundColor,
  courtPateTextColor,
  selectedTileColor,
  unselectedTileColor,
}

class AppColors {
  static Color getColor(Place place) {
    switch (place) {
      case Place.defaultBackgroundColor:
        return const Color.fromARGB(255, 250, 250, 250);
      case Place.buttonBackgroundColor:
        return const Color.fromARGB(255, 50, 120, 255);
      case Place.buttonForegroundColor:
        return const Color.fromARGB(255, 255, 255, 255);
      case Place.textfieldBackgroundColor:
        return const Color.fromARGB(255, 230, 230, 230);
      case Place.textfieldForegroundColor:
        return const Color.fromARGB(255, 160, 160, 160);
      case Place.textfieldHintForegroundColor:
        return const Color.fromARGB(255, 240, 240, 240);
      case Place.textfieldFocusColor:
        return const Color.fromARGB(255, 100, 100, 100);
      case Place.textfieldBorderColor:
        return const Color.fromARGB(255, 180, 180, 180);
      case Place.textfieldFocusBorderColor:
        return const Color.fromARGB(255, 210, 210, 210);
      case Place.logoColor:
        return const Color.fromARGB(255, 195, 240, 70);
      case Place.appTitleColor:
        return const Color.fromARGB(255, 255, 255, 255);
      case Place.logoContainer:
        return const Color.fromARGB(255, 120, 165, 255);
      case Place.containerShadowColor:
        return const Color.fromARGB(255, 180, 180, 180);
      case Place.errorTextColor:
        return const Color.fromARGB(255, 255, 100, 100);
      case Place.textColor:
        return const Color.fromARGB(255, 255, 255, 255);
      case Place.courtPageBackgroundColor:
        return const Color.fromARGB(255, 60, 60, 60);
      case Place.courtPateTextColor:
        return const Color.fromARGB(240, 240, 240, 240);
      case Place.selectedTileColor:
        return const Color.fromARGB(220, 50, 240, 50);
      case Place.unselectedTileColor:
        return const Color.fromARGB(250, 180, 180, 180);
      default:
        return Colors.black;
    }
  }
}
