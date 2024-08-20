import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:riffest/common/widgets/default_form_field.dart';
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
  String? _imagePath; // ImagePicker 이미지 경로
  File? imageFile; // ImagePicker 이미지 파일

  // 포스터 등록
  Future<void> _onPosterTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 200,
      maxWidth: 150,
    );

    if (xfile != null) {
      setState(() {
        _imagePath = xfile.path;
      });
    }
  }

  // 저장
  void _onSubmitTap(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if (_imagePath != null) {
          imageFile = File(_imagePath!); // 업로드할 실제 파일 만들기
        }

        await ref
            .read(festivalProvider.notifier)
            .insertFestival(formData, imageFile);
        context.pushNamed(TimeTableScreen.routeName);
      }
    }
  }

  // 키보드 없애기
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  // 유효성 체크
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
                    Gaps.v32,
                    GestureDetector(
                      onTap: () => _onPosterTap(ref),
                      child: SizedBox(
                        width: 150,
                        height: 200,
                        child: _imagePath != null
                            ? Image.file(
                                File(_imagePath!),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/add.png",
                              ),
                      ),
                    ),
                    Gaps.v20,
                    DefaultTextFormField(
                      initialValue: "2024 부산국제록페스티벌",
                      hintText: "페스티벌명",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['name'] = newValue;
                        return null;
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: DefaultDateFormField(
                            initialValue:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            hintText: "시작일시",
                            validator: (value) =>
                                _chkTextField(value, "값을 입력하세요."),
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['startDate'] = newValue;
                              }
                              return;
                            },
                            context: context,
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
                          child: DefaultDateFormField(
                            initialValue:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            hintText: "종료일시",
                            validator: (value) =>
                                _chkTextField(value, "값을 입력하세요."),
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['endDate'] = newValue;
                              }
                              return;
                            },
                            context: context,
                          ),
                        ),
                      ],
                    ),
                    DefaultTimeFormField(
                      initialValue: "12:00",
                      hintText: "게이트오픈",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['openTime'] = newValue;
                        return null;
                      },
                      context: context,
                    ),
                    DefaultTextFormField(
                      initialValue: "삼락생태공원",
                      hintText: "위치",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['location'] = newValue;
                        return null;
                      },
                    ),
                    DefaultTextFormField(
                      initialValue: "0xFF525EC8",
                      hintText: "메인컬러",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['mainColor'] = newValue;
                        return null;
                      },
                    ),
                    DefaultTextFormField(
                      initialValue: "0xFFE99E00",
                      hintText: "서브컬러",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['subColor'] = newValue;
                        return null;
                      },
                    ),
                    DefaultTextFormField(
                      initialValue: "스테이지",
                      hintText: "스테이지",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['stages'] = newValue;
                        return null;
                      },
                    ),
                    DefaultTextFormField(
                      initialValue: "부산,global,rock",
                      hintText: "필터",
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['filter'] = newValue;
                        return null;
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
