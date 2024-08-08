import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';

// AppBar 아이콘 버튼 공통화
class AppbarIconBtn extends StatelessWidget {
  final IconData icon;
  final void Function(BuildContext) onPressedFunction;

  const AppbarIconBtn({
    super.key,
    required this.icon,
    required this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressedFunction(context),
      icon: FaIcon(
        icon,
        size: Sizes.size20,
        color: Colours.textBlack,
      ),
    );
  }
}

// AppBar 아이콘 버튼 공통화 (AppBar 가 아닌 곳에서 사용)
class NoAppbarIconBtn extends StatelessWidget {
  final IconData icon;
  final void Function(BuildContext) onTapFunction;

  const NoAppbarIconBtn({
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
        size: Sizes.size20,
        color: Colours.textBlack,
      ),
    );
  }
}
