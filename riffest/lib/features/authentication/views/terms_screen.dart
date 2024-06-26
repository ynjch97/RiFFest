import 'package:flutter/material.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

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
            children: [
              Gaps.v80,
              Text(
                "약관에 동의해주세요",
                style: TextStyles.bigTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
