import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/firebase_options.dart';
import 'package:riffest/router.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  /**앱 시작 전에 바꾸고 싶은 state 가 있다면
   * engine 자체와 engine-widget 연결을 확실히 초기화해야 함
   * WidgetsFlutterBinding : This is the glue that binds the framework to the Flutter engine.
   */
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SystemChrome : main() 에서 기본값으로 설정해도 되고, 페이지마다 다르게 설정해도 됨
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // final preferences = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'RiFFest',
      theme: ThemeData(
        primaryColor: Colours.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colours.primaryColor,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          // appBarTheme : AppBar 를 전역으로 꾸미기
          backgroundColor: Colors.white,
          foregroundColor: Colours.textBlack,
          surfaceTintColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyles.appbarTitle,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
    );
  }
}
