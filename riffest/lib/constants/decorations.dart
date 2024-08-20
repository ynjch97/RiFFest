import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

// Container > InputDecoration
class InputDecorations {
  // 기본 텍스트 필드
  static InputDecoration defaultTextField(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyles.defaultTextFieldHint,
      errorStyle: TextStyles.defaultTextFieldError,
      errorBorder: Borders.underlineInputBorderError,
      border: Borders.underlineInputBorder,
      focusedBorder: Borders.underlineInputBorder,
    );
  }

  // 날짜/시간 텍스트 필드
  static defaultDateField(IconData icon) {
    return InputDecoration(
      hintStyle: TextStyles.defaultTextFieldHint,
      errorStyle: TextStyles.defaultTextFieldError,
      errorBorder: Borders.underlineInputBorderError,
      border: Borders.underlineInputBorder,
      focusedBorder: Borders.underlineInputBorder,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: Sizes.size8),
        child: Icon(
          icon,
          size: Sizes.size20,
          color: Colours.textBlack,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 0,
      ),
    );
  }
}

// Container > BoxDecoration
class BoxDecorations {
  // 흰색 기본 Container
  static const whiteContainer = BoxDecoration(
    color: Colors.white,
  );

  // 테두리 없는 grey Container
  // static final greyContainer = BoxDecoration(
  //   color: Colours.bgGrey,
  // );

  /* ---------------------- 메뉴 ---------------------- */

  // 흰색 하단 Radius Container (상단 스와이프 메뉴용)
  static const whiteRadiusContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
  );

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

  // 기본 Button + Round
  static final roundButton = BoxDecoration(
    color: Colours.primaryColor,
    borderRadius: BorderRadius.circular(50),
  );

  // 기본 Button Disabled + Round
  static final roundButtonDisabled = BoxDecoration(
    color: Colours.buttonGrey,
    borderRadius: BorderRadius.circular(50),
  );

  /* ---------------------- 카드 ---------------------- */

  // 상단/하단에만 Border가 있는 카드 Container
  static final cardTBContainer = BoxDecoration(
    // color: Colors.lightBlue
    color: Colors.white,
    border: Border.symmetric(
      horizontal: BorderSide(
        color: Colours.borderGrey,
        width: 0.5,
      ),
    ),
  );

  // 상단에만 Border가 있는 카드 Container
  // static final cardTContainer = BoxDecoration(
  //   // color: Colors.lightBlue
  //   color: Colors.white,
  //   border: Border(
  //     top: BorderSide(
  //       color: Colours.borderGrey,
  //       width: 0.5,
  //     ),
  //   ),
  // );

  // 하단에만 Border가 있는 카드 Container
  // static final cardBContainer = BoxDecoration(
  //   // color: Colors.lightBlue
  //   color: Colors.white,
  //   border: Border(
  //     bottom: BorderSide(
  //       color: Colours.borderGrey,
  //       width: 0.5,
  //     ),
  //   ),
  // );

  /* ---------------------- 타임테이블 ---------------------- */

  // 30분 단위 하단 Border Container
  static final bottom30Container = BoxDecoration(
    // color: Colors.lightBlue
    color: Colors.white,
    border: Border(
      bottom: BorderSide(
        color: Colours.borderGrey,
        width: 0.5,
      ),
    ),
  );

  // 60분 단위 하단 Border Container
  static final bottom60Container = BoxDecoration(
    // color: Colors.lightBlue
    color: Colors.white,
    border: Border(
      bottom: BorderSide(
        color: Colours.borderGrey,
        width: 1.0,
      ),
    ),
  );

  // 타임테이블 Container
  static const timeTableContainer = BoxDecoration(
    // color: Colors.lightBlue
    color: Colours.secondaryColor,
  );

  /* ---------------------- 페스티벌 목록 ---------------------- */

  // 포스터 Container
  static final posterContainer = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: Colours.borderGrey,
      width: 0.5,
    ),
    borderRadius: BorderRadius.circular(3),
  );

  // 포스터 아이콘용 반투명 회색 Container
  static final posterIconContainer = BoxDecoration(
    color: Colors.black.withOpacity(0.4),
    borderRadius: BorderRadius.circular(3),
  );

  /* ---------------------- 테스트 ---------------------- */

  // 영역 테스트 Container
  static final test1 = BoxDecoration(
    color: Colours.primaryColor,
    border: Border.all(
      color: Colors.lightBlueAccent,
      width: 1.5,
    ),
  );
  static final test2 = BoxDecoration(
    color: Colors.lightGreenAccent,
    border: Border.all(
      color: Colors.pinkAccent,
      width: 1.5,
    ),
  );
}
