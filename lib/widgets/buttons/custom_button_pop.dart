import 'package:flutter/material.dart';

class CustomPopButton extends StatelessWidget {
  const CustomPopButton({
    Key? key,
    this.text = 'Lorem Ipsum',
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                  ],
                )),
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  alignment: Alignment.center,
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
