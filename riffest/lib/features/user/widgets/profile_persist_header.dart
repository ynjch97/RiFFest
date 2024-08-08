// ignore_for_file: slash_for_doc_comments

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/user/models/user_model.dart';

class ProfilePersistHeader extends SliverPersistentHeaderDelegate {
  final UserModel user;
  final double minExtentVal;
  final double maxExtentVal;
  final bool isCollapsed; // 스크롤로 인한 확장/축소
  final Function(bool) updateExtent; // 더보기 클릭 시 영역 확장
  final GlobalKey eTextKey; // 확장 영역 계산용

  ProfilePersistHeader({
    required this.user,
    required this.minExtentVal,
    required this.maxExtentVal,
    required this.isCollapsed,
    required this.updateExtent,
    required this.eTextKey,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecorations.cardTBContainer,
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
                            user.nickname,
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
                                user.nickname,
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
                    key: eTextKey,
                    user.bio.replaceAll("\\n", "\n"),
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
                ]
              ],
            ),
          ),
          // 2. 관람, 평가, 코멘트
          Positioned(
            bottom: 0.5,
            left: 0,
            right: 0,
            child: DecoratedBox(
              decoration: isCollapsed
                  ? const BoxDecoration(color: Colors.white)
                  : BoxDecorations.cardTBContainer,
              child: Column(
                children: [
                  if (!isCollapsed)
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
