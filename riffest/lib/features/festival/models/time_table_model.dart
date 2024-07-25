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
}
