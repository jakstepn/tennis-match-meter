import 'package:flutter/material.dart';
import 'two_separated_rec_dimensions.dart';

class SeparatedRectanglesData {
  const SeparatedRectanglesData({
    this.dimenstions = const SeparatedRectanglesDimensinos(),
    this.borderColor = Colors.white,
    this.firstRectangleColor = Colors.green,
    this.secondRectangleColor = Colors.green,
    this.separatorColor = Colors.white,
    this.reversed = false,
  });

  final SeparatedRectanglesDimensinos dimenstions;

  final bool reversed;

  final Color borderColor;
  final Color firstRectangleColor;
  final Color secondRectangleColor;
  final Color separatorColor;
}
