// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/repos/authentication_repo.dart';
import 'package:riffest/features/authentication/views/login_screen.dart';
import 'package:riffest/features/authentication/views/sign_up_screen.dart';
import 'package:riffest/features/user/widgets/profile_persist_header.dart';

/**<기본 기능>
 * 1. 개인정보 (프로필사진, 닉네임, 바이오)
 * 2. 페스티벌 예약 n건 / 평가 n건 / 코멘트 n건
 * 3. 페스티벌 캘린더
 * 
 * <추가 기능 아이디어>
 * 팔로워/팔로잉 기능
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
        isCollapsed = _scrollController.offset > (200 - kToolbarHeight);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 30,
        title: Text(
          isCollapsed ? "janis" : "",
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepo).emailSignOut();
              context.goNamed(SignUpScreen.routeName);
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
              minExtentVal: 70.0,
              maxExtentVal: 150.0,
              isCollapsed: isCollapsed,
            ),
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
    );
  }
}
