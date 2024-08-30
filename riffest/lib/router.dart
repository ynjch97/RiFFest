// ignore_for_file: slash_for_doc_comments

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/authentication/views/login_screen.dart';
import 'package:riffest/features/authentication/views/sign_up_screen.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/views/festival_detail_screen.dart';
import 'package:riffest/features/festival/views/festival_list_screen.dart';
import 'package:riffest/features/festival/views/festival_screen.dart';
import 'package:riffest/features/festival/views/time_table_screen.dart';
import 'package:riffest/features/main/views/main_screen.dart';
import 'package:riffest/features/manage/views/add_time_table_screen.dart';
import 'package:riffest/features/manage/views/add_festival_screen.dart';
import 'package:riffest/features/user/views/profile_screen.dart';

/**1. 페스티벌 화면 접근 가능
 * 2. 회원가입 시 건너뛰기 클릭하면 페스티벌 화면으로 이동
 * 3. 커뮤니티, 가이드, 프로필 화면은 로그인 해주세요 문구 등장
 * 4. 화면마다 존재하는 로딩/에러 화면은 분리할 것
 */

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/festival", // 시작 화면 설정
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
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
      // 메인
      GoRoute(
        name: MainScreen.routeName,
        path: MainScreen.routeURL, // festival|community|guide|profile
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainScreen(
            tab: tab,
          );
        },
      ),
      // 메인 - 페스티벌
      GoRoute(
        name: FestivalScreen.routeName,
        path: FestivalScreen.routeURL,
        builder: (context, state) => const FestivalScreen(),
        routes: [
          GoRoute(
            name: FestivalDetailScreen.routeName,
            path: FestivalDetailScreen.routeURL,
            builder: (context, state) {
              final festivalKey = state.params["festivalKey"]!;
              return FestivalDetailScreen(festivalKey: festivalKey);
            },
          ),
        ],
      ),
      // 메인 - 페스티벌 - 테마별 목록 전체보기
      GoRoute(
        name: FestivalListScreen.routeName,
        path: FestivalListScreen.routeURL,
        builder: (context, state) {
          final themeKey = state.params["themeKey"]!;
          FestivalThemeModel? theme = state.extra as FestivalThemeModel?;

          // theme 값이 null 이면 즉, url 에서 themeKey 만 입력했다면 직접 모델에서 찾음
          if (theme == null) {
            final themeList = festivalThemeList();
            theme = themeList.firstWhere(
              (theme) => theme.themeKey == themeKey,
            );
          }
          return FestivalListScreen(theme: theme);
        },
      ),
      // 메인 - 타임테이블
      GoRoute(
        name: TimeTableScreen.routeName,
        path: TimeTableScreen.routeURL,
        builder: (context, state) {
          String? festivalKey = state.params["festivalKey"];
          festivalKey ??= "";
          return TimeTableScreen(festivalKey: festivalKey);
        },
      ),
      // 메인 - 프로필
      GoRoute(
        name: ProfileScreen.routeName,
        path: ProfileScreen.routeURL,
        builder: (context, state) => const ProfileScreen(),
      ),
      // 관리 - 페스티벌 추가
      GoRoute(
        name: AddFestivalScreen.routeName,
        path: AddFestivalScreen.routeURL,
        builder: (context, state) => const AddFestivalScreen(),
      ),
      // 관리 - 타임테이블 추가
      GoRoute(
        name: AddTimeTableScreen.routeName,
        path: AddTimeTableScreen.routeURL,
        builder: (context, state) => const AddTimeTableScreen(),
      ),
    ],
  );
});
