import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserRepository {
  // 데이터베이스, 데이터스토리지 접근하기
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  // Insert User
  Future<void> createUser(UserModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  // Select User
  Future<Map<String, dynamic>?> getUser(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }
}

final userRepo = Provider((ref) => UserRepository());
