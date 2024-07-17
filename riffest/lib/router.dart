// ignore_for_file: slash_for_doc_comments

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/authentication/views/login_screen.dart';
import 'package:riffest/features/authentication/views/sign_up_screen.dart';
import 'package:riffest/features/main/views/main_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/profile", // 시작 화면 설정
    redirect: (context, state) {
      // final isLoggedIn = ref.read(authRepo).isLoggedIn;
      const isLoggedIn = false;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          // 회원가입, 로그인 페이지 제외 접근 불가하도록
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      // 회원가입
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      // 로그인
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      // 이메일로 회원가입
      // GoRoute(
      //   name: EmailScreen.routeName,
      //   path: EmailScreen.routeURL,
      //   builder: (context, state) => const EmailScreen(),
      // ),
      // 약관동의
      // GoRoute(
      //   name: TermsScreen.routeName,
      //   path: TermsScreen.routeURL,
      //   builder: (context, state) => const TermsScreen(),
      // ),
      // 메인
      GoRoute(
        name: MainScreen.routeName,
        path: MainScreen.routeURL, // festival|community|profile
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainScreen(
            tab: tab,
          );
        },
      ),
    ],
  );
});
