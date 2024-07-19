// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class Test extends SliverPersistentHeaderDelegate {
  final double minExtentVal;
  final double maxExtentVal;
  final bool isCollapsed;

  Test({
    required this.minExtentVal,
    required this.maxExtentVal,
    required this.isCollapsed,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecorations.cardBottomContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isCollapsed) ...[
              Gaps.v20,
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
                  Gaps.h36,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('19', style: TextStyles.highlightText),
                            Text('관람', style: TextStyles.miniText),
                          ],
                        ),
                        Column(
                          children: [
                            Text('3,783', style: TextStyles.highlightText),
                            Text('팔로워', style: TextStyles.miniText),
                          ],
                        ),
                        Column(
                          children: [
                            Text('50', style: TextStyles.highlightText),
                            Text('팔로잉', style: TextStyles.miniText),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gaps.v14,
              Text(
                '펜타포트',
                style: TextStyles.defaultBoldText,
              ),
              Gaps.v3,
              Text(
                '대한민국을 대표하는 글로벌 문화관광축제 2024 인천펜타포트 락 페스티벌!\r\n2일(금)부터 4일(일)까지 3일간, 송도달빛축제공원에서 개최됩니다.',
                style: TextStyles.defaultText,
              ),
            ] else
              const Text(
                'Profile Header',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
          ],
        ),
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
