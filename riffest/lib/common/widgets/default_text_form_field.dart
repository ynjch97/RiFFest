import 'package:flutter/material.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/text_styles.dart';

class DefaultTextFormField extends FormField<String> {
  DefaultTextFormField({
    super.key,
    required String initialValue,
    required String hintText,
    required String? Function(String?) validator,
    required String? Function(String?) onSaved,
  }) : super(
          builder: (FormFieldState<String> state) {
            return TextFormField(
              initialValue: initialValue,
              style: TextStyles.defaultTextField,
              decoration: InputDecorations.defaultTextField(hintText),
              validator: validator,
              onSaved: onSaved,
            );
          },
        );
}
