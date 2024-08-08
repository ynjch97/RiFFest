import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riffest/constants/borders.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/widgets/submit_btn.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';
import 'package:riffest/features/festival/views/time_table_screen.dart';

class AddFestivalScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.addFestivalScreen;
  static const routeName = RoutesName.addFestivalScreen;

  const AddFestivalScreen({super.key});

  @override
  AddFestivalScreenState createState() => AddFestivalScreenState();
}

class AddFestivalScreenState extends ConsumerState<AddFestivalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        await ref
            .read(festivalProvider.notifier)
            .insertFestival(context, formData);
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("페스티벌 추가"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gaps.v80,
                    TextFormField(
                      initialValue: "LOVE CHIPS FESTIVAL 2024",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("페스티벌명"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['name'] = newValue;
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: "2024-09-28",
                            style: TextStyles.defaultTextField,
                            decoration:
                                InputDecorations.defaultTextField("시작일시"),
                            validator: (value) =>
                                _chkTextField(value, "값을 입력하세요."),
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['startDate'] = newValue;
                              }
                            },
                          ),
                        ),
                        Gaps.h10,
                        Text(
                          "~",
                          style: TextStyles.defaultTextField,
                        ),
                        Gaps.h10,
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: "2024-09-29",
                            style: TextStyles.defaultTextField,
                            decoration:
                                InputDecorations.defaultTextField("종료일시"),
                            validator: (value) =>
                                _chkTextField(value, "값을 입력하세요."),
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['endDate'] = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      initialValue: "11:00",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("게이트오픈"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['openTime'] = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: "인천 상상플랫폼 야외광장",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("위치"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['location'] = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: "0xFFC165A4",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("메인컬러"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['mainColor'] = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: "0xFF00A9AC",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("서브컬러"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['subColor'] = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: "미정",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("스테이지"),
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
      ),
    );
  }
}
