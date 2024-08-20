import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
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
  GlobalKey posterBox = GlobalKey();
  double posterHeight = 500;
  double ticketHeight = 120;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 포스터 높이 측정
      final RenderBox renderBox =
          posterBox.currentContext?.findRenderObject() as RenderBox;
      posterHeight = renderBox.size.width;

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
                            height: posterHeight,
                            width: double.infinity,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover, // fit 방식
                              placeholder: "assets/images/placeholder.png",
                              image:
                                  "https://firebasestorage.googleapis.com/v0/b/riffest-43f8d.appspot.com/o/festival%2F${festival.key}?alt=media",
                              imageErrorBuilder: (context, error, stackTrace) {
                                // 이미지 로드 실패 시 placeholder 이미지로 대체
                                return Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          // 티켓
                          Positioned(
                            top: posterHeight - ticketHeight / 2,
                            left: 0, // 좌우로 화면 전체를 차지하게 위치
                            right: 0,
                            child: Container(
                              height: ticketHeight,
                              width: double.infinity, // 부모 위젯의 전체 너비를 차지
                              padding:
                                  const EdgeInsets.only(right: Sizes.size50),
                              child: FractionallySizedBox(
                                widthFactor: 1, // 부모 위젯의 남은 공간을 100% 채움
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.5), // 그림자 색상
                                        spreadRadius: 0.2, // 그림자의 확산 반경
                                        blurRadius: 5, // 그림자의 흐림 정도
                                        offset: const Offset(
                                            -8, 4), // 그림자의 위치 (x, y)
                                      ),
                                    ],
                                  ),
                                  child: Transform.translate(
                                    offset: const Offset(
                                        -10, 0), // 이미지의 x축을 -10 위치로 이동
                                    child: Image.asset(
                                      "assets/images/ticket.png",
                                      fit: BoxFit
                                          .fill, // 이미지 비율 유지하지 않고 공간에 맞게 늘림
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // 티켓 - 페스티벌명
                          Positioned(
                            top: posterHeight - ticketHeight / 2 + Sizes.size16,
                            left: Sizes.size16,
                            child: Text(
                              festival.name,
                              style: TextStyles.bigSubtitle,
                            ),
                          ),
                          // 티켓 - 타임테이블 보기
                          Positioned(
                            top: posterHeight - ticketHeight / 2 + Sizes.size16,
                            left: Sizes.size16,
                            child: Text(
                              festival.name,
                              style: TextStyles.bigSubtitle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ticketHeight / 2,
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
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
