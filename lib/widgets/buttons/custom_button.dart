import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/styles/button_styles.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';

class CustomNavigatorButton extends StatelessWidget {
  const CustomNavigatorButton({
    Key? key,
    this.text = 'Lorem Ipsum',
    this.navigateToName = "/",
    this.style,
  }) : super(key: key);
  final String text;
  final String navigateToName;
  final CustomButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    CustomButtonStyle style = this.style ??
        Provider.of<PageStyle>(context, listen: false).buttonStyle;
    return CustomActionButton(
        style: style,
        text: text,
        action: () {
          Navigator.of(context).pushReplacementNamed(navigateToName);
        });
  }
}
