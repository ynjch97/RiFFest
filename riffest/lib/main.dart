import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/router.dart';

void main() {
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
          titleTextStyle: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w800,
            color: Colours.textBlack,
          ),
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
