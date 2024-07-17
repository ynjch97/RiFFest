import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/view_models/sign_up_vm.dart';

import '../widgets/submit_btn.dart';

class NameScreen extends ConsumerStatefulWidget {
  // static const routeURL = Routes.nameScreen;
  // static const routeName = RoutesName.nameScreen;

  const NameScreen({super.key});

  @override
  NameScreenState createState() => NameScreenState();
}

class NameScreenState extends ConsumerState<NameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 모든 TextFormField => onSaved 콜백 함수 실행 => formData 에 set
        _formKey.currentState!.save();

        // signUpForm 에 데이터 세팅
        final state = ref.read(signUpForm.notifier).state;
        ref.read(signUpForm.notifier).state = {
          ...state,
          "nickname": formData["nickname"],
        };

        print(state);

        ref.read(signUpProvider.notifier).emailSignUp(context);
      }
    }
  }

  String? _isNicknameValid(String? text) {
    if (text == null || text.isEmpty) return "닉네임을 입력하세요.";

    String invalidVal = '';
    final regExp = RegExp(r'^[ㄱ-힣a-zA-Z0-9 _(),]+$');
    for (int i = 0; i < text.length; i++) {
      if (!regExp.hasMatch(text[i])) {
        invalidVal = text[i];
        break;
      }
    }

    if (invalidVal.isNotEmpty) return "$invalidVal 는 입력할 수 없어요.";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v80,
                Text(
                  "닉네임을 입력해주세요.",
                  style: TextStyles.bigTitle,
                ),
                Gaps.v50,
                TextFormField(
                  initialValue: "SoYoON",
                  maxLength: 10,
                  style: TextStyles.defaultTextField,
                  decoration: InputDecoration(
                    hintText: "닉네임",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: _isNicknameValid,
                  onSaved: (newValue) {
                    if (newValue != null) formData['nickname'] = newValue;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Sizes.size72,
        padding: const EdgeInsets.all(0),
        child: Expanded(
          child: SubmitBtn(
            disabled: false,
            label: "다음",
            onTapFunction: _onSubmitTap,
          ),
        ),
      ),
    );
  }
}
