import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

// todo: FestivalViewModel 로 개발 가능하면 파일 삭제하기
class TimeTableViewModel extends AsyncNotifier<List<TimeTableModel>> {
  List<TimeTableModel> _list = [];

  @override
  FutureOr<List<TimeTableModel>> build() async {
    await Future.delayed(const Duration(seconds: 2));
    return _list;
  }

  Future<void> getTimeTables(String festKey) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));

    if (festKey == "1") {
      _list = [
        ..._list,
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
      ];
    } else {
      _list = [
        ..._list,
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

    state = AsyncValue.data(_list);
  }
}

final timeTableProvider =
    AsyncNotifierProvider<TimeTableViewModel, List<TimeTableModel>>(
  () => TimeTableViewModel(),
);
