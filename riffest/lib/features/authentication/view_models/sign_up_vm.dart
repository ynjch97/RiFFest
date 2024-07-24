import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/festival/views/festival_screen.dart';
import 'package:riffest/features/user/view_models/user_vm.dart';
import 'package:riffest/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> emailSignUp(BuildContext context) async {
    state = const AsyncValue.loading(); // 로딩 중

    final form = ref.read(signUpForm); // 회원가입 폼
    final user = ref.read(userProvider.notifier); // users(사용자) View Model

    state = await AsyncValue.guard(() async {
      // Authentication 에 계정 정보 저장
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );

      // Database 에 사용자 정보 저장
      user.createUser(userCredential, form);
    });

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(FestivalScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
