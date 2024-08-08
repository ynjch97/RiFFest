import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class SubmitBtn extends StatelessWidget {
  final bool disabled;
  final String label;
  final void Function(BuildContext) onTapFunction;

  const SubmitBtn({
    super.key,
    required this.disabled,
    required this.label,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFunction(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: Sizes.size18),
          decoration: disabled
              ? BoxDecorations.defaultButtonDisabled
              : BoxDecorations.defaultButton,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: disabled
                ? TextStyles.defaultButtonDisabled
                : TextStyles.defaultButton,
            child: Text(
              label,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
