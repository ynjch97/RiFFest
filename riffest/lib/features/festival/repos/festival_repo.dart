import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalRepository {
  // 데이터베이스, 데이터스토리지 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ========================================================== Festivals

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
    Query collection = _db.collection("festival");

    if (theme.location != "") {
      // 지역 필터링
      collection = collection.where('filter', arrayContains: theme.location);
    } else if (theme.genre != "") {
      // 장르 필터링
      collection = collection.where('filter', arrayContains: theme.genre);
    }

    if (theme.year != "") {
      if (theme.month != "") {
        // 특정 yyyy-mm 필터링
        List<String> months = theme.month.split(",");
        String startDate = DateFormat('yyyy-MM-dd')
            .format(DateTime(int.parse(theme.year), int.parse(months[0]), 1));
        String endDate = DateFormat('yyyy-MM-dd').format(DateTime(
            int.parse(theme.year),
            int.parse(months[0]) + int.parse(months[1]),
            1));
        collection = collection.where(
          'startDate',
          isGreaterThanOrEqualTo: startDate,
          isLessThan: endDate,
        );
      } else {
        // 특정 yyyy 필터링
        String startDate = DateFormat('yyyy-MM-dd')
            .format(DateTime(int.parse(theme.year), 1, 1));
        String endDate = DateFormat('yyyy-MM-dd')
            .format(DateTime(int.parse(theme.year) + 1, 1, 1));
        collection = collection.where(
          'startDate',
          isGreaterThanOrEqualTo: startDate,
          isLessThan: endDate,
        );
      }
    }

    // 쿼리의 나머지 부분 추가
    collection = collection.orderBy('startDate').limit(10);

    final doc = await collection.get();

    // 문서(doc)를 배열로 변환
    List<Map<String, dynamic>> docs = doc.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // print("theme.location => ${theme.location} and docs.length => ${docs.length}");

    return docs;
  }

  // ========================================================== Festival

  // Select Festival
  Future<Map<String, dynamic>?> getFestival(String key) async {
    final doc = await _db.collection("festival").doc(key).get();
    return doc.data();
  }

  // Insert Festival
  Future<void> insertFestival(FestivalModel festival) async {
    await _db.collection("festival").doc(festival.key).set(festival.toJson());
  }

  // Upload Festival Image
  Future<void> uploadFestivalImage(File file, String fileName) async {
    final fileRef = _storage.ref().child("festival/$fileName");
    await fileRef.putFile(file);
  }

  // ========================================================== TimeTable

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

/*
WHERE Operators:
  isEqualTo: 필드 값이 특정 값과 같은 문서 필터링.
  isNotEqualTo: 필드 값이 특정 값과 같지 않은 문서 필터링.
  isGreaterThan: 필드 값이 특정 값보다 큰 문서 필터링.
  isGreaterThanOrEqualTo: 필드 값이 특정 값보다 크거나 같은 문서 필터링.
  isLessThan: 필드 값이 특정 값보다 작은 문서 필터링.
  isLessThanOrEqualTo: 필드 값이 특정 값보다 작거나 같은 문서 필터링.
  arrayContains: 필드 값이 특정 배열을 포함하는 문서 필터링.
  arrayContainsAny: 필드 값이 특정 배열 내의 요소 중 하나를 포함하는 문서 필터링.
  whereIn: 필드 값이 특정 리스트 중 하나와 일치하는 문서 필터링.
  whereNotIn: 필드 값이 특정 리스트와 일치하지 않는 문서 필터링.
*/
