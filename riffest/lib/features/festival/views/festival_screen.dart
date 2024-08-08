import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/list_icon_btn.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

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
                    return Column(
                      children: [
                        // 테마 제목
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "2024 기대작",
                              style: TextStyles.highlightText,
                            ),
                            ListIconBtn(
                              icon: FontAwesomeIcons.angleRight,
                              onTapFunction: (p0) {},
                            ),
                          ],
                        ),
                        Gaps.v7,
                        // 테마별 horizontal 목록
                        SizedBox(
                          height: 205,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10, // 수평 스크롤 아이템 개수
                            itemBuilder: (context, index) {
                              // 포스터, 페스티벌명, 기간 정보
                              return SizedBox(
                                width: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 110,
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          fit:
                                              BoxFit.cover, // 부모 요소에 어떻게 fit 할지
                                          placeholder:
                                              "assets/images/image2.gif",
                                          image:
                                              "https://ticketimage.interpark.com/Play/image/large/24/24009132_p.gif",
                                        ),
                                      ),
                                    ),
                                    Gaps.v3,
                                    Text(
                                      "2024 펜타포트 락페스티벌 Pentaport Rock Festival",
                                      style: TextStyles.defaultText,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Gaps.v2,
                                    Text(
                                      "24.08.02 ~ 24.08.04",
                                      style: TextStyles.tinyText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Gaps.h12;
                            },
                          ),
                        ),
                      ],
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
