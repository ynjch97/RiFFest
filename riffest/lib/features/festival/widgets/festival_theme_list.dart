import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/common/widgets/list_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/views/festival_detail_screen.dart';
import 'package:riffest/features/festival/views/festival_list_screen.dart';

import 'festival_poster_info.dart';

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

  /* **************************************************************** */

  Future<void> _getFestivals() async {
    await ref
        .read(festivalsProviderFamily(widget.theme).notifier)
        .getThemeFestivals();
  }

  void _onFestivalListTap(FestivalThemeModel theme) {
    context.pushNamed(
      FestivalListScreen.routeName,
      params: {"themeKey": theme.themeKey},
      extra: theme,
    );
  }

  void _onFestivalTap(BuildContext context, String festivalKey) {
    context.pushNamed(
      FestivalDetailScreen.routeName,
      params: {"festivalKey": festivalKey},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 테마 제목
        GestureDetector(
          onTap: () => _onFestivalListTap(widget.theme),
          child: Row(
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
        ),
        Gaps.v7,
        // 테마별 horizontal 목록 => festivalsProvider
        ref.watch(festivalsProviderFamily(widget.theme)).when(
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
                        festival: festival,
                        theme: widget.theme,
                        idx: index,
                        onTapFunction: (context) =>
                            _onFestivalTap(context, festival.key),
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


/*
1. 하나의 festivalsProvider 로 여러 개 목록 생성할 때 문제점
- FestivalScreen > SliverList.separated > itemBuilder > FestivalThemeList
- 모든 FestivalThemeList 가 똑같은 조건으로 보여지게 됨

2. 해결방법
- 상태를 관리하면서 각 위젯이 서로 다른 데이터를 가져와야 한다면 Provider를 분리하거나, family를 사용해 각 조건에 맞는 상태를 관리하도록 설정
- 상태 관리가 필요 없고 단순히 데이터를 가져와야 한다면 Future<List<FestivalModel>>를 반환하는 형태로 구현

3. Provider를 분리하거나, family를 사용
- 여러 개의 FestivalThemeList가 각자 다른 데이터를 관리하려면 각 FestivalThemeList 위젯이 다른 Provider를 사용하도록 설정할 수 있습니다. 
- 예를 들어, Provider에 조건을 전달해서 별도의 인스턴스를 생성하는 방법이 있습니다.

final festivalsProviderFamily = StateNotifierProvider.family<
    FestivalsNotifier, AsyncValue<List<FestivalModel>>, FestivalThemeModel>(
  (ref, theme) => FestivalsNotifier(theme),
);

4. Future<List<FestivalModel>>를 반환하는 형태
- 만약 상태를 관리하지 않고, 단순히 데이터를 가져오는 역할을 수행하고 싶다면, Future<List<FestivalModel>> 형식으로 반환하는 함수로 만들 수 있습니다.
- 이 방법을 사용하면 상태 관리의 복잡성을 줄이고, 함수 호출 시마다 새로운 데이터를 반환받을 수 있습니다.

FutureBuilder<List<FestivalModel>>(
  future: ref.read(festivalsProviderFamily(widget.theme)).getThemeFestivals(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingProgressIndicator();
    } else if (snapshot.hasError) {
      return Center(
        child: Text(snapshot.error.toString()),
      );
    } else if (snapshot.hasData) {
      final festivals = snapshot.data!;
      return SizedBox(
        height: 210,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: festivals.length,
          itemBuilder: (context, index) {
            FestivalModel festival = festivals[index];
            return FestivalPosterInfo(
              festivalName: festival.name,
              startDate: DateFormat('yy.MM.dd')
                  .format(DateTime.parse(festival.startDate)),
              endDate: DateFormat('yy.MM.dd')
                  .format(DateTime.parse(festival.endDate)),
            );
          },
          separatorBuilder: (context, index) {
            return Gaps.h12;
          },
        ),
      );
    } else {
      return const Text("No Data");
    }
  },
)
*/