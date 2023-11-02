import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/styles/background_style.dart';
import 'package:tennis_match_meter/styles/page_style.dart';

class DefaultBackground extends StatelessWidget {
  const DefaultBackground({Key? key, required this.child, this.style})
      : super(key: key);

  final Widget child;
  final BackgroundStyle? style;

  @override
  Widget build(BuildContext context) {
    BackgroundStyle style = this.style ??
        Provider.of<PageStyle>(context, listen: false).backgroundStyle;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: style.backgroundColor,
      child: child,
    );
  }
}
