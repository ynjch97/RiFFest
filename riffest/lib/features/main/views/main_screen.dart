// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/features/community/views/community_screen.dart';
import 'package:riffest/features/festival/views/festival_screen.dart';
import 'package:riffest/features/festival/views/time_table_screen.dart';
import 'package:riffest/features/main/widgets/nav_tab.dart';
import 'package:riffest/features/user/views/profile_screen.dart';

/**1. FestivalScreen
 * - 페스티벌 목록
 * 2. CommunityScreen
 * - 커뮤니티 게시판
 * 3. TimeTableScreen
 * - 페스티벌 목록 > 상세 화면 > 타임테이블 보기
 * - 상세 화면에는 항상 페스티벌 변경 가능한 셀렉트 박스가 상단에 존재해야 함
 * 4. 프로필
 */

class MainScreen extends StatefulWidget {
  static const routeURL = Routes.mainScreen;
  static const routeName = RoutesName.mainScreen;

  final String tab;

  const MainScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex = Tabs.mainTabs.indexOf(widget.tab);

  void _onNavTap(int index) {
    context.go("/${Tabs.mainTabs[index]}"); // URL 도 이동

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 화면을 가리지 않도록 default true 세팅 -> false
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 1 ? Colors.black : Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            Offstage(
              offstage: _selectedIndex != 0,
              child: const FestivalScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: const CommunityScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 2,
              child: const TimeTableScreen(
                festivalKey: "09bf67a4-561c-473a-8927-944bf8c3dc75",
              ),
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: ProfileScreen(key: GlobalKey()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 1 ? Colors.black : Colors.white,
        surfaceTintColor: _selectedIndex == 1 ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colours.borderGrey,
                width: 0.5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10, horizontal: Sizes.size10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                  text: "Festival",
                  icon: FontAwesomeIcons.flag,
                  selectedIcon: FontAwesomeIcons.solidFlag,
                  isSelected: _selectedIndex == 0,
                  selectedIndex: _selectedIndex,
                  onTap: () => _onNavTap(0),
                ),
                NavTab(
                  text: "Community",
                  icon: FontAwesomeIcons.comments,
                  selectedIcon: FontAwesomeIcons.solidComments,
                  isSelected: _selectedIndex == 1,
                  selectedIndex: _selectedIndex,
                  onTap: () => _onNavTap(1),
                ),
                NavTab(
                  text: "Guide",
                  icon: FontAwesomeIcons.calendarCheck,
                  selectedIcon: FontAwesomeIcons.solidCalendarCheck,
                  isSelected: _selectedIndex == 2,
                  selectedIndex: _selectedIndex,
                  onTap: () => _onNavTap(2),
                ),
                NavTab(
                  text: "Profile",
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  isSelected: _selectedIndex == 3,
                  selectedIndex: _selectedIndex,
                  onTap: () => _onNavTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
# IndexedStack
- 현재 선택된 탭만 표시하고, 다른 탭은 비활성화 상태로 유지
- 화면이 새로고침되지 않고 상태가 유지됨
- 화면이 새로고침되도록 하려면 key를 추가하여 각 탭이 고유의 상태를 가지도록 설정할 수 있음
*/