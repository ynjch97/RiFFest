import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/colours.dart';
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

class TimeTableScreenState extends ConsumerState<TimeTableScreen> {
  String temp = "1";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTimeTable();
    });
  }

  void _initTimeTable() async {
    await ref.read(festivalProvider.notifier).getTimeTables(temp);
  }

  Future<void> _refreshTimeTable() async {
    temp = temp == "1" ? "2" : "1";
    await ref.read(festivalProvider.notifier).getTimeTables(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(festivalProvider).value?.name ?? ""),
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
