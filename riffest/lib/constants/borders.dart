import 'package:riffest/constants/colours.dart';
import 'package:flutter/material.dart';

// Container > Border
class Borders {
  // 밑줄이 있는 기본 Border
  static const underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colours.primaryColor,
      width: 1.5,
    ),
  );
  // 밑줄이 있는 기본 Border 에러
  static const underlineInputBorderError = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colours.errorColor,
      width: 2.0,
    ),
  );
}
