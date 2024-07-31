import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';
import 'package:riffest/features/festival/repos/festival_repo.dart';

class TimeTableViewModel extends AsyncNotifier<TimeTableModel> {
  late final FestivalRepository _festRepo;

  @override
  FutureOr<TimeTableModel> build() async {
    _festRepo = ref.read(festivalRepo);

    return TimeTableModel.empty();
  }
}
