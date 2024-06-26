import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

import '../widgets/sign_type_btn.dart';

class SignUpScreen extends StatefulWidget {
  static const routeURL = Routes.signUpScreen;
  static const routeName = RoutesName.signUpScreen;

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v80,
              Text(
                "RiFFest 와 함께 페스티벌 즐겨요",
                style: TextStyles.bigTitle,
              ),
              Gaps.v20,
              Text(
                "나만의 타임테이블을 만들어보아요.\r\n페스티벌 정보도 얻고, 후기도 공유해요.",
                // "즐기기만 하세요.\r\n나머지는 저희가 다 해드릴게요.",
                style: TextStyles.bigSubtitle,
              ),
              Gaps.v40,
              const SignTypeBtn(
                text: "카카오톡으로 시작",
                icon: FaIcon(FontAwesomeIcons.github),
              ),
              Gaps.v16,
              const SignTypeBtn(
                text: "카카오톡으로 시작",
                icon: FaIcon(FontAwesomeIcons.github),
              ),
              Gaps.v16,
              const SignTypeBtn(
                text: "카카오톡으로 시작",
                icon: FaIcon(FontAwesomeIcons.github),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        padding: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "이미 계정이 있나요?",
                style: TextStyles.miniLabel,
              ),
              Gaps.h5,
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Log in",
                  style: TextStyles.miniBoldLabel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
