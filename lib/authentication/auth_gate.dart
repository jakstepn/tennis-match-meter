import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({
    Key? key,
    required this.authorizedPage,
    required this.unauthorizedPage,
  }) : super(key: key);

  final Widget authorizedPage;
  final Widget unauthorizedPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state is SignedInState ? authorizedPage : unauthorizedPage;
      },
    );
  }
}
