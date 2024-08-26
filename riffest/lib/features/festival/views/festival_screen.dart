import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';

import '../widgets/festival_theme_list.dart';

class FestivalScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.festivalScreen;
  static const routeName = RoutesName.festivalScreen;

  const FestivalScreen({super.key});

  @override
  FestivalScreenState createState() => FestivalScreenState();
}

class FestivalScreenState extends ConsumerState<FestivalScreen> {
  List<FestivalThemeModel> themes = festivalThemesTest(); // horizontal 목록 테마

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _onRefresh() async {
    int randVal = Random().nextInt(5);
    setState(() {
      themes = festivalThemes(randVal, randVal + 4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 20, // 화면을 당긴 후 indicator 돌아갈 위치
            edgeOffset: 20, // 어디에서 부터 시작할 것인지
            color: Colours.primaryColor,
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
                              style: TextStyles.bigLogoPrimary,
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
                    itemCount: themes.length,
                    itemBuilder: (context, index) {
                      return FestivalThemeList(
                        theme: themes[index],
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
      ),
    );
  }
}
