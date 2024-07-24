import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/features/community/views/community_screen.dart';
import 'package:riffest/features/festival/views/festival_screen.dart';
import 'package:riffest/features/main/widgets/nav_tab.dart';
import 'package:riffest/features/user/views/profile_screen.dart';

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
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: SafeArea(
        child: Stack(
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
              child: const CommunityScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: const ProfileScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        surfaceTintColor: _selectedIndex == 0 ? Colors.black : Colors.white,
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
