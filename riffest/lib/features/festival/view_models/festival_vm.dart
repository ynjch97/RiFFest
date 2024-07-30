import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalViewModel extends AsyncNotifier<FestivalModel> {
  late FestivalModel festival;

  @override
  FutureOr<FestivalModel> build() async {
    await Future.delayed(const Duration(seconds: 2));

    festival = FestivalModel.empty();
    return festival;
  }

  Future<void> getTimeTables(String festKey) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));

    if (festKey == "1") {
      festival = FestivalModel(
        key: "1",
        name: "2024 펜타포트 락페스티벌",
        startDate: "2024-08-02",
        endDate: "2024-08-04",
        location: "송도 달빛축제공원",
        mainColor: 0xFFE82340,
        subColor: 0xFFFFC30B,
        stages: ["KB 국민카드 스타샵", "힐스테이트", "글로벌"],
        timeTables: [],
      );

      festival.timeTables = [
        [
          TimeTableModel(
            festKey: "1",
            date: "2024-08-02",
            startTime: "16:40",
            endTime: "17:10",
            stage: "글로벌",
            artist: "QWER",
          ),
          TimeTableModel(
            festKey: "1",
            date: "2024-08-02",
            startTime: "19:40",
            endTime: "20:40",
            stage: "KB 국민카드 스타샵",
            artist: "새소년",
          ),
          TimeTableModel(
            festKey: "1",
            date: "2024-08-02",
            startTime: "21:50",
            endTime: "23:00",
            stage: "KB 국민카드 스타샵",
            artist: "TURNSTILE",
          ),
          TimeTableModel(
            festKey: "1",
            date: "2024-08-02",
            startTime: "20:40",
            endTime: "21:40",
            stage: "힐스테이트",
            artist: "KIM GORDON",
          ),
          TimeTableModel(
            festKey: "1",
            date: "2024-08-02",
            startTime: "12:30",
            endTime: "13:10",
            stage: "KB 국민카드 스타샵",
            artist: "KARDI",
          ),
        ],
        [],
        [],
      ];
    }

    if (festKey == "2") {
      festival = FestivalModel(
        key: "2",
        name: "HAVE A NICE TRIP",
        startDate: "2024-07-27",
        endDate: "2024-07-28",
        location: "고양 킨텍스",
        mainColor: 0xFFEB5C27,
        subColor: 0xFFA4B03C,
        stages: ["SUNSET", "air"],
        timeTables: [],
      );

      festival.timeTables = [
        [],
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

    // 시간 순으로 정렬
    festival.timeTables[0].sort((a, b) {
      return DateTime.parse('${a.date} ${a.startTime}')
          .compareTo(DateTime.parse('${b.date} ${b.startTime}'));
    });

    state = AsyncValue.data(festival);
  }

  Future<void> insertTimeTable(Map<dynamic, dynamic> form) async {
    state = const AsyncValue.loading();

    final timeTable = TimeTableModel(
      festKey: "",
      date: form["date"],
      startTime: form["startTime"],
      endTime: form["endTime"],
      stage: form["stage"],
      artist: form["artist"],
    );
  }
}

final festivalProvider =
    AsyncNotifierProvider<FestivalViewModel, FestivalModel>(
  () => FestivalViewModel(),
);
