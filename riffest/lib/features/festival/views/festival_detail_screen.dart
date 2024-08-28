import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/common/widgets/default_btn.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/widgets/festival_persist_header.dart';
import 'package:riffest/features/manage/views/edit_festival_screen.dart';

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
  late ScrollController _scrollController;

  GlobalKey posterBox = GlobalKey();
  double posterWidth = 100;

  @override
  void initState() {
    super.initState();

    /**스크롤 리스너
     * - 축소 기준 높이를 이용해, Widget 의 display 여부 결정
     * - kToolbarHeight : Appbar 의 높이
     * - _scrollController.offset : 현재 위치 0.0~
     */
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("posterWidth ::::::::: $posterWidth");
      // 포스터 높이 측정
      final RenderBox renderBox =
          posterBox.currentContext?.findRenderObject() as RenderBox;
      posterWidth = renderBox.size.width;
      print("renderBox posterWidth ::::::::: $posterWidth");

      _getFestival(); // 초기화
    });
  }

  Future<void> _getFestival() async {
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(widget.festivalKey);
  }

  Future<void> _onRefresh() async {}

  // todo: data 에도 LoadingProgressIndicator 한 번 더 사용
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("페스티벌명"),
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
                      SliverPersistentHeader(
                        delegate: FestivalPersistHeader(
                          festival: festival,
                          minExtentVal: 230.0,
                          maxExtentVal: 260.0,
                          posterBox: posterBox,
                          posterWidth: posterWidth,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // 포스터
                                SizedBox(
                                  key: posterBox,
                                  height: posterWidth,
                                  width: double.infinity,
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
                                // 정보
                                Positioned(
                                  top: posterWidth,
                                  left: Sizes.size16,
                                  child: Row(
                                    children: [
                                      Text(
                                        festival.name,
                                        style: TextStyles.bigSubtitle,
                                      ),
                                      Gaps.h5,
                                      DefaultBtn(
                                        disabled: false,
                                        label: "타임테이블",
                                        onTapFunction: (p0) {},
                                      ),
                                      Gaps.h5,
                                      DefaultBtn(
                                        disabled: false,
                                        label: "홈페이지",
                                        onTapFunction: (p0) {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ), // Gaps 계산하여 설정
                            GestureDetector(
                              onTap: () {
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
                              child: Text(
                                "수정",
                                style: TextStyles.bigSubtitle,
                              ),
                            ),
                            const SizedBox(
                              height: 80,
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
    );
  }
}
