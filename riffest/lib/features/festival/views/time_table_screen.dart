// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/widgets/time_table_persist_header.dart';

import '../widgets/time_table_stage.dart';

class TimeTableScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.timeTableScreen;
  static const routeName = RoutesName.timeTableScreen;

  const TimeTableScreen({super.key});

  @override
  TimeTableScreenState createState() => TimeTableScreenState();
}

/**한 개의 AnimationController 사용 -> SingleTickerProviderStateMixin
 * 다중 AnimationController 사용 -> TickerProviderStateMixin
 * SingleTickerProviderStateMixin : Ticker 를 가져다주고, widget tree 에 없는 widget 때문에 리소스 낭비하는 것을 방지
 * _animation 여러 개를 하나의 _animationController 에 연결하기만 하면 사용 가능한 방법 (추천)
 */
class TimeTableScreenState extends ConsumerState<TimeTableScreen>
    with SingleTickerProviderStateMixin {
  final List<String> temp = [
    "6af0739f-8360-4cc2-8714-78749a279265",
    "09bf67a4-561c-473a-8927-944bf8c3dc75",
  ];
  int tempVal = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTimeTable();
    });
  }

  void _initTimeTable() async {
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(temp[tempVal]);

    await ref.read(festivalsProvider.notifier).getFestivals();
  }

  Future<void> _refreshTimeTable() async {
    tempVal = tempVal == 0 ? 1 : 0;
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(temp[tempVal]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // 뒤로가기 버튼이 있어도 가운데 정렬
          children: [
            Text(ref.watch(festivalProvider).value?.name ?? ""),
            Gaps.h6,
            // turns 속성을 이용해 Rotation 효과
            const FaIcon(
              FontAwesomeIcons.chevronDown,
              size: Sizes.size14,
            )
          ],
        ),
        actions: [
          AppbarIconBtn(
            icon: FontAwesomeIcons.ellipsisVertical,
            onPressedFunction: (p0) {},
          )
        ],
      ),
      body: ref.watch(festivalProvider).when(
            loading: () => const LoadingProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            data: (FestivalModel festival) {
              // getTimeTables() 에 따른 로딩 중 처리
              if (festival.timeTables.isEmpty) {
                return const LoadingProgressIndicator();
              } else {
                return SafeArea(
                  child: DefaultTabController(
                    length: festival.diffDays, // 1. 기간 만큼 탭 개수 지정
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverPersistentHeader(
                            // 2. 기간 만큼 탭바 그리기
                            delegate: TimeTablePersistHeader(
                              maxExtentVal: Sizes.size80,
                              minExtentVal: Sizes.size80,
                              festival: festival,
                            ),
                            pinned: true,
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: [
                          // 3. 기간 만큼 탭 뷰 생성
                          for (int i in Iterable.generate(festival.diffDays))
                            TimeTableStage(
                              festival: festival,
                              days: i,
                              onRefresh: _refreshTimeTable,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
    );
  }
}
