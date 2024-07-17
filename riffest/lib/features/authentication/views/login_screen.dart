import 'package:flutter/material.dart';
import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

import '../widgets/submit_btn.dart';

class LoginScreen extends StatefulWidget {
  static const routeURL = Routes.loginScreen;
  static const routeName = RoutesName.loginScreen;

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save(); // formData 에 set
      }
    }
  }

  String? _chkTextField(String? text, String msg) {
    if (text == null || text.isEmpty) return msg;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Form(
            key: _formKey,
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
                    hintText: "이메일",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: (value) => _chkTextField(value, "이메일을 입력하세요."),
                  onSaved: (newValue) {
                    if (newValue != null) formData['email'] = newValue;
                  },
                ),
                Gaps.v16,
                TextFormField(
                  style: TextStyles.defaultTextField,
                  decoration: InputDecoration(
                    hintText: "비밀번호",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: (value) => _chkTextField(value, "비밀번호를 입력하세요."),
                  onSaved: (newValue) {
                    if (newValue != null) formData['password'] = newValue;
                  },
                ),
                Gaps.v28,
                SubmitBtn(
                  disabled: false,
                  label: "로그인",
                  onTapFunction: _onSubmitTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
