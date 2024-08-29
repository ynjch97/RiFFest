// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/widgets/time_table_persist_header.dart';

import '../widgets/time_table_stage.dart';

/**2024.07.31
 * Animation 을 추가하면서, 
 * ref.watch(festivalProvider).when( > data > SafeArea 와 DefaultTabController 사이에 Stack 을 추가하게 되어
 * 직전 상태로 백업 파일 생성
 */

class TimeTableScreenBckUp extends ConsumerStatefulWidget {
  const TimeTableScreenBckUp({super.key});

  @override
  TimeTableScreenBckUpState createState() => TimeTableScreenBckUpState();
}

/**한 개의 AnimationController 사용 -> SingleTickerProviderStateMixin
 * 다중 AnimationController 사용 -> TickerProviderStateMixin
 * SingleTickerProviderStateMixin : Ticker 를 가져다주고, widget tree 에 없는 widget 때문에 리소스 낭비하는 것을 방지
 * _animation 여러 개를 하나의 _animationController 에 연결하기만 하면 사용 가능한 방법 (추천)
 */
class TimeTableScreenBckUpState extends ConsumerState<TimeTableScreenBckUp>
    with SingleTickerProviderStateMixin {
  final List<String> temp = [
    "6af0739f-8360-4cc2-8714-78749a279265",
    "09bf67a4-561c-473a-8927-944bf8c3dc75",
  ];
  int tempVal = 0;

  /* -------------------------------- Animation Start -------------------------------- */

  // 오버레이(overlay) : 패널 뒤에 있는 것 => 이 부분을 어둡게 만들기 위해 변수 선언
  bool _showBarrier = false;

  // this 를 참조하려면, late 선언 후 initState() 에서 지정하거나, late 선언과 함께 사용해야 함
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  /* -------------------------------- Animation End -------------------------------- */

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTimeTable();
    });
  }

  // 초기화
  void _initTimeTable() async {
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(temp[tempVal]);

    // await ref.read(festivalsProvider.notifier).getFestivals();
  }

  // 끌어당겨 새로고침
  Future<void> _refreshTimeTable() async {
    tempVal = tempVal == 0 ? 1 : 0;
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(temp[tempVal]);
  }

  // 타이틀 클릭
  void _onTitleTap() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      // 사라질 때는 애니메이션 효과 후 사라져야 하기 때문에, setState 로 인해 바로 사라지는 것을 방지 => await
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // 뒤로가기 버튼이 있어도 가운데 정렬
            children: [
              Text(ref.watch(festivalProvider).value?.name ?? ""),
              Gaps.h6,
              // turns 속성을 이용해 Rotation 효과
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
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
