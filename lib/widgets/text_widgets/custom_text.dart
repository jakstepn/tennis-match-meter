import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/styles/page_style.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, this.text = "", this.style}) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        this.style ?? Provider.of<PageStyle>(context).textStyle.textStyle;
    return RichText(
      text: TextSpan(
        style: style,
        text: text,
      ),
    );
  }
}
