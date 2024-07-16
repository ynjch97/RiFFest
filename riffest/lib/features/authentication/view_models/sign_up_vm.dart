import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/authentication/views/login_screen.dart';
import 'package:riffest/features/authentication/views/sign_up_screen.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> emailSignUp(BuildContext context) async {
    state = const AsyncValue.loading(); // 로딩 중
    final form = ref.read(signUpForm); // 회원가입 폼

    state = await AsyncValue.guard(() async {
      await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
    });

    if (state.hasError) {
      context.goNamed(SignUpScreen.routeName);
    } else {
      context.goNamed(LoginScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
