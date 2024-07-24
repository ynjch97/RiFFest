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
  //     width: 0.5,
  //   ),
  //   borderRadius: BorderRadius.circular(3),
  // );

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

  /* ---------------------- 라운드 버튼 ---------------------- */

  // 테두리가 있는 흰색 둥근 Container
  static final whiteRoundContainer = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: Colours.borderBlack,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(50),
  );

  // 테두리가 있는 기본 둥근 Container
  static final defaultRoundContainer = BoxDecoration(
    color: Colours.primaryColor,
    border: Border.all(
      color: Colours.primaryColor,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(50),
  );

  /* ---------------------- 기본 버튼 ---------------------- */

  // 기본 Button
  static final defaultButton = BoxDecoration(
    color: Colours.primaryColor,
    borderRadius: BorderRadius.circular(3),
  );

  // 기본 Button Disabled
  static final defaultButtonDisabled = BoxDecoration(
    color: Colours.buttonGrey,
    borderRadius: BorderRadius.circular(3),
  );

  /* ---------------------- 카드 ---------------------- */

  // 상단/하단에만 Border가 있는 카드 Container
  static final cardTBContainer = BoxDecoration(
    // color: Colors.lightBlue
    color: Colors.white,
    border: Border(
      top: BorderSide(
        color: Colours.borderGrey,
        width: 0.5,
      ),
      bottom: BorderSide(
        color: Colours.borderGrey,
        width: 0.5,
      ),
    ),
  );

  // 상단에만 Border가 있는 카드 Container
  static final cardTContainer = BoxDecoration(
    // color: Colors.lightBlue
    color: Colors.white,
    border: Border(
      top: BorderSide(
        color: Colours.borderGrey,
        width: 0.5,
      ),
    ),
  );
}
