import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/widgets/submit_btn.dart';
import 'package:riffest/features/festival/view_models/time_table_vm.dart';

class FestivalScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.festivalScreen;
  static const routeName = RoutesName.festivalScreen;

  const FestivalScreen({super.key});

  @override
  FestivalScreenState createState() => FestivalScreenState();
}

class FestivalScreenState extends ConsumerState<FestivalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // await ref
        //     .read(timeTableProvider.notifier)
        //     .insertTimeTable(context, formData);
        // context.pushNamed(TimeTableScreen.routeName);
        await ref
            .read(timeTableProvider.notifier)
            .insertTimeTableDummy(context);
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
                    initialValue: "09bf67a4-561c-473a-8927-944bf8c3dc75",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "페스티벌 키",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['festKey'] = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: "2024-08-02",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "일자",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['date'] = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: "12:00",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "시작시간",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['startTime'] = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: "12:30",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "종료시간",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['endTime'] = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: "힐스테이트",
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
                      if (newValue != null) formData['stage'] = newValue;
                    },
                  ),
                  TextFormField(
                    initialValue: "KAVE",
                    style: TextStyles.defaultTextField,
                    decoration: InputDecoration(
                      hintText: "아티스트",
                      hintStyle: TextStyles.defaultTextFieldHint,
                      errorStyle: TextStyles.defaultTextFieldError,
                      errorBorder: Borders.underlineInputBorderError,
                      border: Borders.underlineInputBorder,
                      focusedBorder: Borders.underlineInputBorder,
                    ),
                    validator: (value) => _chkTextField(value, "값을 입력하세요."),
                    onSaved: (newValue) {
                      if (newValue != null) formData['artist'] = newValue;
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
