import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/festival_filter_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalRepository {
  // 데이터베이스, 데이터스토리지 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Select Festival List
  Future<List<Map<String, dynamic>>?> getFestivalList() async {
    final doc = await _db.collection("festival").get();

    // 문서(doc)를 배열로 변환
    List<Map<String, dynamic>> docs =
        doc.docs.map((doc) => doc.data()).toList();

    // print("배열 => $docs");

    return docs;
  }

  // Select Festival List By Filter
  Future<List<Map<String, dynamic>>?> getFestivalListByFilter(
      FestivalThemeModel theme) async {
    final doc = await _db
        .collection("festival")
        .where("location", isGreaterThanOrEqualTo: theme.location)
        .orderBy("startDate")
        .get();

    // 문서(doc)를 배열로 변환
    List<Map<String, dynamic>> docs =
        doc.docs.map((doc) => doc.data()).toList();

    print(
        "theme.location => ${theme.location} and docs.length => ${docs.length}");

    return docs;
  }

  // Select Festival
  Future<Map<String, dynamic>?> getFestival(String key) async {
    final doc = await _db.collection("festival").doc(key).get();
    return doc.data();
  }

  // Insert Festival
  Future<void> insertFestival(FestivalModel festival) async {
    await _db.collection("festival").doc(festival.key).set(festival.toJson());
  }

  // =================================================================================================

  // Select TimeTable List
  Future<List<Map<String, dynamic>>?> getTimeTableList(String key) async {
    final doc = await _db
        .collection("timetable")
        .where("festKey", isEqualTo: key)
        .orderBy("startTime")
        .get();

    // 문서(doc)를 배열로 변환
    List<Map<String, dynamic>> docs =
        doc.docs.map((doc) => doc.data()).toList();
    // print("배열 : $docs");

    // Future<List<TimeTableModel>?> 타입일 경우 아래와 같음
    // List<TimeTableModel> docs =
    //         doc.docs.map((doc) => TimeTableModel.fromJson(doc.data())).toList();

    return docs;
  }

  // Insert TimeTable
  Future<void> insertTimeTable(String key, TimeTableModel timeTable) async {
    await _db.collection("timetable").doc(key).set(timeTable.toJson());
  }
}

final festivalRepo = Provider((ref) => FestivalRepository());
