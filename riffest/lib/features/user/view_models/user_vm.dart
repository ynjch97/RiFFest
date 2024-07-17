import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/user/models/user_model.dart';
import 'package:riffest/features/user/repos/user_repo.dart';

class UserViewVodel extends AsyncNotifier<UserModel> {
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UserModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    // 로그인 된 데이터가 있다면 정보 가져오기
    if (_authRepo.isLoggedIn) {
      final user = await _userRepo.getUser(_authRepo.user!.uid);
      if (user != null) {
        return UserModel.fromJson(user);
      }
    }

    return UserModel.empty();
  }

  Future<void> createUser(
      UserCredential credential, Map<dynamic, dynamic> form) async {
    // UserCredential 이 안넘어왔으면 Authentication 에서 오류 발생 -> Exception 리턴하기
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading(); // 로딩 중

    log(credential.user!.uid);
    log(credential.user!.email ?? "");
    log(credential.user!.displayName ?? "");

    final user = UserModel(
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? form["name"] ?? "-",
      email: credential.user!.email ?? "-",
      nickname: form["nickname"] ?? "-",
      bio: "",
    );

    await _userRepo.createUser(user); // 회원가입 정보 Insert
    state = AsyncValue.data(user); // state 에 user 담기
  }
}

final userProvider = AsyncNotifierProvider<UserViewVodel, UserModel>(
  () => UserViewVodel(),
);
