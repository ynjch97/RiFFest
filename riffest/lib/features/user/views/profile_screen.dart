// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/features/user/view_models/user_vm.dart';
import 'package:riffest/features/user/widgets/profile_persist_header.dart';

/**<기본 기능>
 * 1. 개인정보 (프로필사진, 닉네임, 바이오)
 * 2. 팔로워/팔로잉 기능
 * 3. 페스티벌 관람 n건 / 평가 n건 / 코멘트 n건
 * - 관람건만 보여주고, 평가와 코멘트는 하위 목록에 여부만 표시되도록
 * 4. 페스티벌 캘린더
 * 
 * <추가 기능 아이디어>
 * 취향분석
 * 장르/페스티벌/아티스트 선호도 저장
 */
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  late ScrollController _scrollController;

  double minExtentVal = 76.0;
  double maxExtentVal = 260.0;
  bool isCollapsed = false;

  @override
  void initState() {
    super.initState();

    /**스크롤 리스너
     * - 축소 기준 높이를 이용해, Widget 의 display 여부 결정
     * - kToolbarHeight : Appbar 의 높이
     * - _scrollController.offset : 현재 위치 0.0~
     */
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        bool tempCollapsed = _scrollController.offset > (120 - kToolbarHeight);
        if (isCollapsed != tempCollapsed) {
          setState(() {
            isCollapsed = tempCollapsed;
            if (maxExtentVal != 260.0) updateExtent(maxExtentVal < 260.0);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void updateExtent(bool isOpen) {
    if (isOpen) {
      maxExtentVal = maxExtentVal + 50;
    } else {
      maxExtentVal = maxExtentVal - 50;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          data: (data) => Scaffold(
            backgroundColor: Colours.bgGrey,
            appBar: AppBar(
              centerTitle: false,
              titleSpacing: Sizes.size28,
              title: Text(
                isCollapsed ? data.nickname : "",
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // ref.read(authRepo).emailSignOut();
                    // context.goNamed(SignUpScreen.routeName);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.gear,
                    size: Sizes.size20,
                  ),
                ),
              ],
            ),
            body: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfilePersistHeader(
                    user: data,
                    minExtentVal: minExtentVal,
                    maxExtentVal: maxExtentVal,
                    isCollapsed: isCollapsed,
                    updateExtent: updateExtent,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Gaps.v12,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        color: Colours.primaryColor,
                        child: ListTile(
                          title: Text('Item #$index'),
                        ),
                      );
                    },
                    childCount: 50,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
