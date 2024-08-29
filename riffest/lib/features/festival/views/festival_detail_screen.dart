import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/common/widgets/default_btn.dart';
import 'package:riffest/common/widgets/default_icon_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/widgets/submit_btn.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/manage/views/edit_festival_screen.dart';
import 'package:riffest/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class FestivalDetailScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.festivalDetailScreen;
  static const routeName = RoutesName.festivalDetailScreen;

  final String festivalKey;

  const FestivalDetailScreen({
    super.key,
    required this.festivalKey,
  });

  @override
  FestivalDetailScreenState createState() => FestivalDetailScreenState();
}

class FestivalDetailScreenState extends ConsumerState<FestivalDetailScreen> {
  // 스크롤 관련
  late ScrollController _scrollController;
  bool isCollapsed = false; // 축소 상태인지 확인 (todo: 삭제 예정)

  // 포스터 사이즈
  GlobalKey posterBox = GlobalKey();
  double posterWidth = 100;

  // 클릭 이벤트 변수
  bool _bookmark = false;
  double _starRating = 0;

  // 기본정보 더보기
  GlobalKey expandTextBox = GlobalKey();

  @override
  void initState() {
    super.initState();

    /**스크롤 리스너 (todo: 삭제 예정)
     * - 축소 기준 높이를 이용해, Widget 의 display 여부 결정
     * - kToolbarHeight : Appbar 의 높이
     * - _scrollController.offset : 현재 위치 0.0~
     */
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      bool tempCollapsed = _scrollController.offset > (120 - kToolbarHeight);
      if (isCollapsed != tempCollapsed) {
        isCollapsed = tempCollapsed;
      }
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 화면 너비 = 포스터 가로X세로 (1:1 비율임)
      if (posterBox.currentContext != null) {
        final RenderBox renderBox =
            posterBox.currentContext?.findRenderObject() as RenderBox;
        posterWidth = renderBox.size.width;
      }

      _getFestival(); // 초기화
    });
  }

  Future<void> _getFestival() async {
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(widget.festivalKey);
  }

  Future<void> _onRefresh() async {
    _getFestival();
  }

  void _onBookmarkTap() {
    setState(() {
      _bookmark = !_bookmark;
    });
  }

  void _onStartTap(double xPosition, int index) {
    double halfWidth = 40 / 2; // 아이콘 Size 40 의 절반
    double rate = index + (xPosition < halfWidth ? 0.5 : 1);

    setState(() {
      _starRating = rate;
    });
  }

  void _goHomePage() async {
    final url = Uri.parse("https://pentaport.co.kr/Timetable");
    await launchUrl(url);
  }

  // todo: data 에도 LoadingProgressIndicator 한 번 더 사용
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgGrey,
      appBar: AppBar(
        title: Text(ref.watch(festivalProvider).value?.name ?? ""),
        actions: [
          // 수정
          AppbarIconBtn(
            icon: FontAwesomeIcons.pen,
            onPressedFunction: (p0) {
              // 경로 노출 없이 Push
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditFestivalScreen(
                    festivalKey: widget.festivalKey,
                  ),
                ),
              );
            },
          ),
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
              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  displacement: 20, // 화면을 당긴 후 indicator 돌아갈 위치
                  edgeOffset: 20, // 어디에서 부터 시작할 것인지
                  color: Colours.primaryColor,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      // 1. 상단 포스터 및 정보 영역
                      SliverToBoxAdapter(
                        child: SizedBox(
                          key: posterBox,
                          width: double.infinity,
                          height: posterWidth,
                          child: Stack(
                            children: [
                              // 1-1. 포스터 영역
                              Positioned.fill(
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover, // fit 방식
                                  placeholder: "assets/images/placeholder.png",
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
                              Positioned.fill(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.35),
                                  ),
                                ),
                              ),
                              // 1-2. 정보 영역
                              Positioned(
                                left: Sizes.size20,
                                right: Sizes.size20,
                                bottom: Sizes.size28,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      festival.name,
                                      style: TextStyles.highlightTextWhite,
                                    ),
                                    Gaps.v5,
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.locationDot,
                                          size: Sizes.size16,
                                          color: Colors.white,
                                        ),
                                        Gaps.h7,
                                        Text(
                                          festival.location,
                                          style: TextStyles.largeTextWhite,
                                        ),
                                      ],
                                    ),
                                    Gaps.v3,
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.solidClock,
                                          size: Sizes.size16,
                                          color: Colors.white,
                                        ),
                                        Gaps.h7,
                                        Text(
                                          "${getDateString(festival.startDate)} ~ ${getDateString(festival.endDate)}",
                                          style: TextStyles.largeTextWhite,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // 1-3. 북마크 영역
                              Positioned(
                                top: Sizes.size20,
                                right: Sizes.size20,
                                child: DefaultIconBtn(
                                  icon: _bookmark
                                      ? FontAwesomeIcons.solidBookmark
                                      : FontAwesomeIcons.bookmark,
                                  color: Colors.white,
                                  onTapFunction: (p0) => _onBookmarkTap(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 2. Gaps + 평점 영역
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.v12, // 회색 영역
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: DecoratedBox(
                                decoration: BoxDecorations.cardTBContainer,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size80,
                                    vertical: Sizes.size20,
                                  ),
                                  child: Column(
                                    children: [
                                      const Text("나의 평점을 남겨보세요."),
                                      Gaps.v12,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List<Widget>.generate(
                                          5,
                                          (index) {
                                            return GestureDetector(
                                              onTapDown: (details) =>
                                                  _onStartTap(
                                                      details.localPosition.dx,
                                                      index),
                                              child: Icon(
                                                _starRating == index + 0.5
                                                    ? Icons.star_half_rounded
                                                    : Icons.star_rounded,
                                                size: Sizes.size40,
                                                color: _starRating > index
                                                    ? Colours.primaryColor
                                                    : Colours.bgDarkGrey,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 3. Gaps + 태그 영역
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.v12, // 회색 영역
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: DecoratedBox(
                                decoration: BoxDecorations.cardTBContainer,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size20,
                                    vertical: Sizes.size20,
                                  ),
                                  child: Wrap(
                                    runSpacing: 10, // 세로
                                    spacing: 7, // 가로
                                    children: [
                                      for (String item in festival.filter)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size7,
                                            horizontal: Sizes.size16,
                                          ),
                                          decoration: BoxDecorations
                                              .roundButtonDisabled,
                                          child: Text(
                                            "#$item",
                                            style: TextStyles.miniBoldTextGray,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 4. Gaps + 태그 영역
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.v12, // 회색 영역
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: DecoratedBox(
                                decoration: BoxDecorations.cardTBContainer,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size20,
                                    vertical: Sizes.size20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "기본 정보",
                                        style: TextStyles.defaultMenuTitle,
                                      ),
                                      ExpandableText(
                                        key: expandTextBox,
                                        "기본정보".replaceAll("\\n", "\n"),
                                        expandText: '더보기',
                                        collapseText: '접기',
                                        style: TextStyles.defaultText,
                                        linkStyle: TextStyles.defaultTextGray,
                                        maxLines: 2,
                                        onExpandedChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: Sizes.size5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: SubmitBtn(
                  disabled: false,
                  label: "타임테이블",
                  onTapFunction: (p0) {},
                ),
              ),
              Gaps.h14,
              Expanded(
                flex: 1,
                child: SubmitBtn(
                  disabled: false,
                  label: "홈페이지",
                  onTapFunction: (p0) => _goHomePage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
