import 'package:flutter/material.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class TermsScreen extends StatefulWidget {
  static const routeURL = Routes.termsScreen;
  static const routeName = RoutesName.termsScreen;

  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
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
