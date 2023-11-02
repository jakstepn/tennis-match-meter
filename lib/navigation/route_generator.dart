import 'package:flutter/material.dart';
import 'package:tennis_match_meter/navigation/route_builder.dart';
import 'package:tennis_match_meter/pages/authentication/login/login_page.dart';
import 'package:tennis_match_meter/pages/authentication/register/register_page.dart';
import 'package:tennis_match_meter/pages/database/friends/friends_page.dart';
import 'package:tennis_match_meter/pages/game/game_init/choose_mode_page.dart';
import 'package:tennis_match_meter/pages/game/court/court_page.dart';
import 'package:tennis_match_meter/pages/menu_page.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/pages/database/game_history/history_page.dart';
import 'package:tennis_match_meter/pages/welcome_page.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CustomPageRoute(
          child: const WelcomePage(),
        );
      case '/menu':
        return CustomPageRoute(
          child: const MenuPage(),
        );
      case '/new_game':
        return CustomPageRoute(
          child: const ChooseModePage(),
        );
      case '/court':
        return CustomPageRoute(
          child: const CourtPage(),
        );
      case '/history':
        return CustomPageRoute(
          child: const HistoryPage(),
        );
      case '/friends':
        return CustomPageRoute(
          child: const FriendsPage(),
        );
      case '/login':
        return CustomPageRoute(
          child: const LoginPage(),
        );
      case '/register':
        return CustomPageRoute(
          child: const RegisterPage(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      child: Center(
        child: CustomText(
          text: "Error!",
        ),
      ),
    );
  }
}
