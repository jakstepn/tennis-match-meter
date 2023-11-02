import 'package:flutter/material.dart';
import 'two_separated_rectangles.dart';

class Court extends StatelessWidget {
  const Court({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 50,
          child: PlayerFieldMain(),
        ),
        ServiceField(),
        NetLine(),
        ServiceField(
          reversed: true,
        ),
        Expanded(
          flex: 50,
          child: PlayerFieldMain(),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

class PlayerFieldMain extends StatelessWidget {
  const PlayerFieldMain({
    Key? key,
    this.fieldColor = Colors.green,
    this.separatorColor = Colors.white,
  }) : super(key: key);

  final Color fieldColor;
  final Color separatorColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 50,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: separatorColor,
                ),
              ),
              Expanded(
                flex: 100,
                child: Container(
                  color: fieldColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: separatorColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class NetLine extends StatelessWidget {
  const NetLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromARGB(255, 110, 110, 110),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceField extends StatelessWidget {
  const ServiceField({Key? key, this.reversed = false}) : super(key: key);

  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 35,
      child: TwoSeparatedRectangles(),
    );
  }
}
