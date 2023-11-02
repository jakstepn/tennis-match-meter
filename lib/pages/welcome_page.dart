import 'package:flutter/material.dart';
import 'package:tennis_match_meter/pages/templates/logo_page_template.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LogoPage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CustomNavigatorButton(
            text: "Sign in",
            navigateToName: "/login",
          ),
          SizedBox(
            height: 5,
          ),
          CustomNavigatorButton(
            text: "Sign up",
            navigateToName: "/register",
          ),
          SizedBox(
            height: 5,
          ),
          CustomNavigatorButton(
            text: "Anonymous session",
            navigateToName: "/menu",
          ),
        ],
      ),
    );
  }
}
