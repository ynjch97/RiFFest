import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class DefaultDateFormField extends FormField<DateTime> {
  DefaultDateFormField({
    super.key,
    required String initialValue,
    required String hintText,
    required String? Function(String?) validator,
    required String? Function(String?) onSaved,
    required BuildContext context,
  }) : super(
          builder: (FormFieldState<DateTime> state) {
            return TextFormField(
              style: TextStyles.defaultTextField,
              decoration:
                  InputDecorations.defaultDateField(Icons.calendar_today),
              validator: validator,
              onSaved: onSaved,
              readOnly: true,
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: state.value ?? DateTime.now(),
                  firstDate: DateTime(2000, 1, 1),
                  lastDate: DateTime(2040, 12, 31),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                if (date != null) {
                  state.didChange(date);
                }
              },
              controller: TextEditingController(
                text: state.value != null
                    ? DateFormat('yyyy-MM-dd').format(state.value!)
                    : initialValue,
              ),
            );
          },
        );
}

class DefaultTimeFormField extends FormField<TimeOfDay> {
  DefaultTimeFormField({
    super.key,
    required String initialValue,
    required String hintText,
    required String? Function(String?) validator,
    required String? Function(String?) onSaved,
    required BuildContext context,
  }) : super(
          builder: (FormFieldState<TimeOfDay> state) {
            final now = DateTime.now();
            return TextFormField(
              style: TextStyles.defaultTextField,
              decoration: InputDecorations.defaultDateField(Icons.access_time),
              validator: validator,
              onSaved: onSaved,
              readOnly: true,
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: state.value ?? TimeOfDay.now(),
                );
                if (time != null) {
                  state.didChange(time);
                }
              },
              controller: TextEditingController(
                text: state.value != null
                    ? DateFormat.Hm().format(DateTime(now.year, now.month,
                        now.day, state.value!.hour, state.value!.minute))
                    : initialValue,
              ),
            );
          },
        );
}
