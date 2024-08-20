import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class DefaultBtn extends StatelessWidget {
  final bool disabled;
  final String label;
  final void Function(BuildContext) onTapFunction;

  const DefaultBtn({
    super.key,
    required this.disabled,
    required this.label,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFunction(context),
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
          horizontal: Sizes.size10,
        ),
        decoration: disabled
            ? BoxDecorations.roundButtonDisabled
            : BoxDecorations.roundButton,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: disabled
              ? TextStyles.defaultButtonDisabled.copyWith(height: 0.9)
              : TextStyles.defaultButton.copyWith(height: 0.9),
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
