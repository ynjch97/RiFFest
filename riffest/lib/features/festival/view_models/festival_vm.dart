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

    festival = FestivalModel(
      key: "key",
      name: "2024 펜타포트 락페스티벌",
      startDate: "2024-08-02",
      endDate: "2024-08-04",
      location: "송도 달빛축제공원",
      timeTables: [],
    );

    if (festKey == "1") {
      festival.timeTables = [
        ...festival.timeTables,
        TimeTableModel(
          festKey: "1",
          date: "2024-08-02",
          startTime: "12:20",
          endTime: "13:00",
          artist: "KARDI",
        ),
        TimeTableModel(
          festKey: "1",
          date: "2024-08-02",
          startTime: "13:30",
          endTime: "13:40",
          artist: "새소년",
        ),
        TimeTableModel(
          festKey: "1",
          date: "2024-08-02",
          startTime: "13:30",
          endTime: "13:40",
          artist: "QWER",
        ),
      ];
    } else {
      festival.timeTables = [
        ...festival.timeTables,
        TimeTableModel(
          festKey: "1",
          date: "2024-08-02",
          startTime: "12:20",
          endTime: "13:00",
          artist: "HANRORO",
        ),
        TimeTableModel(
          festKey: "1",
          date: "2024-08-02",
          startTime: "13:30",
          endTime: "13:40",
          artist: "Silica Gel",
        ),
      ];
    }

    print(festival);
    state = AsyncValue.data(festival);
  }
}

final festivalProvider =
    AsyncNotifierProvider<FestivalViewModel, FestivalModel>(
  () => FestivalViewModel(),
);
