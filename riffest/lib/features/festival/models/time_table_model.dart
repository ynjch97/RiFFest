class TimeTableModel {
  final String festKey;
  final String date;
  final String startTime;
  final String endTime;
  final String artist;

  TimeTableModel({
    required this.festKey,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.artist,
  });

  TimeTableModel.empty()
      : festKey = "",
        date = "",
        startTime = "",
        endTime = "",
        artist = "";
}
