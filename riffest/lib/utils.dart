import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riffest/constants/text_styles.dart';

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
