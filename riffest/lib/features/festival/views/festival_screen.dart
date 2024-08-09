import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

import '../widgets/festival_theme_list.dart';

class FestivalScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.festivalScreen;
  static const routeName = RoutesName.festivalScreen;

  const FestivalScreen({super.key});

  @override
  FestivalScreenState createState() => FestivalScreenState();
}

class FestivalScreenState extends ConsumerState<FestivalScreen> {
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: CustomScrollView(
              slivers: <Widget>[
                // 상단 - 로고, 검색 버튼
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gaps.v16,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "RiFFest",
                            style: TextStyles.bigTitlePrimary,
                          ),
                          NoAppbarIconBtn(
                            icon: FontAwesomeIcons.magnifyingGlass,
                            onTapFunction: (p0) {},
                          )
                        ],
                      ),
                      Gaps.v16,
                    ],
                  ),
                ),
                // 테마별 horizontal 목록 * itemCount
                SliverList.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return FestivalThemeList(
                      themeName: ["2024 평점 Top 10", "2024 기대작"][index % 2],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
