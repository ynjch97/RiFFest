import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/repos/festival_repo.dart';
import 'package:riffest/features/festival/views/time_table_screen.dart';
import 'package:riffest/features/user/models/user_model.dart';
import 'package:riffest/features/user/repos/user_repo.dart';
import 'package:uuid/uuid.dart';

// 1) 페스티벌 FestivalViewModel
class FestivalViewModel extends AsyncNotifier<FestivalModel> {
  late FestivalModel _festival;
  late final FestivalRepository _festRepo;

  @override
  FutureOr<FestivalModel> build() async {
    _festRepo = ref.read(festivalRepo);

    _festival = FestivalModel.empty();
    return _festival;
  }

  // 페스티벌 + 타임테이블 조회
  Future<void> getFestivalTimeTables(String festKey) async {
    state = const AsyncValue.loading();

    // 페스티벌 조회
    if (festKey.isNotEmpty) {
      final result = await _festRepo.getFestival(festKey);
      if (result != null) {
        // 타임테이블 조회
        result["timeTableList"] =
            await _festRepo.getTimeTableList(result["key"]);
        _festival = FestivalModel.fromJson(result);
      }
    } else {
      _festival = FestivalModel.empty();
    }

    // for (TimeTableModel item in _festival.timeTables[0]) {
    //   print("결과 :::: ${item.artist}");
    // }

    state = AsyncValue.data(_festival);
  }

  // 페스티벌 저장
  Future<void> insertFestival(
      BuildContext context, Map<dynamic, dynamic> form, File? file) async {
    state = const AsyncValue.loading();

    final key = const Uuid().v4();
    final festival = FestivalModel(
      key: key,
      name: form["name"],
      startDate: form["startDate"],
      endDate: form["endDate"],
      openTime: form["openTime"],
      location: form["location"],
      mainColor: form["mainColor"],
      subColor: form["subColor"],
      stages: form["stages"].toString().split(","),
      filter: form["filter"].toString().split(","),
      timeTables: [],
      timeTableList: [],
    );

    await _festRepo.insertFestival(festival);

    if (file != null) {
      await _festRepo.uploadFestivalImage(file, key);
    }

    state = AsyncValue.data(festival);

    context.pushNamed(TimeTableScreen.routeName, params: {"festivalKey": key});
  }

  // 페스티벌 수정
  Future<void> updateFestival(Map<dynamic, dynamic> form, File? file) async {
    state = const AsyncValue.loading();

    final festival = FestivalModel(
      key: form["key"],
      name: form["name"],
      startDate: form["startDate"],
      endDate: form["endDate"],
      openTime: form["openTime"],
      location: form["location"],
      mainColor: form["mainColor"],
      subColor: form["subColor"],
      stages: form["stages"].toString().split(","),
      filter: form["filter"].toString().split(","),
      timeTables: [],
      timeTableList: [],
    );

    await _festRepo.insertFestival(festival);

    if (file != null) {
      await _festRepo.uploadFestivalImage(file, form["key"]);
    }

    state = AsyncValue.data(festival);
  }
}

// 2) 페스티벌 목록 FestivalsViewModel
class FestivalsViewModel extends AsyncNotifier<List<FestivalModel>> {
  // 페스티벌 정보
  late List<FestivalModel> _festivals = [];
  late final FestivalRepository _festRepo;

  // 사용자 정보에 따른 목록 조회 필요
  UserModel _user = UserModel.empty();
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<List<FestivalModel>> build() async {
    _festRepo = ref.read(festivalRepo);
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    return _festivals;
  }

  // 1. 북마크한 페스티벌 조회
  Future<void> getBookmarkFestivals() async {
    state = const AsyncValue.loading();

    // 로그인 된 데이터가 있다면 정보 가져오기
    if (_authRepo.isLoggedIn) {
      final user = await _userRepo.getUser(_authRepo.user!.uid);

      if (user != null) {
        _user = UserModel.fromJson(user);
      }
    }

    final result = await _festRepo.getFestivalListByBookmarks(_user.bookmarks);
    if (result != null) {
      // print("result : $result");
      _festivals = result.map((data) => FestivalModel.fromJson(data)).toList();
    }

    state = AsyncValue.data(_festivals);
  }
}

// 3) 페스티벌 목록 다중 상태 FestivalsNotifier
class FestivalsNotifier extends StateNotifier<AsyncValue<List<FestivalModel>>> {
  final FestivalRepository festRepo;
  final FestivalThemeModel theme; // 각 FestivalThemeModel에 맞는 상태를 관리

  FestivalsNotifier(this.festRepo, this.theme)
      : super(const AsyncValue.loading());

  // 1. 테마별 페스티벌 조회
  Future<void> getThemeFestivals() async {
    try {
      state = const AsyncValue.loading(); // 상태를 로딩으로 설정

      final result = await festRepo.getFestivalListByFilter(theme);

      if (result != null) {
        final festivals =
            result.map((data) => FestivalModel.fromJson(data)).toList();
        state = AsyncValue.data(festivals);
        print("FestivalsNotifier : ${festivals.length}");
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // 상태를 에러로 설정
    }
  }
}

final festivalProvider =
    AsyncNotifierProvider<FestivalViewModel, FestivalModel>(
  () => FestivalViewModel(),
);

final festivalsProvider =
    AsyncNotifierProvider<FestivalsViewModel, List<FestivalModel>>(
  () => FestivalsViewModel(),
);

final festivalRepoProvider = Provider<FestivalRepository>((ref) {
  return FestivalRepository(); // 실제 리포지토리 구현에 맞게 변경
});

final festivalsProviderFamily = StateNotifierProvider.family<FestivalsNotifier,
    AsyncValue<List<FestivalModel>>, FestivalThemeModel>(
  (ref, theme) {
    final festivalRepo = ref.read(festivalRepoProvider);
    return FestivalsNotifier(festivalRepo, theme);
  },
);
