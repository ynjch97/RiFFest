import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riffest/common/widgets/default_form_field.dart';
import 'package:riffest/common/widgets/loading_progress_indicator.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/widgets/submit_btn.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/features/festival/view_models/festival_vm.dart';

class EditFestivalScreen extends ConsumerStatefulWidget {
  final String festivalKey;

  const EditFestivalScreen({
    super.key,
    required this.festivalKey,
  });

  @override
  EditFestivalScreenState createState() => EditFestivalScreenState();
}

class EditFestivalScreenState extends ConsumerState<EditFestivalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};
  String? _imagePath; // ImagePicker 이미지 경로
  File? imageFile; // ImagePicker 이미지 파일

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getFestival(); // 초기화
    });
  }

  Future<void> _getFestival() async {
    await ref
        .read(festivalProvider.notifier)
        .getFestivalTimeTables(widget.festivalKey);
  }

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
            .updateFestival(formData, imageFile);
        // todo: 화면 전환 오류 해결
        // context.pushNamed(FestivalScreen.routeName);
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

  // todo: data 에도 LoadingProgressIndicator 한 번 더 사용
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("페스티벌 수정"),
        ),
        body: ref.watch(festivalProvider).when(
              loading: () => const LoadingProgressIndicator(),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
              data: (FestivalModel festival) {
                return SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size40),
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
                                    : FadeInImage.assetNetwork(
                                        fit: BoxFit.cover, // fit 방식
                                        placeholder: "assets/images/add.png",
                                        image:
                                            "https://firebasestorage.googleapis.com/v0/b/riffest-43f8d.appspot.com/o/festival%2F${festival.key}?alt=media",
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          // 이미지 로드 실패 시 placeholder 이미지로 대체
                                          return Image.asset(
                                            "assets/images/add.png",
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                              ),
                            ),
                            Gaps.v20,
                            DefaultTextFormField(
                              initialValue: festival.key,
                              hintText: "키",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['key'] = newValue;
                                }
                                return null;
                              },
                            ),
                            DefaultTextFormField(
                              initialValue: festival.name,
                              hintText: "페스티벌명",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['name'] = newValue;
                                }
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
                                    initialValue: festival.startDate,
                                    hintText: "시작일시",
                                    validator: (value) =>
                                        _chkTextField(value, "값을 입력하세요."),
                                    onSaved: (newValue) {
                                      if (newValue != null) {
                                        formData['startDate'] = newValue;
                                      }
                                      return null;
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
                                    initialValue: festival.endDate,
                                    hintText: "종료일시",
                                    validator: (value) =>
                                        _chkTextField(value, "값을 입력하세요."),
                                    onSaved: (newValue) {
                                      if (newValue != null) {
                                        formData['endDate'] = newValue;
                                      }
                                      return null;
                                    },
                                    context: context,
                                  ),
                                ),
                              ],
                            ),
                            DefaultTimeFormField(
                              initialValue: festival.openTime,
                              hintText: "게이트오픈",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['openTime'] = newValue;
                                }
                                return null;
                              },
                              context: context,
                            ),
                            DefaultTextFormField(
                              initialValue: festival.location,
                              hintText: "위치",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['location'] = newValue;
                                }
                                return null;
                              },
                            ),
                            DefaultTextFormField(
                              initialValue: festival.mainColor,
                              hintText: "메인컬러",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['mainColor'] = newValue;
                                }
                                return null;
                              },
                            ),
                            DefaultTextFormField(
                              initialValue: festival.subColor,
                              hintText: "서브컬러",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['subColor'] = newValue;
                                }
                                return null;
                              },
                            ),
                            DefaultTextFormField(
                              initialValue: festival.stages.toString(),
                              hintText: "스테이지",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['stages'] = newValue;
                                }
                                return null;
                              },
                            ),
                            DefaultTextFormField(
                              initialValue: festival.filter.toString(),
                              hintText: "필터",
                              validator: (value) =>
                                  _chkTextField(value, "값을 입력하세요."),
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['filter'] = newValue;
                                }
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
                );
              },
            ),
      ),
    );
  }
}
