import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/styles/button_styles.dart';
import 'package:tennis_match_meter/styles/page_style.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    Key? key,
    this.text = 'Lorem Ipsum',
    required this.action,
    this.style,
  }) : super(key: key);
  final CustomButtonStyle? style;
  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    CustomButtonStyle style = this.style ??
        Provider.of<PageStyle>(context, listen: false).buttonStyle;
    return SizedBox(
      height: style.size.height,
      width: style.size.width,
      child: Container(
        decoration: style.boxDecoration,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                alignment: Alignment.center,
                primary: Colors.white,
              ),
              onPressed: action,
              child: RichText(
                  text: TextSpan(
                text: text,
                style: style.textStyle,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
