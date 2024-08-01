// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';

class ListIconBtn extends StatelessWidget {
  final IconData icon;
  final void Function(BuildContext) onTapFunction;

  const ListIconBtn({
    super.key,
    required this.icon,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFunction(context),
      child: FaIcon(
        icon,
        size: Sizes.size16,
        color: Colours.textBlack,
      ),
    );
  }
}
