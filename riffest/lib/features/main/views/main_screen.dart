import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';

import '../../community/views/community_screen.dart';
import '../../festival/views/festival_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../widgets/nav_tab.dart';

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
      backgroundColor: Colours.bgGrey,
      body: Stack(
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
            offstage: _selectedIndex != 4,
            child: const ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        surfaceTintColor: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Festival",
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.houseChimney,
                isSelected: _selectedIndex == 0,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(0),
              ),
              NavTab(
                text: "Community",
                icon: FontAwesomeIcons.users,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 1,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(1),
              ),
              NavTab(
                text: "Profile",
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 2,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
