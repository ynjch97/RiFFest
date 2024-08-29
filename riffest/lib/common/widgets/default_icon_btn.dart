import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/sizes.dart';

/* 공통 아이콘 버튼
FestivalScreen > 상단 - 로고, 검색 버튼
FestivalDetailScreen > 상단 북마크 버튼 등
*/
class DefaultIconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function(BuildContext) onTapFunction;

  const DefaultIconBtn({
    super.key,
    required this.icon,
    required this.color,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFunction(context),
      child: FaIcon(
        icon,
        size: Sizes.size20,
        color: color, // Colours.textBlack or Colors.white
      ),
    );
  }
}
