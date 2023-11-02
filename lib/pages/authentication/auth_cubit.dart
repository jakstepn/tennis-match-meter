import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/authentication/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authService})
      : super(authService.isSignedIn
            ? const SignedInState()
            : const SignedOutState()) {
    _sub = authService.isSignedInStream.listen((isSignedIn) {
      emit(isSignedIn ? const SignedInState() : const SignedOutState());
    });
  }

  final AuthService authService;
  StreamSubscription? _sub;

  Future<void> signInWithEmail(
    String email,
    String password,
  ) async {
    emit(const SigningInState());
    await Future.delayed(const Duration(seconds: 1));

    try {
      final res = await authService.signInWithEmail(email, password);

      switch (res) {
        case SignInResult.success:
          emit(const SignedInState());
          break;
        case SignInResult.emailAlreadyInUse:
          emit(const SignedOutState(
              error: 'This email address is already in use.'));
          break;
        case SignInResult.userDisabled:
          emit(const SignedOutState(error: 'This user has been banned.'));
          break;
        case SignInResult.invalidEmail:
        case SignInResult.userNotFound:
        case SignInResult.wrongPassword:
          emit(const SignedOutState(error: 'Invalid email or password.'));
          break;
      }
    } catch (_) {
      emit(const SignedOutState(error: 'Unexpected error.'));
    }
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
  ) async {
    emit(const SigningInState());
    await Future.delayed(const Duration(seconds: 1));

    try {
      final res = await authService.signUpWithEmail(email, password);

      switch (res) {
        case true:
          emit(const SignedInState());
          break;
        case false:
          emit(const SignedOutState(error: 'Invalid email or password'));
          break;
      }
    } catch (_) {
      emit(const SignedOutState(error: 'Unexpected error.'));
    }
  }

  Future<void> signOut() async {
    await authService.signOut();

    emit(const SignedOutState());
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}

abstract class AuthState {
  const AuthState();
}

class SignedInState extends AuthState {
  const SignedInState();
}

class SigningInState extends AuthState {
  const SigningInState();
}

class SignedOutState extends AuthState {
  const SignedOutState({
    this.error,
  });

  final String? error;
}
