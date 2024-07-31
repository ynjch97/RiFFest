import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/festival/models/time_table_dummy.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';
import 'package:riffest/features/festival/repos/festival_repo.dart';
import 'package:riffest/features/festival/views/time_table_screen.dart';
import 'package:riffest/utils.dart';
import 'package:uuid/uuid.dart';

class TimeTableViewModel extends AsyncNotifier<void> {
  late final FestivalRepository _festRepo;

  @override
  FutureOr<void> build() async {
    _festRepo = ref.read(festivalRepo);
  }

  // 타임테이블 저장 (insertTimeTable)
  Future<void> insertTimeTable(
      BuildContext context, Map<String, dynamic> form) async {
    state = const AsyncValue.loading();

    final timeTable = TimeTableModel.fromJson(form);
    state = await AsyncValue.guard(() async {
      await _festRepo.insertTimeTable(const Uuid().v4(), timeTable);
    });

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.pushNamed(TimeTableScreen.routeName);
    }
  }

  // 타임테이블 dummy 저장 (insertTimeTable)
  Future<void> insertTimeTableDummy(BuildContext context) async {
    state = const AsyncValue.loading();

    final timeTables = timetableModelDummy();

    state = await AsyncValue.guard(() async {
      for (TimeTableModel item in timeTables) {
        await _festRepo.insertTimeTable(const Uuid().v4(), item);
      }
    });

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.pushNamed(TimeTableScreen.routeName);
    }
  }
}

final timeTableProvider = AsyncNotifierProvider<TimeTableViewModel, void>(
  () => TimeTableViewModel(),
);
