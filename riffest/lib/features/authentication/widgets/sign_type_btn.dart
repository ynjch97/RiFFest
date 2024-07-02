import 'dart:js';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class SignTypeBtn extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final void Function(BuildContext) onTapFunction;

  const SignTypeBtn({
    super.key,
    required this.text,
    required this.icon,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFunction(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14,
          ),
          decoration: BoxDecorations.blackBorderContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Gaps.h10,
              Text(
                text,
                style: TextStyles.defaultLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
