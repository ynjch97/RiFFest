import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:flutter/material.dart';

// Text > TextStyle
class TextStyles {
  // Button Default
  static const buttonLabel = TextStyle(
    fontSize: Sizes.size16,
    color: Colours.textWhite,
  );
  // Button Disabled
  static final buttonLabelDisabled = TextStyle(
    fontSize: Sizes.size16,
    color: Colours.textBlack,
  );

  // Title Text Default
  static final defaultTitle = TextStyle(
    fontSize: Sizes.size18,
    fontWeight: FontWeight.w600,
    color: Colours.textBlack,
  );
  // Subtitle Text Default
  static final defaultSubtitle = TextStyle(
    fontSize: Sizes.size14,
    fontWeight: FontWeight.w400,
    color: Colours.textBlack,
  );

  // Text Default
  static final defaultLabel = TextStyle(
    fontSize: Sizes.size16,
    fontWeight: FontWeight.w500,
    color: Colours.textBlack,
  );
  // TextField Default
  static const defaultTextField = TextStyle(
    fontSize: Sizes.size16,
  );
}
