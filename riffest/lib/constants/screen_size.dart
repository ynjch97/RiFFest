// 반응형 화면 크기 (Tailwind CSS 방식 )
import 'package:flutter/material.dart';

class Breakpoints {
  static const sm = 640.0;
  static const md = 768.0;
  static const lg = 1024.0;
  static const xl = 1280.0;
  static const xxl = 1536.0;
}

class ScreenSize {
  final Size size;
  // late final double boxWidth, boxHeight, textFieldWidth, hPadding;
  late final double screenW, screenH;
  late final double menuTabW, menuTabH;

  ScreenSize({required this.size});

  ScreenSize.calculate({required this.size}) {
    // boxWidth = size.width * 0.5;
    // boxHeight = size.height * 0.35;
    // textFieldWidth = boxWidth * 0.5;
    // hPadding = boxWidth * 0.03;
    screenW = size.width;
    screenH = size.height;
    menuTabW = size.width > Breakpoints.lg ? 350 : 250;
    menuTabH = size.height * 0.2;
  }
}
