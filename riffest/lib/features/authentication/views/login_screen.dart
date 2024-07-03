import 'package:flutter/material.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

import '../widgets/submit_btn.dart';

class LoginScreen extends StatelessWidget {
  static const routeURL = Routes.loginScreen;
  static const routeName = RoutesName.loginScreen;

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v80,
              Text(
                "로그인",
                style: TextStyles.bigTitle,
              ),
              Gaps.v40,
              TextFormField(
                style: TextStyles.defaultTextField,
                decoration: InputDecoration(
                  hintText: "아이디",
                  hintStyle: TextStyles.defaultTextFieldHint,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colours.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colours.primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Gaps.v16,
              TextFormField(
                style: TextStyles.defaultTextField,
                decoration: InputDecoration(
                  hintText: "비밀번호",
                  hintStyle: TextStyles.defaultTextFieldHint,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colours.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colours.primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Gaps.v24,
              SubmitBtn(
                disabled: true,
                label: "sss",
                onTapFunction: (p0) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
