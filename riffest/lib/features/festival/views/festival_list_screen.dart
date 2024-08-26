import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/appbar_icon_btn.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';

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
  @override
  void initState() {
    super.initState();

    print("theme ::: ${widget.theme.themeName}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement: 20, // 화면을 당긴 후 indicator 돌아갈 위치
          edgeOffset: 20, // 어디에서 부터 시작할 것인지
          color: Colours.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: CustomScrollView(
              slivers: <Widget>[
                // 상단 - 로고, 검색 버튼
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gaps.v16,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.theme.themeName,
                            style: TextStyles.bigTitle,
                          ),
                          NoAppbarIconBtn(
                            icon: FontAwesomeIcons.magnifyingGlass,
                            onTapFunction: (p0) {},
                          )
                        ],
                      ),
                      Gaps.v16,
                    ],
                  ),
                ),
                SliverList.separated(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      "assets/images/ticket.png",
                      fit: BoxFit.fill, // 이미지 비율 유지하지 않고 공간에 맞게 늘림
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
