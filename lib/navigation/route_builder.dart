import 'package:flutter/material.dart';
import 'package:tennis_match_meter/animations/page_transition.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideInFromTheRight(
      transitionAnimation: animation,
      child: SlideOutFromTheTop(
        transitionAnimation: secondaryAnimation,
        child: child,
      ),
    );
  }
}
