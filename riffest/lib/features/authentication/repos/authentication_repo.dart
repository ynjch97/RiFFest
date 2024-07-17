// ignore_for_file: slash_for_doc_comments

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  /**1. main.dart Firebase.initializeApp() 로 초기화 하고
   * 2. FirebaseAuth.instance 를 생성하면
   * => 바로 Firebase 와 소통할 수 있음
   * => Field '_authRepo@36334086' has not been initialized
   */
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser; // 로그인한 사용자는 Nullable
  bool get isLoggedIn => user != null;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> emailSignIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> emailSignOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

// StreamProvider : 변화를 바로 감지할 수 있음 => 유저 인증 상태 변경을 감지 (로그인/로그아웃)
final authStateStream = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
