import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/widgets/submit_btn.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/views/time_table_screen.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  CommunityScreenState createState() => CommunityScreenState();
}

class CommunityScreenState extends ConsumerState<CommunityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        await ref.read(festivalProvider.notifier).insertFestival(formData);
        context.pushNamed(TimeTableScreen.routeName);
      }
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  String? _chkTextField(String? text, String msg) {
    if (text == null || text.isEmpty) return msg;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gaps.v80,
                  TextFormField(
                    initialValue: "TEST",
                    // initialValue: "HAVE A NICE TRIP",
                    // initialValue: "2024 펜타포트 락페스티벌",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "페스티벌명",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['name'] = newValue;
                    },
                  ),
                  TextFormField(
                    // initialValue: "2024-07-27",
                    initialValue: "2024-08-02",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "시작일시",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['startDate'] = newValue;
                    },
                  ),
                  TextFormField(
                    // initialValue: "2024-07-28",
                    initialValue: "2024-08-04",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "종료일시",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['endDate'] = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: "11:00",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "게이트오픈",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['openTime'] = newValue;
                    },
                  ),
                  TextFormField(
                    // initialValue: "고양 킨텍스",
                    initialValue: "송도 달빛축제공원",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "위치",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['location'] = newValue;
                    },
                  ),
                  TextFormField(
                    // initialValue: "0xFFEB5C27",
                    initialValue: "0xFFE82340",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "메인컬러",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['mainColor'] = newValue;
                    },
                  ),
                  TextFormField(
                    // initialValue: "0xFFA4B03C",
                    initialValue: "0xFFFFC30B",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "서브컬러",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['subColor'] = newValue;
                    },
                  ),
                  TextFormField(
                    // initialValue: "SUNSET,air",
                    initialValue: "KB 국민카드 스타샵,힐스테이트,글로벌",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "스테이지",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['stages'] = newValue;
                    },
                  ),
                  Gaps.v28,
                  SubmitBtn(
                    disabled: false,
                    label: "저장",
                    onTapFunction: _onSubmitTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
