import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/festival_filter_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/repos/festival_repo.dart';
import 'package:uuid/uuid.dart';

// 페스티벌 FestivalViewModel
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
    final result = await _festRepo.getFestival(festKey);
    if (result != null) {
      // 타임테이블 조회
      result["timeTableList"] = await _festRepo.getTimeTableList(result["key"]);
      _festival = FestivalModel.fromJson(result);
    }

    // for (TimeTableModel item in _festival.timeTables[0]) {
    //   print("결과 :::: ${item.artist}");
    // }

    state = AsyncValue.data(_festival);
  }

  // 페스티벌 저장
  Future<void> insertFestival(Map<dynamic, dynamic> form) async {
    state = const AsyncValue.loading();

    final festival = FestivalModel(
      key: const Uuid().v4(),
      name: form["name"],
      startDate: form["startDate"],
      endDate: form["endDate"],
      openTime: form["openTime"],
      location: form["location"],
      mainColor: form["mainColor"],
      subColor: form["subColor"],
      stages: form["stages"].toString().split(","),
      timeTables: [],
      timeTableList: [],
    );

    await _festRepo.insertFestival(festival);
    state = AsyncValue.data(festival);
  }
}

// 페스티벌 목록 FestivalsViewModel
class FestivalsViewModel extends AsyncNotifier<List<FestivalModel>> {
  late List<FestivalModel> _festivals = [];
  late final FestivalRepository _festRepo;

  @override
  FutureOr<List<FestivalModel>> build() async {
    _festRepo = ref.read(festivalRepo);
    return _festivals;
  }

  // 1. 페스티벌 조회
  Future<void> getFestivals() async {
    state = const AsyncValue.loading();

    final result = await _festRepo.getFestivalList();
    if (result != null) {
      // print("result : $result");
      _festivals = result.map((data) => FestivalModel.fromJson(data)).toList();
    }
    // print("_festivals : ${_festivals.length}");

    state = AsyncValue.data(_festivals);
  }

  // 2. 테마별 페스티벌 조회
  Future<void> getThemeFestivals(FestivalThemeModel theme) async {
    state = const AsyncValue.loading();

    final result = await _festRepo.getFestivalListByFilter(theme);
    if (result != null) {
      // print("result : $result");
      _festivals = result.map((data) => FestivalModel.fromJson(data)).toList();
    }
    print("_festivals : ${_festivals.length}");

    state = AsyncValue.data(_festivals);
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
