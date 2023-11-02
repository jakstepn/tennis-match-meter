import 'package:flutter/material.dart';
import 'package:tennis_match_meter/styles/colors.dart';
import 'package:tennis_match_meter/widgets/background/default_background.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.getColor(Place.logoContainer),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 2,
                      color: AppColors.getColor(Place.containerShadowColor),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 250,
                            minHeight: 50,
                            maxWidth: double.infinity,
                            minWidth: double.infinity),
                        child: Image(
                          image: const AssetImage("images/GrayBall.png"),
                          color: AppColors.getColor(Place.logoColor),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Tennis match meter",
                          style: TextStyle(
                            color: AppColors.getColor(Place.appTitleColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
