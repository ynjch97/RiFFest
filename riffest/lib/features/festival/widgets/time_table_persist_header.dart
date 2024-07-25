import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';

class TimeTablePersistHeader extends SliverPersistentHeaderDelegate {
  final double minExtentVal;
  final double maxExtentVal;
  final FestivalModel festival;

  TimeTablePersistHeader({
    required this.minExtentVal,
    required this.maxExtentVal,
    required this.festival,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecorations.cardTBContainer,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: TabBar(
              // indicator : 하단에 나타나는 선택 여부 확인을 위한 선
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colours.borderBlack,
              labelPadding: const EdgeInsets.symmetric(vertical: Sizes.size10),
              labelColor: Colours.borderBlack,
              tabs: [
                // 기간 만큼 탭바 그리기
                for (int idx in Iterable.generate(festival.diffDays))
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size20),
                    child: Text(
                      getDayText(festival.startDate, idx),
                      style: TextStyles.defaultText,
                    ),
                  )
              ],
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

String getDayText(String startDate, int idx) {
  final date = DateTime.parse(startDate).add(Duration(days: idx));
  return DateFormat('d일 (E)', 'ko').format(date);
}
