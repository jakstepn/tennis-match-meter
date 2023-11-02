import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/authentication/auth_gate.dart';
import 'package:tennis_match_meter/pages/menu_page.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_button.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AuthCubit(
        authService: ctx.read(),
      ),
      child: const AuthGate(
        authorizedPage: MenuPage(),
        unauthorizedPage: PageTemplate(
          child: LoginBox(),
        ),
      ),
    );
  }
}

class LoginBox extends StatefulWidget {
  const LoginBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final PageStyle style = Provider.of<PageStyle>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hintText: "Email",
              controller: email,
            ),
            CustomTextField(
              hintText: "Password",
              controller: password,
            ),
            const SizedBox(height: 16),
            if (state is SignedOutState && state.error != null) ...[
              Text(
                state.error!,
                style: style.textStyle.errorTextStyle,
              ),
              const SizedBox(height: 16),
            ] else
              const SizedBox(height: 32),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return CustomActionButton(
                  text: "Log in",
                  action: state is SignedOutState
                      ? () => context
                          .read<AuthCubit>()
                          .signInWithEmail(email.text, password.text)
                      : () {},
                );
              },
            ),
            const SizedBox(height: 10),
            const CustomNavigatorButton(
              text: "Back",
              navigateToName: "/",
            ),
          ],
        );
      },
    );
  }
}
