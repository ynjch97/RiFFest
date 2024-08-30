import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riffest/constants/text_styles.dart';

// 에러
void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        (error as FirebaseException).message ?? "Error occurred",
        style: TextStyles.defaultLabelReverse,
      ),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

// 분 차이 계산
int calcMinDiff(
    String startDate, String startHour, String endDate, String endHour) {
  DateTime start = DateTime.parse("$startDate $startHour");
  DateTime end = DateTime.parse("$endDate $endHour");
  int diff = end.difference(start).inMinutes;
  return diff;
}

// 디데이 계산
String calcDayDiff(String startDate) {
  DateTime today = DateTime.now();
  DateTime start = DateTime.parse(startDate);
  int diff = today.difference(start).inDays;

  String diffStr = "";
  if (diff == 0) {
    diffStr = "D-day";
  } else if (diff > 0) {
    diffStr = "D+$diff";
  } else {
    diffStr = "D$diff";
  }

  return diffStr;
}

// yy.mm.dd 형식으로 날짜 반환
String getDateString(String date) {
  String result = "";

  if (date.isEmpty) {
    result = DateFormat('yy.MM.dd').format(DateTime.now());
  } else {
    result = DateFormat('yy.MM.dd').format(DateTime.parse(date));
  }

  return result;
}

// 다크모드 여부 판단
bool isDarkColor(String colorHex) {
  // "0x"를 제거하고 16진수 문자열을 정수로 변환
  int color = int.parse(colorHex.replaceFirst('0x', ''), radix: 16);

  // RGB 값 추출
  int r = (color >> 16) & 0xFF;
  int g = (color >> 8) & 0xFF;
  int b = color & 0xFF;

  // Luminance 계산
  double luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;

  // 임계값을 기준으로 밝기 판단
  return luminance < 0.7; // 0.5는 임의의 임계값으로, 밝기 판단 기준
}
