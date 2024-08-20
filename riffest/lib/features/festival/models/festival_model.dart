import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalModel {
  final String key;
  final String name;
  final String startDate;
  final String endDate;
  final String openTime; // 입장 오픈 시간
  final String location;
  final String mainColor;
  final String subColor;
  final List<String> stages;
  final List<String> filter;
  List<Map<String, dynamic>>? timeTableList; // for insert

  late List<List<TimeTableModel>> timeTables; // for select
  late final int diffDays;

  FestivalModel({
    required this.key,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.openTime,
    required this.location,
    required this.mainColor,
    required this.subColor,
    required this.stages,
    required this.filter,
    required this.timeTables,
    required this.timeTableList,
  }) {
    timeTables = _mapListToModelList();
    diffDays = _getDiffDays();
  }

  FestivalModel.empty()
      : key = "",
        name = "",
        startDate = "",
        endDate = "",
        openTime = "",
        location = "",
        mainColor = "0xFFFFFFFF",
        subColor = "0xFFFFFFFF",
        stages = [],
        filter = [],
        timeTables = [],
        timeTableList = [],
        diffDays = 0;

  FestivalModel.fromJson(Map<String, dynamic> json)
      : key = json["key"],
        name = json["name"],
        startDate = json["startDate"],
        endDate = json["endDate"],
        openTime = json["openTime"] ?? "",
        location = json["location"],
        mainColor = json["mainColor"],
        subColor = json["subColor"],
        stages = List<String>.from(json["stages"]),
        filter =
            json["filter"] != null ? List<String>.from(json["filter"]) : [],
        timeTableList =
            List<Map<String, dynamic>>.from(json["timeTableList"] ?? []) {
    timeTables = _mapListToModelList();
    diffDays = _getDiffDays();
  }

  // JSON 으로 변경하기
  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "name": name,
      "startDate": startDate,
      "endDate": endDate,
      "openTime": openTime,
      "location": location,
      "mainColor": mainColor,
      "subColor": subColor,
      "stages": stages,
      "filter": filter,
      "timeTableList": timeTableList,
    };
  }

  int _getDiffDays() {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    int diffDays = end.difference(start).inDays + 1;
    return diffDays;
  }

  List<List<TimeTableModel>> _mapListToModelList() {
    int diffDays = _getDiffDays();

    // 초기화
    timeTables = [
      for (int i in Iterable.generate(diffDays)) [],
    ];

    // List<Map<String, dynamic>> timeTableList 에 값이 있으면 세팅
    if (timeTableList!.isNotEmpty) {
      for (Map<String, dynamic> item in timeTableList!) {
        TimeTableModel timeTable = TimeTableModel.fromJson(item);

        timeTables = [
          for (int i in Iterable.generate(diffDays))
            [
              ...timeTables[i],
              if (DateTime.parse(startDate)
                      .add(Duration(days: i))
                      .difference(DateTime.parse(timeTable.date))
                      .inDays ==
                  0)
                timeTable,
            ],
        ];
      }
    }

    return timeTables;
  }
}
