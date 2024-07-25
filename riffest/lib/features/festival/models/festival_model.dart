import 'package:intl/intl.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalModel {
  final String key;
  final String name;
  final String startDate;
  final String endDate;
  final String location;
  final List<String> stages;
  List<TimeTableModel> timeTables;

  late final int diffDays;

  FestivalModel({
    required this.key,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.stages,
    required this.timeTables,
  }) {
    diffDays = _getDiffDays();
  }

  FestivalModel.empty()
      : key = "",
        name = "",
        startDate = "",
        endDate = "",
        location = "",
        stages = [],
        timeTables = [],
        diffDays = 0;

  int _getDiffDays() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    int diffDays = end.difference(start).inDays + 1;
    return diffDays;
  }
}
