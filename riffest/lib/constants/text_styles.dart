import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:flutter/material.dart';

// Text > TextStyle
class TextStyles {
  /* 앱바, 제목 등 */

  // Appbar Title Text
  static final appbarTitle = TextStyle(
    fontSize: Sizes.size20,
    fontWeight: FontWeight.w800,
    color: Colours.textBlack,
  );

  // Title Text Big
  static final bigTitle = TextStyle(
    fontSize: Sizes.size24,
    fontWeight: FontWeight.w700,
    color: Colours.textBlack,
  );
  // Subtitle Text Big
  static final bigSubtitle = TextStyle(
    fontSize: Sizes.size18,
    fontWeight: FontWeight.w400,
    color: Colours.textDarkGrey,
  );

  /* 버튼, 레이블, 텍스트필드 등 */

  // Button Default
  static const defaultButton = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w600,
    color: Colours.textWhite,
  );
  // Button Disabled
  static final defaultButtonDisabled = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w600,
    color: Colours.textGrey,
  );

  // Text Default Label
  static final defaultLabel = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  // Text Default Label Reverse
  static const defaultLabelReverse = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w400,
    color: Colours.textWhite,
  );

  // TextField Default
  static final defaultTextField = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  // TextField Default Hint
  static final defaultTextFieldHint = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w400,
    color: Colours.textGrey,
  );
  // TextField Default Error
  static const defaultTextFieldError = TextStyle(
    fontSize: Sizes.size13,
    fontWeight: FontWeight.w400,
    color: Colours.errorColor,
  );

  // Text Mini
  static final miniLabel = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w400,
    color: Colours.textDarkGrey,
  );
  // Text Mini
  static final miniBoldLabel = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w600,
    color: Colours.textDarkGrey,
  );

  /* 기본 텍스트 */

  // Text Highlight
  static final highlightText = TextStyle(
    fontSize: Sizes.size22,
    fontWeight: FontWeight.w600,
    color: Colours.textBlack,
  );
  static final highlightTextGray = TextStyle(
    fontSize: Sizes.size22,
    fontWeight: FontWeight.w600,
    color: Colours.textGrey,
  );

  // Text Xlarge
  static final xlargeText = TextStyle(
    fontSize: Sizes.size18,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  static final xlargeBoldText = TextStyle(
    fontSize: Sizes.size18,
    fontWeight: FontWeight.w600,
    color: Colours.textBlack,
  );

  // Text Large
  static final largeText = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  static final largeBoldText = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w600,
    color: Colours.textBlack,
  );

  // Text Default Gray
  static final defaultTextGray = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w400,
    color: Colours.textGrey,
  );
  static final defaultBoldTextGray = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w600,
    color: Colours.textGrey,
  );

  // Text Default White
  static const defaultTextWhite = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const defaultBoldTextWhite = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Text Default
  static final defaultText = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  static final defaultBoldText = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w500,
    color: Colours.textBlack,
  );

  // Text Mini White
  static const miniTextWhite = TextStyle(
    fontSize: Sizes.size12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const miniBoldTextWhite = TextStyle(
    fontSize: Sizes.size12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Text Mini
  static final miniText = TextStyle(
    fontSize: Sizes.size12,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  static final miniBoldText = TextStyle(
    fontSize: Sizes.size12,
    fontWeight: FontWeight.w500,
    color: Colours.textBlack,
  );

  // Text Tiny White
  static const tinyTextWhite = TextStyle(
    fontSize: Sizes.size10,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const tinyBoldTextWhite = TextStyle(
    fontSize: Sizes.size10,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Text Tiny
  static final tinyText = TextStyle(
    fontSize: Sizes.size10,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );
  static final tinyBoldText = TextStyle(
    fontSize: Sizes.size10,
    fontWeight: FontWeight.w500,
    color: Colours.textBlack,
  );
}
