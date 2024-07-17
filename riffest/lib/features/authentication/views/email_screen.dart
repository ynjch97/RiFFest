import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/view_models/sign_up_vm.dart';
import 'package:riffest/features/authentication/views/name_screen.dart';

import '../widgets/submit_btn.dart';

class EmailScreen extends ConsumerStatefulWidget {
  // static const routeURL = Routes.emailScreen;
  // static const routeName = RoutesName.emailScreen;

  const EmailScreen({super.key});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 모든 TextFormField => onSaved 콜백 함수 실행 => formData 에 set
        _formKey.currentState!.save();

        // signUpForm 에 데이터 세팅
        ref.read(signUpForm.notifier).state = {
          "name": formData["name"],
          "email": formData["email"],
          "password": formData["password"],
        };

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NameScreen(),
          ),
        );
      }
    }
  }

  String? _isNameValid(String? text) {
    if (text == null || text.isEmpty) return "이름을 입력하세요.";

    final regExp = RegExp(r'^[가-힣]+$');

    if (!regExp.hasMatch(text)) {
      final regExp = RegExp(r'^[ㄱ-힣]+$');
      if (regExp.hasMatch(text)) return "초성은 입력할 수 없어요.";
      return "한글만 입력해주세요.";
    }
    return null;
  }

  String? _isEmailValid(String? text) {
    if (text == null || text.isEmpty) return "이메일을 입력하세요.";

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(text)) return "이메일 형식에 맞게 입력해주세요.";
    return null;
  }

  String? _isPasswordValid(String? text) {
    if (text == null || text.isEmpty) return "비밀번호를 입력하세요.";
    if (text.length < 8 || text.length > 20) return "비밀번호는 8~20자여야 합니다.";

    if (text.isNotEmpty && text.length >= 8 && text.length <= 20) {
      final regExp = RegExp(
          r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*#?&\^])[A-Za-z0-9@$!%*#?&\^]{8,20}$");
      if (!regExp.hasMatch(text)) {
        return "하나 이상의 알파벳과 숫자, 특수문자(@\$!%*#?&^)를 입력하세요.";
      }
    }
    return null;
  }

  String? _isPasswordSame(String? text) {
    // todo: Controller 로 일치 여부 확인
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
                  "이메일과 비밀번호를 설정해주세요.",
                  style: TextStyles.bigTitle,
                ),
                Gaps.v50,
                TextFormField(
                  initialValue: "황소윤",
                  style: TextStyles.defaultTextField,
                  decoration: InputDecoration(
                    hintText: "이름",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: _isNameValid,
                  onSaved: (newValue) {
                    if (newValue != null) formData['name'] = newValue;
                  },
                ),
                Gaps.v20,
                TextFormField(
                  initialValue: "riffest@gmail.com",
                  style: TextStyles.defaultTextField,
                  decoration: InputDecoration(
                    hintText: "이메일 (riffest@gmail.com)",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: _isEmailValid,
                  onSaved: (newValue) {
                    if (newValue != null) formData['email'] = newValue;
                  },
                ),
                Gaps.v20,
                TextFormField(
                  initialValue: "riffest123!",
                  style: TextStyles.defaultTextField,
                  decoration: InputDecoration(
                    hintText: "비밀번호 (8~20자)",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: _isPasswordValid,
                  onSaved: (newValue) {
                    if (newValue != null) formData['password'] = newValue;
                  },
                ),
                Gaps.v20,
                TextFormField(
                  style: TextStyles.defaultTextField,
                  decoration: InputDecoration(
                    hintText: "비밀번호 확인 (8~20자)",
                    hintStyle: TextStyles.defaultTextFieldHint,
                    errorStyle: TextStyles.defaultTextFieldError,
                    errorBorder: Borders.underlineInputBorderError,
                    border: Borders.underlineInputBorder,
                    focusedBorder: Borders.underlineInputBorder,
                  ),
                  validator: _isPasswordSame,
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
