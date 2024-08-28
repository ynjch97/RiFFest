// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:riffest/common/widgets/default_btn.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_model.dart';

class FestivalPersistHeader extends SliverPersistentHeaderDelegate {
  final FestivalModel festival;
  final double minExtentVal;
  final double maxExtentVal;
  final GlobalKey posterBox;
  final double posterWidth;

  FestivalPersistHeader({
    required this.festival,
    required this.minExtentVal,
    required this.maxExtentVal,
    required this.posterBox,
    required this.posterWidth,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("FestivalPersistHeader posterWidth ::::::::: $posterWidth");
    return const Stack(
      clipBehavior: Clip.none,
      children: [
        // 포스터
        SizedBox(),
      ],
    );
  }

  @override
  double get maxExtent => posterWidth;

  @override
  double get minExtent => posterWidth;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}
