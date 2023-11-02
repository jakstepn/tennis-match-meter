import 'package:flutter/material.dart';

class LoadAnimation extends StatelessWidget {
  const LoadAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BallAnimation(
      width: MediaQuery.of(context).size.width,
      height: 200,
    );
  }
}

class _BallAnimation extends StatefulWidget {
  const _BallAnimation({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  _BallAnimationState createState() => _BallAnimationState();
}

class _BallAnimationState extends State<_BallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> movexin1;
  late Animation<double> movexout1;
  late Animation<double> moveyin1;
  late Animation<double> moveyout1;
  late Animation<double> movexin2;
  late Animation<double> movexout2;
  late Animation<double> moveyin2;
  late Animation<double> moveyout2;

  late double curX = widget.width, curY = widget.height;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    moveyin1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25, curve: Curves.easeInQuad)));

    movexin1 = Tween<double>(begin: 0, end: 0.25).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.linear),
      ),
    );

    movexout1 = Tween<double>(begin: 0.25, end: 0.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.5, curve: Curves.linear),
      ),
    );

    moveyout1 = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.5, curve: Curves.decelerate)));

    // Second half (of the ball movement) of an animation

    moveyin2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeInQuad)));

    movexin2 = Tween<double>(begin: 0.5, end: 0.75).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.75, curve: Curves.linear),
      ),
    );

    movexout2 = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.linear),
      ),
    );

    moveyout2 = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.decelerate)));
    controller.addListener(() {
      setState(() {
        if (controller.value >= 0 && controller.value < 0.25) {
          curX = widget.width * movexin1.value;
          curY = widget.height * moveyin1.value;
        } else if (controller.value >= 0.25 && controller.value <= 0.5) {
          curX = widget.width * movexout1.value;
          curY = widget.height * moveyout1.value;
        } else if (controller.value >= 0.5 && controller.value < 0.75) {
          curX = widget.width * movexin2.value;
          curY = widget.height * moveyin2.value;
        } else if (controller.value >= 0.75 && controller.value <= 1.0) {
          curX = widget.width * movexout2.value;
          curY = widget.height * moveyout2.value;
        }
      });
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(curX, curY),
            child: const Ball(
              radius: 10.0,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({
    Key? key,
    required this.radius,
    this.color = Colors.red,
  }) : super(key: key);

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
