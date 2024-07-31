import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';

class FestivalRepository {
  // 데이터베이스, 데이터스토리지 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Insert Festival
  Future<void> insertFestival(FestivalModel festival) async {
    await _db.collection("festival").doc(festival.key).set(festival.toJson());
  }

  // Select Festival
  Future<Map<String, dynamic>?> getFestival(String key) async {
    final doc = await _db.collection("festival").doc(key).get();
    return doc.data();
  }

  // Insert TimeTable
  Future<void> insertTimeTable(TimeTableModel timeTable) async {
    await _db
        .collection("festival")
        .doc(timeTable.festKey)
        .set(timeTable.toJson());
  }
}

final festivalRepo = Provider((ref) => FestivalRepository());
