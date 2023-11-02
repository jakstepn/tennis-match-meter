import 'package:flutter/material.dart';

class SlideAnimation extends StatelessWidget {
  const SlideAnimation({
    Key? key,
    required this.transitionAnimation,
    required this.beginOffset,
    required this.endOffset,
    required this.child,
    required this.interval,
  }) : super(key: key);
  final Interval interval;
  final Offset beginOffset, endOffset;
  final Animation<double> transitionAnimation;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: transitionAnimation,
      builder: (context, childAnimated) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: endOffset,
          ).animate(
            CurvedAnimation(
              parent: transitionAnimation,
              curve: interval,
            ),
          ),
          child: childAnimated,
        );
      },
      child: child,
    );
  }
}

class SlideInFromTheRight extends StatelessWidget {
  const SlideInFromTheRight({
    Key? key,
    required this.transitionAnimation,
    required this.child,
  }) : super(key: key);
  final Animation<double> transitionAnimation;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      transitionAnimation: transitionAnimation,
      beginOffset: const Offset(2, 0),
      endOffset: const Offset(0, 0),
      child: child,
      interval: const Interval(0, 1, curve: Curves.decelerate),
    );
  }
}

class SlideOutFromTheTop extends StatelessWidget {
  const SlideOutFromTheTop({
    Key? key,
    required this.transitionAnimation,
    required this.child,
  }) : super(key: key);
  final Animation<double> transitionAnimation;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      beginOffset: const Offset(0, 0),
      endOffset: const Offset(0, -1),
      child: child,
      interval: const Interval(0.5, 0.9, curve: Curves.easeIn),
      transitionAnimation: transitionAnimation,
    );
  }
}
