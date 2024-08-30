import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/user/models/user_model.dart';
import 'package:riffest/features/user/repos/user_repo.dart';
import 'package:riffest/features/user/view_models/user_vm.dart';
import 'package:riffest/utils.dart';

class BookmarkViewVodel extends AsyncNotifier<void> {
  late final UserRepository _userRepo;

  @override
  FutureOr<void> build() async {
    _userRepo = ref.read(userRepo);
  }

  // 1. 북마크 추가
  Future<void> addBookmarks(BuildContext context, String festKey) async {
    UserModel? user = ref.read(userProvider).value;

    if (user != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        if (!user.bookmarks.contains(festKey)) user.bookmarks.add(festKey);
        await _userRepo.createUser(user); // 회원가입 정보 Insert
      });
    }

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    }
  }

  // 2. 북마크 제거
  Future<void> removeBookmarks(BuildContext context, String festKey) async {
    UserModel? user = ref.read(userProvider).value;

    if (user != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        if (user.bookmarks.contains(festKey)) user.bookmarks.remove(festKey);
        await _userRepo.createUser(user); // 회원가입 정보 Insert
      });
    }

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    }
  }
}

final bookmarkProvider = AsyncNotifierProvider<BookmarkViewVodel, void>(
  () => BookmarkViewVodel(),
);
