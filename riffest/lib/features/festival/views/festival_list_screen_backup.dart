import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/default_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';

class FestivalListScreenBckUp extends ConsumerStatefulWidget {
  // static const routeURL = Routes.festivalListScreenBckUp;
  // static const routeName = RoutesName.festivalListScreenBckUp;

  final FestivalThemeModel theme;

  const FestivalListScreenBckUp({
    super.key,
    required this.theme,
  });

  @override
  FestivalListScreenBckUpState createState() => FestivalListScreenBckUpState();
}

class FestivalListScreenBckUpState
    extends ConsumerState<FestivalListScreenBckUp> {
  // The instance member 'ticketHeight' can't be accessed in an initializer. -> late 를 붙임
  double ticketHeight = 120;
  late double posterWidth = (ticketHeight - Sizes.size20) / 15 * 11;
  late double posterHeight = ticketHeight - Sizes.size20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getFestivals(); // 초기화
    });

    print("theme ::: ${widget.theme.themeName}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  // Padding > horizontal: Sizes.size20 > 목록은 right 만 적용하는 것으로 변경
                  child: CustomScrollView(
                    slivers: <Widget>[
                      // 상단 - 로고, 검색 버튼
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size20),
                          child: Column(
                            children: [
                              Gaps.v16,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.theme.themeName,
                                    style: TextStyles.bigTitle,
                                  ),
                                  DefaultIconBtn(
                                    icon: FontAwesomeIcons.magnifyingGlass,
                                    color: Colours.textBlack,
                                    onTapFunction: (p0) {},
                                  )
                                ],
                              ),
                              Gaps.v16,
                            ],
                          ),
                        ),
                      ),
                      // 목록
                      SliverList.separated(
                        itemCount: festivals.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: Sizes.size20),
                            child: Stack(
                              children: [
                                // 티켓
                                Container(
                                  height: ticketHeight,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.4), // 그림자 색상
                                        spreadRadius: 0.2, // 그림자의 확산 반경
                                        blurRadius: 5, // 그림자의 흐림 정도
                                        offset: const Offset(
                                            4, 2), // 그림자의 위치 (x, y)
                                      ),
                                    ],
                                  ),
                                  child: Transform.translate(
                                    offset: const Offset(5, 0), // 이미지의 x축을 이동
                                    child: Image.asset(
                                      "assets/images/ticket.png",
                                      fit: BoxFit
                                          .fill, // 이미지 비율 유지하지 않고 공간에 맞게 늘림
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // top: ticketHeight, posterHeight 에 따라 달라짐 / left: Transform.translate Offset 에 따라 달라짐
                                  top: Sizes.size10,
                                  left: Sizes.size14,
                                  child: SizedBox(
                                    height: posterHeight,
                                    width: posterWidth,
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover, // fit 방식
                                      placeholder:
                                          "assets/images/placeholder.png",
                                      image:
                                          "https://firebasestorage.googleapis.com/v0/b/riffest-43f8d.appspot.com/o/festival%2F${festivals[index].key}?alt=media",
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
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 25,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
