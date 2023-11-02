import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/styles/textfield_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.hintText = 'Lorem Ipsum',
    this.controller,
    this.style,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final CustomTextFieldStyle? style;

  @override
  State<StatefulWidget> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  late String text = widget.hintText;

  @override
  Widget build(BuildContext context) {
    CustomTextFieldStyle style = widget.style ??
        Provider.of<PageStyle>(context, listen: false).textFieldStyle;
    return SizedBox(
      height: style.size.height,
      width: style.size.width,
      child: Padding(
        padding: style.padding,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: style.backgroundColor,
            focusColor: style.focusColor,
            focusedBorder: style.focusBorder,
            labelText: text,
            labelStyle: style.textStyle,
            border: style.border,
            enabledBorder: style.border,
            disabledBorder: style.border,
          ),
          inputFormatters: style.inputFormatters,
          controller: widget.controller,
          keyboardType: style.keyboardType,
        ),
      ),
    );
  }
}
