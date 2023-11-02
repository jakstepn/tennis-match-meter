import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/account/gender.dart';
import 'package:tennis_match_meter/account/levels.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/authentication/auth_gate.dart';
import 'package:tennis_match_meter/data_containers/database/friend.dart';
import 'package:tennis_match_meter/pages/authentication/register/register_cubit.dart';
import 'package:tennis_match_meter/pages/menu_page.dart';
import 'package:tennis_match_meter/pages/templates/page_template.dart';
import 'package:tennis_match_meter/styles/page_style.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_action_button.dart';
import 'package:tennis_match_meter/widgets/buttons/custom_button.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_text.dart';
import 'package:tennis_match_meter/widgets/text_widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AuthCubit(
        authService: ctx.read(),
      ),
      child: const AuthGate(
        unauthorizedPage: PageTemplate(
          child: RegisterBox(),
        ),
        authorizedPage: MenuPage(),
      ),
    );
  }
}

class RegisterBox extends StatefulWidget {
  const RegisterBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterBoxState();
}

class _RegisterBoxState extends State<RegisterBox> {
  final email = TextEditingController();
  final password = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  late Level level = Level.begginer;
  late Gender gender = Gender.other;
  late int age = 18;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            hintText: "Email",
            controller: email,
          ),
          CustomTextField(
            hintText: "Password",
            controller: password,
          ),
          CustomTextField(
            hintText: "Name",
            controller: name,
          ),
          CustomTextField(
            hintText: "Description",
            controller: description,
          ),
          Provider(
            create: (context) => PageStyle.blackTextSmallTextfieldStyle(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "Skill level: ",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<Level>(
                      value: level,
                      onChanged: (value) => setState(() {
                        level = value ?? Level.begginer;
                      }),
                      items: Level.values.map(
                        (Level level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level.toString().split('.').last),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "Gender: ",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<Gender>(
                      value: gender,
                      onChanged: (value) => setState(() {
                        gender = value ?? Gender.other;
                      }),
                      items: Gender.values.map(
                        (Gender gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender.toString().split('.').last),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "Age: ",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<int>(
                      value: age,
                      onChanged: (value) => setState(() {
                        age = value ?? 18;
                      }),
                      items: List<int>.generate(90, (index) => index + 18)
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      hintText: "Height",
                      controller: height,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomTextField(
                      hintText: "Weight",
                      controller: weight,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (state is SignedOutState && state.error != null) ...[
            Text(state.error!),
            const SizedBox(height: 16),
          ] else
            const SizedBox(height: 32),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return BlocProvider<RegisterCubit>(
                create: (context) =>
                    RegisterCubit(shoutboxDataSource: context.read()),
                child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                  return CustomActionButton(
                    text: "Confirm",
                    action: () {
                      AuthCubit auth = context.read<AuthCubit>();
                      auth.signUpWithEmail(
                        email.text,
                        password.text,
                      );
                      // Write player data into the database only if the
                      // register process has been succesful.
                      if (auth.authService.isSignedIn) {
                        context.read<RegisterCubit>().registerNewUser(
                              Friend.user(
                                  user: AppUser(
                                    name: name.text,
                                    uid: auth.authService.getUserUID(),
                                    age: age,
                                    description: description.text,
                                    gender: gender.toString().split('.').last,
                                    height: double.parse(height.text),
                                    level: level.toString().split('.').last,
                                    weight: double.parse(weight.text),
                                  ),
                                  friends: []),
                            );
                      }
                    },
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 16),
          const CustomNavigatorButton(
            text: "Back",
            navigateToName: "/",
          ),
          const SizedBox(height: 16),
        ],
      );
    });
  }
}
