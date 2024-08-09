import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riffest/constants/decorations.dart';
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
    int stageCount = festival.stages.length; // 스테이지 개수

    return DecoratedBox(
      decoration: BoxDecorations.cardTBContainer,
      child: Column(
        children: [
          SizedBox(
            height: Sizes.size44,
            child: TabBar(
              // indicator : 하단에 나타나는 선택 여부 확인을 위한 선
              indicatorWeight: 3,
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
          ),
          SizedBox(
            height: Sizes.size36,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(int.parse(festival.subColor)),
                border: Border(
                  bottom: BorderSide(
                    color: Colours.borderGrey,
                    width: 0.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 1)),
                ],
              ),
              child: Row(
                children: [
                  // 시간 영역
                  const Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                  // 스테이지 영역
                  for (int i in Iterable.generate(stageCount))
                    Expanded(
                      flex: (9 / stageCount).floor(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              festival.stages[i],
                              style: TextStyles.miniBoldText,
                            ),
                          ],
                        ),
                      ),
                    ),
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

String getDayText(String startDate, int idx) {
  final date = DateTime.parse(startDate).add(Duration(days: idx));
  return DateFormat('d일 (E)', 'ko').format(date);
}
