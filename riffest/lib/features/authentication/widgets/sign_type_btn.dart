import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class SignTypeBtn extends StatefulWidget {
  final String text;
  final IconData icon;
  final void Function(BuildContext) onTapFunction;

  const SignTypeBtn({
    super.key,
    required this.text,
    required this.icon,
    required this.onTapFunction,
  });

  @override
  State<SignTypeBtn> createState() => _SignTypeBtnState();
}

class _SignTypeBtnState extends State<SignTypeBtn> {
  bool _isTapDown = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isTapDown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isTapDown = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isTapDown = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapDown = false;
        });
      },
      onTap: () => widget.onTapFunction(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14,
          ),
          decoration: _isTapDown
              ? BoxDecorations.defaultBorderContainer
              : BoxDecorations.whiteBorderContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.icon,
                color: _isTapDown ? Colours.textWhite : Colours.textBlack,
                size: Sizes.size18,
              ),
              Gaps.h10,
              Text(
                widget.text,
                style: _isTapDown
                    ? TextStyles.defaultLabelReverse
                    : TextStyles.defaultLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
