// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/widgets/time_table_persist_header.dart';

import '../widgets/time_table_stage.dart';

class TimeTableScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.timeTableScreen;
  static const routeName = RoutesName.timeTableScreen;

  final String festivalKey;

  const TimeTableScreen({
    super.key,
    required this.festivalKey,
  });

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
  bool _isBookmarkExist = false; // 북마크 없으면 목록 보여주지 않음

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
      _getBookmarkFestivals();
      _getTimetables(widget.festivalKey); // 초기화
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 북마크한 페스티벌 조회
  Future<void> _getBookmarkFestivals() async {
    await ref.read(festivalsProvider.notifier).getBookmarkFestivals();
    List<FestivalModel>? festivals = ref.read(festivalsProvider).value;
    if (festivals != null && festivals.isNotEmpty) {
      _isBookmarkExist = true;
    } else {
      _isBookmarkExist = false;
    }
    setState(() {});
  }

  // 타임테이블 정보 조회
  Future<void> _getTimetables(String festKey) async {
    await ref.read(festivalProvider.notifier).getFestivalTimeTables(festKey);
  }

  // 타이틀 클릭
  void _toggleTitle() async {
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
          onTap: _toggleTitle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // 뒤로가기 버튼이 있어도 가운데 정렬
            children: [
              Text(ref.watch(festivalProvider).value?.name ?? ""),
              if (_isBookmarkExist) Gaps.h6,
              // turns 속성을 이용해 Rotation 효과
              if (_isBookmarkExist)
                RotationTransition(
                  turns: _arrowAnimation,
                  child: const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: Sizes.size14,
                  ),
                ),
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
                  child: Stack(
                    children: [
                      DefaultTabController(
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
                              for (int i
                                  in Iterable.generate(festival.diffDays))
                                TimeTableStage(
                                  festival: festival,
                                  days: i,
                                  onRefresh: () async {
                                    await _getBookmarkFestivals();
                                    await _getTimetables(festival.key);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (_isBookmarkExist && _showBarrier)
                        // color 속성을 이용해 ModalBarrier 효과 (모든 이벤트를 무시하도록 설정)
                        AnimatedModalBarrier(
                          color: _barrierAnimation,
                          // onDismiss 시, 패널이 올라가고 ModalBarrier 가 꺼지는 등 효과를 주기 위해 true 로 설정
                          dismissible: true,
                          onDismiss: _toggleTitle,
                        ),
                      // 슬라이드 되어 내려오는 페스티벌 목록 영역
                      // todo: 위로 올라갈 때 상단바에 보임
                      SlideTransition(
                        position: _panelAnimation,
                        child: Container(
                          decoration: BoxDecorations.whiteRadiusContainer,
                          child: ref.watch(festivalsProvider).when(
                                loading: () => const LoadingProgressIndicator(),
                                error: (error, stackTrace) => Center(
                                  child: Text(
                                    error.toString(),
                                  ),
                                ),
                                data: (data) {
                                  // print(data.length);
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (FestivalModel festival in data)
                                        GestureDetector(
                                          onTap: () {
                                            _getTimetables(festival.key);
                                            _toggleTitle();
                                          },
                                          child: ListTile(
                                            title: Text(
                                              festival.name,
                                              style: TextStyles.appbarSubTitle,
                                            ),
                                          ),
                                        ),
                                      Gaps.v10,
                                    ],
                                  );
                                },
                              ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
    );
  }
}
