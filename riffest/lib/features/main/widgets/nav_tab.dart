import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';

class NavTab extends StatelessWidget {
  final String text;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final int selectedIndex;
  final Function onTap;

  const NavTab({
    super.key,
    required this.text,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // 영역 확장을 위해 Expanded + Container 활용
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: selectedIndex == 1 ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.7,
            child: Column(
              // Column 은 세로축으로 최대한 확장하려고 하기 때문에, children 의 공간 만큼만 확장하도록 MainAxisSize 설정
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 1 ? Colors.white : Colors.black,
                  size: Sizes.size20,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: selectedIndex == 1 ? Colors.white : Colors.black,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
