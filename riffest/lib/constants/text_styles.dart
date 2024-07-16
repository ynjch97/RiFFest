import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:flutter/material.dart';

// Text > TextStyle
class TextStyles {
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

  // Title Text Default
  // static final defaultTitle = TextStyle(
  //   fontSize: Sizes.size18,
  //   fontWeight: FontWeight.w600,
  //   color: Colours.textBlack,
  // );
  // Subtitle Text Default
  // static final defaultSubtitle = TextStyle(
  //   fontSize: Sizes.size14,
  //   fontWeight: FontWeight.w400,
  //   color: Colours.textBlack,
  // );

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
    fontSize: Sizes.size12,
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
}
