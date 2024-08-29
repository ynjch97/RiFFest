import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/routes.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/authentication/widgets/submit_btn.dart';
import 'package:riffest/features/festival/view_models/time_table_vm.dart';

class AddTimeTableScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.addTimeTableScreen;
  static const routeName = RoutesName.addTimeTableScreen;

  const AddTimeTableScreen({super.key});

  @override
  AddTimeTableScreenState createState() => AddTimeTableScreenState();
}

class AddTimeTableScreenState extends ConsumerState<AddTimeTableScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        await ref
            .read(timeTableProvider.notifier)
            .insertTimeTable(context, formData);
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
          title: const Text("타임테이블 추가"),
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
                      initialValue: "462237bd-2d53-43ae-b02b-689b45bba874",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("페스티벌 키"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['festKey'] = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: "2024-09-07",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("일자"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['date'] = newValue;
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
                            initialValue: "11:30",
                            style: TextStyles.defaultTextField,
                            decoration:
                                InputDecorations.defaultTextField("시작시간"),
                            validator: (value) =>
                                _chkTextField(value, "값을 입력하세요."),
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['startTime'] = newValue;
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
                            initialValue: "12:10",
                            style: TextStyles.defaultTextField,
                            decoration:
                                InputDecorations.defaultTextField("종료시간"),
                            validator: (value) =>
                                _chkTextField(value, "값을 입력하세요."),
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['endTime'] = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      initialValue: "UNIQUE",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("스테이지"),
                      validator: (value) => _chkTextField(value, "값을 입력하세요."),
                      onSaved: (newValue) {
                        if (newValue != null) formData['stage'] = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: "한로로",
                      style: TextStyles.defaultTextField,
                      decoration: InputDecorations.defaultTextField("아티스트"),
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
      ),
    );
  }
}
