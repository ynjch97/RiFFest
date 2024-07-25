import 'package:flutter/material.dart';
import 'package:riffest/constants/colours.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color?>(Colours.primaryColor),
      ),
    );
  }
}
