import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';
import 'package:riffest/features/festival/repos/festival_repo.dart';
import 'package:uuid/uuid.dart';

class FestivalViewModel extends AsyncNotifier<FestivalModel> {
  late FestivalModel festival;

  late final FestivalRepository _festRepo;

  @override
  FutureOr<FestivalModel> build() async {
    _festRepo = ref.read(festivalRepo);

    festival = FestivalModel.empty();
    return festival;
  }

  // 타임테이블 목록
  Future<void> getTimeTables(String festKey) async {
    state = const AsyncValue.loading();

    final result = await _festRepo.getFestival(festKey);
    if (result != null) {
      festival = FestivalModel.fromJson(result);
    }

    if (festKey != "09bf67a4-561c-473a-8927-944bf8c3dc75") {
      festival.timeTables = [
        [
          TimeTableModel(
            festKey: "2",
            date: "2024-07-27",
            startTime: "18:30",
            endTime: "19:40",
            stage: "SUNSET",
            artist: "ALVVAYS",
          ),
        ],
        [
          TimeTableModel(
            festKey: "2",
            date: "2024-07-28",
            startTime: "18:30",
            endTime: "19:40",
            stage: "SUNSET",
            artist: "ALVVAYS",
          ),
          TimeTableModel(
            festKey: "2",
            date: "2024-07-28",
            startTime: "19:30",
            endTime: "20:40",
            stage: "air",
            artist: "SAMPHA",
          ),
          TimeTableModel(
            festKey: "2",
            date: "2024-07-28",
            startTime: "20:40",
            endTime: "22:00",
            stage: "SUNSET",
            artist: "KING KRULE",
          ),
        ],
      ];
    }

    state = AsyncValue.data(festival);
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

  // 페스티벌 타임테이블 저장
  Future<void> insertTimeTable(Map<dynamic, dynamic> form) async {
    state = const AsyncValue.loading();

    // final timeTable = TimeTableModel(
    //   festKey: form["festKey"],
    //   date: form["date"],
    //   startTime: form["startTime"],
    //   endTime: form["endTime"],
    //   stage: form["stage"],
    //   artist: form["artist"],
    // ).toJson();

    final timeTable = TimeTableModel(
      festKey: "09bf67a4-561c-473a-8927-944bf8c3dc75",
      date: "2024-08-03",
      startTime: "19:30",
      endTime: "20:30",
      stage: "KB 국민카드 스타샵",
      artist: "실리카겔",
    ).toJson();

    final timeTable2 = TimeTableModel(
      festKey: "09bf67a4-561c-473a-8927-944bf8c3dc75",
      date: "2024-08-03",
      startTime: "18:50",
      endTime: "19:30",
      stage: "힐스테이트",
      artist: "Dark Mirror ov Tragedy",
    ).toJson();

    final timeTable3 = TimeTableModel(
      festKey: "09bf67a4-561c-473a-8927-944bf8c3dc75",
      date: "2024-08-03",
      startTime: "20:30",
      endTime: "21:30",
      stage: "힐스테이트",
      artist: "RIDE",
    ).toJson();

    final result = await _festRepo.getFestival(form["festKey"]);
    if (result != null) {
      FestivalModel festival = FestivalModel.fromJson(result);

      festival.timeTableList = [
        ...festival.timeTableList,
        timeTable,
        timeTable2,
        timeTable3,
      ];

      await _festRepo.insertFestival(festival);
      state = AsyncValue.data(festival);
    }
  }
}

final festivalProvider =
    AsyncNotifierProvider<FestivalViewModel, FestivalModel>(
  () => FestivalViewModel(),
);
