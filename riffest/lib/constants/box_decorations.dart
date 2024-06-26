import 'package:riffest/constants/colours.dart';
import 'package:flutter/material.dart';

// Container > BoxDecoration
class BoxDecorations {
  // 흰색 기본 Container
  // static final borderlessContainer = BoxDecoration(
  //   color: Colors.white,
  //   borderRadius: BorderRadius.circular(3),
  // );

  // 테두리가 있는 흰색 기본 Container
  // static final greyBorderContainer = BoxDecoration(
  //   color: Colors.white,
  //   border: Border.all(
  //     color: Colours.borderGrey,
  //     width: 1,
  //   ),
  //   borderRadius: BorderRadius.circular(3),
  // );

  // 테두리가 있는 흰색 둥근 Container
  static final blackBorderContainer = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: Colours.borderBlack,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(50),
  );

  // 테두리 없는 grey Container
  // static final greyContainer = BoxDecoration(
  //   color: Colours.bgGrey,
  // );

  // 하단 Radius Container
  // static const radiusContainer = BoxDecoration(
  //   color: Colours.primaryColor,
  //   borderRadius: BorderRadius.only(
  //     bottomLeft: Radius.circular(10),
  //     bottomRight: Radius.circular(10),
  //   ),
  // );

  // 기본 Button
  // static final defaultButton = BoxDecoration(
  //   color: Colours.primaryColor,
  //   borderRadius: BorderRadius.circular(3),
  // );

  // 기본 Button Disabled
  // static final defaultButtonDisabled = BoxDecoration(
  //   color: Colours.buttonGrey,
  //   borderRadius: BorderRadius.circular(3),
  // );
}
