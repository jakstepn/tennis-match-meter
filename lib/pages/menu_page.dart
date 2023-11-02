import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/authentication/auth_service.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      child: MenuPageBox(),
    );
  }
}

class MenuPageBox extends StatelessWidget {
  const MenuPageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        CustomActionButton(
          text: "New Game",
          action: () {
            Navigator.pushNamed(context, "/new_game");
          },
        ),
        const SizedBox(height: 10),
        CustomActionButton(
          text: "History",
          action: () {
            Navigator.pushNamed(context, "/history");
          },
        ),
        const SizedBox(height: 10),
        CustomActionButton(
          text: "Friends",
          action: () {
            Navigator.pushNamed(context, "/friends");
          },
        ),
        const SizedBox(height: 10),
        BlocProvider(
          create: (context) => AuthCubit(
            authService: context.read(),
          ),
          child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            return CustomActionButton(
              text: state is SignedInState ? "Log out" : "Back",
              action: () {
                if (state is SignedInState) {
                  context.read<AuthService>().signOut();
                } else {
                  Navigator.pushReplacementNamed(context, "/");
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
