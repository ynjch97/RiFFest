import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:riffest/common/widgets/list_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_filter_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';

import 'festival_poster_info.dart';

// todo : festivalsProvider 하나를 같이 공유해서 결과가 동일하게 나오는 문제 발생 (검색 필터링)
class FestivalThemeList extends ConsumerStatefulWidget {
  final FestivalThemeModel theme;

  const FestivalThemeList({
    super.key,
    required this.theme,
  });

  @override
  FestivalThemeListState createState() => FestivalThemeListState();
}

class FestivalThemeListState extends ConsumerState<FestivalThemeList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getFestivals(); // 초기화
    });
  }

  @override
  void didUpdateWidget(covariant FestivalThemeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      // 위젯 트리 구축 후 상태 변경
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _getFestivals();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getFestivals() async {
    await ref.read(festivalsProvider.notifier).getThemeFestivals(widget.theme);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 테마 제목
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.theme.themeName,
              style: TextStyles.highlightText,
            ),
            ListIconBtn(
              icon: FontAwesomeIcons.angleRight,
              onTapFunction: (p0) {},
            ),
          ],
        ),
        Gaps.v7,
        // 테마별 horizontal 목록 => festivalsProvider
        ref.watch(festivalsProvider).when(
              loading: () => const LoadingProgressIndicator(),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
              data: (List<FestivalModel> festivals) {
                print("_getFestivals length in screen : ${festivals.length}");
                return SizedBox(
                  height: 210,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: festivals.length, // 수평 스크롤 아이템 개수
                    itemBuilder: (context, index) {
                      FestivalModel festival = festivals[index];
                      // 포스터, 페스티벌명, 기간 정보
                      return FestivalPosterInfo(
                        festivalName: festival.name,
                        startDate: DateFormat('yy.MM.dd')
                            .format(DateTime.parse(festival.startDate)),
                        endDate: DateFormat('yy.MM.dd')
                            .format(DateTime.parse(festival.endDate)),
                        imageLink: [
                          "https://ticketimage.interpark.com/Play/image/large/24/24004114_p.gif",
                          "https://ticketimage.interpark.com/Play/image/large/24/24009552_p.gif",
                          "https://ticketimage.interpark.com/Play/image/large/24/24005722_p.gif"
                        ][index % 3],
                        dDay: 4,
                        rating: 13,
                        starRating: 3.5,
                        onTapFunction: (p0) {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.h12;
                    },
                  ),
                );
              },
            ),
      ],
    );
  }
}
