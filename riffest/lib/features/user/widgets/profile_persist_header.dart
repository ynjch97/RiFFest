// ignore_for_file: slash_for_doc_comments

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class ProfilePersistHeader extends SliverPersistentHeaderDelegate {
  final double minExtentVal;
  final double maxExtentVal;
  final bool isCollapsed; // 스크롤로 인한 확장/축소
  final Function(bool) updateExtent; // 더보기 클릭 시 영역 확장

  ProfilePersistHeader({
    required this.minExtentVal,
    required this.maxExtentVal,
    required this.isCollapsed,
    required this.updateExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecorations.cardBottomContainer,
      child: Stack(
        children: [
          // 1. 프로필 사진, 닉네임, 바이오
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
            child: Column(
              children: [
                if (!isCollapsed) ...[
                  // 1-1. 확장
                  Gaps.v16, // 확장 시 상단 여백
                  Row(
                    children: [
                      ClipOval(
                        clipBehavior: Clip.hardEdge,
                        child: CircleAvatar(
                          radius: Sizes.size48,
                          foregroundImage:
                              const AssetImage("assets/images/image2.gif"),
                          child: Text(
                            "pentaport",
                            style: TextStyles.miniText,
                          ),
                        ),
                      ),
                      Gaps.h20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "펜타포트",
                                style: TextStyles.highlightText,
                              ),
                              Gaps.h8,
                              const FaIcon(
                                FontAwesomeIcons.pencil,
                                size: Sizes.size12,
                              )
                            ],
                          ),
                          Gaps.v5,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("팔로워", style: TextStyles.defaultTextGray),
                              Gaps.h3,
                              Text('3,783',
                                  style: TextStyles.defaultBoldTextGray),
                              Gaps.h3,
                              Text("팔로잉", style: TextStyles.defaultTextGray),
                              Gaps.h3,
                              Text('13', style: TextStyles.defaultBoldTextGray),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gaps.v14,
                  ExpandableText(
                    '글로벌 문화관광축제 2024 인천펜타포트 락 페스티벌! 🧡\r\n2일(금)부터 4일(일)까지 3일간, 송도달빛축제공원에서 개최됩니다.\r\n2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌 2024 펜타포트 락페스티벌',
                    expandText: '더보기',
                    collapseText: '접기',
                    style: TextStyles.defaultText,
                    linkStyle: TextStyles.defaultTextGray,
                    maxLines: 2,
                    onExpandedChanged: (value) {
                      updateExtent(value);
                    },
                  ),
                  Gaps.v16,
                ] else
                  // 1-2. 축소
                  const Text(
                    'Profile Header',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
              ],
            ),
          ),
          // 2. 관람, 평가, 코멘트
          if (!isCollapsed)
            Positioned(
              bottom: 0.5,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Divider(
                      color: Colours.borderGrey, // 구분선 색상
                      thickness: 0.5, // 구분선 두께
                      indent: 0, // 시작 지점 여백
                      endIndent: 0, // 끝 지점 여백
                      height: 0.5,
                    ),
                    Gaps.v16,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size56),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('49', style: TextStyles.highlightTextGray),
                              Text('관람', style: TextStyles.miniText),
                            ],
                          ),
                          Column(
                            children: [
                              Text('33', style: TextStyles.highlightTextGray),
                              Text('평가', style: TextStyles.miniText),
                            ],
                          ),
                          Column(
                            children: [
                              Text('12', style: TextStyles.highlightTextGray),
                              Text('코멘트', style: TextStyles.miniText),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gaps.v16, // 확장 시 하단 여백
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxExtentVal;

  @override
  double get minExtent => minExtentVal;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}
