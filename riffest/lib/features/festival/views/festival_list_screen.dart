import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/views/festival_detail_screen.dart';
import 'package:riffest/utils.dart';

class FestivalListScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.festivalListScreen;
  static const routeName = RoutesName.festivalListScreen;

  final FestivalThemeModel theme;

  const FestivalListScreen({
    super.key,
    required this.theme,
  });

  @override
  FestivalListScreenState createState() => FestivalListScreenState();
}

class FestivalListScreenState extends ConsumerState<FestivalListScreen> {
  double posterStndrd = 70; // 포스터 사이즈

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getFestivals(); // 초기화
    });

    print("FestivalListScreen ::: ${widget.theme.themeName}");
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

  Future<void> _onRefresh() async {
    _getFestivals();
  }

  void _onFestivalTap(BuildContext context, String festivalKey) {
    context.pushNamed(
      FestivalDetailScreen.routeName,
      params: {"festivalKey": festivalKey},
    );
  }

  // todo: 스크롤 내리면 10건씩 더보기 (controller, limit 수정)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.theme.themeName),
      ),
      body: ref.watch(festivalsProviderFamily(widget.theme)).when(
            loading: () => const LoadingProgressIndicator(),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            data: (List<FestivalModel> festivals) {
              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  displacement: 20, // 화면을 당긴 후 indicator 돌아갈 위치
                  edgeOffset: 20, // 어디에서 부터 시작할 것인지
                  color: Colours.primaryColor,
                  child: ListView.separated(
                    // controller: ,
                    itemCount: festivals.length,
                    itemBuilder: (context, index) {
                      // 페스티벌 정보
                      FestivalModel festival = festivals[index];

                      // 리스트 타일 카드
                      return GestureDetector(
                        onTap: () => _onFestivalTap(context, festival.key),
                        child: DecoratedBox(
                          decoration: BoxDecorations.whiteContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.size10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // 포스터 비율은 1.1 * 1.5
                                  height: posterStndrd * 1.5,
                                  width: posterStndrd * 1.1,
                                  child: ClipRect(
                                    clipBehavior: Clip.hardEdge,
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover, // fit 방식
                                      placeholder:
                                          "assets/images/placeholder.png",
                                      image:
                                          "https://firebasestorage.googleapis.com/v0/b/riffest-43f8d.appspot.com/o/festival%2F${festival.key}?alt=media",
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        // 이미지 로드 실패 시 placeholder 이미지로 대체
                                        return Image.asset(
                                          "assets/images/placeholder.png",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Gaps.h12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      festival.name,
                                      style: TextStyles.largeText,
                                    ),
                                    Text(
                                      "${getDateString(festival.startDate)} ~ ${getDateString(festival.endDate)}",
                                      style: TextStyles.miniText,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colours.borderGrey, // 구분선 색상
                        thickness: 0.5, // 구분선 두께
                        indent: 0, // 시작 지점 여백
                        endIndent: 0, // 끝 지점 여백
                        height: 0.5,
                      );
                    },
                  ),
                ),
              );
            },
          ),
    );
  }
}
