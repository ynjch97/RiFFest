import 'package:intl/intl.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalModel {
  final String key;
  final String name;
  final String startDate;
  final String endDate;
  final String location;
  List<TimeTableModel> timeTables;

  FestivalModel({
    required this.key,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.timeTables,
  });

  FestivalModel.empty()
      : key = "",
        name = "",
        startDate = "",
        endDate = "",
        location = "",
        timeTables = [];

  int getDiffDays() {
    print("diffDays $startDate");
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    print(DateFormat('yyyy/MM/dd').format(start));

    Duration diff = end.difference(start);
    int diffDays = diff.inDays;
    print(diffDays);
    return diffDays;
  }
}
