class TimeTableModel {
  final String festKey;
  final String date;
  final String startTime;
  final String endTime;
  final String stage;
  final String artist;

  TimeTableModel({
    required this.festKey,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.stage,
    required this.artist,
  });

  TimeTableModel.empty()
      : festKey = "",
        date = "",
        startTime = "",
        endTime = "",
        stage = "",
        artist = "";

  TimeTableModel.fromJson(Map<String, dynamic> json)
      : festKey = json["festKey"],
        date = json["date"],
        startTime = json["startTime"],
        endTime = json["endTime"],
        stage = json["stage"],
        artist = json["artist"];

  // JSON 으로 변경하기
  Map<String, dynamic> toJson() {
    return {
      "festKey": festKey,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "stage": stage,
      "artist": artist,
    };
  }
}
