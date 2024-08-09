import 'package:flutter/material.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';
import 'package:riffest/utils.dart';

import 'artist_block.dart';

// 참고
// https://namudongs.tistory.com/15
// https://velog.io/@reverstandard9/%ED%94%8C%EB%9F%AC%ED%84%B0%EB%A1%9C-%EC%97%90%EB%B8%8C%EB%A6%AC-%ED%83%80%EC%9E%84-%EC%8B%9C%EA%B0%84%ED%91%9C-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0
class TimeTableStage extends StatefulWidget {
  final FestivalModel festival;
  final int days; // n일차
  final Future<void> Function() onRefresh;

  const TimeTableStage({
    super.key,
    required this.festival,
    required this.days,
    required this.onRefresh,
  });

  @override
  State<TimeTableStage> createState() => _TimeTableStageState();
}

class _TimeTableStageState extends State<TimeTableStage> {
  int startHour = 0, endHour = 0;

  @override
  Widget build(BuildContext context) {
    final timeTables = widget.festival.timeTables[widget.days]; // n일차 타임테이블

    if (timeTables.isNotEmpty) {
      DateTime startTime = DateTime.parse(
          "${widget.festival.startDate} ${timeTables.first.startTime}");
      DateTime endTime = DateTime.parse(
          "${widget.festival.startDate} ${timeTables.last.endTime}");

      // n일차의 시작 시간
      startHour = startTime.hour;
      // n일차의 종료 시간 (시작일과 날짜가 다르면 +24시, 정각 종료가 아니면 +1)
      endHour =
          ((startTime.day == endTime.day) ? endTime.hour : endTime.hour + 24) +
              (endTime.minute == 0 ? 0 : 1);
    }

    int boxCount = endHour - startHour; // 1 hour 개수 (종료 시간 - 시작 시간)
    if (boxCount < 3) boxCount = 3; // 최소 개수 지정
    double perHeight = 1.4; // 1 min 높이
    double boxHeight = 60 * perHeight; // 1 hour 박스 높이

    int stageCount = widget.festival.stages.length; // 스테이지 개수
    bool isDark =
        isDarkColor(widget.festival.mainColor); // 텍스트 색상 지정 (Black/White)

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      displacement: 20, // 화면을 당긴 후 indicator 돌아갈 위치
      edgeOffset: 20, // 어디에서 부터 시작할 것인지
      color: Colours.primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 시간 * Column 생성
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: boxHeight / 2), // 여백
                      ...List.generate(
                        boxCount - 1,
                        (idx) {
                          return SizedBox(
                            height: boxHeight,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${startHour + idx + 1}:00 ", // 시간 표시
                                style: TextStyles.miniBoldText,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: boxHeight / 2), // 여백
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 스테이지 * Column 생성
          for (int i in Iterable.generate(stageCount))
            Expanded(
              flex: (9 / stageCount).floor(),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        // 타임테이블 실선
                        Column(
                          children: [
                            ...List.generate(
                              boxCount * 2, // 30분 단위
                              (idx) {
                                return FractionallySizedBox(
                                  widthFactor: 1,
                                  child: SizedBox(
                                    height: boxHeight / 2, // 30분 단위
                                    child: DecoratedBox(
                                      decoration: (boxCount * 2 == idx + 1)
                                          ? BoxDecorations.whiteContainer
                                          : idx % 2 == 0
                                              ? BoxDecorations.bottom30Container
                                              : BoxDecorations
                                                  .bottom60Container,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        // 아티스트 타임테이블
                        for (TimeTableModel item in timeTables) // n일차 타임테이블
                          if (item.stage == widget.festival.stages[i])
                            Positioned(
                              top: calcMinDiff(
                                          widget.festival.startDate,
                                          "$startHour:00",
                                          widget.festival.startDate,
                                          item.startTime)
                                      .toDouble() *
                                  perHeight,
                              left: 0,
                              right: 0,
                              child: ArtistBlock(
                                widget: widget,
                                timeTable: item,
                                perHeight: perHeight,
                                isDark: isDark,
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
