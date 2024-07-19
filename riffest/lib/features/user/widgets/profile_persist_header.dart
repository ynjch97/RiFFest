// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:riffest/constants/box_decorations.dart';
import 'package:riffest/constants/gaps.dart';

class ProfilePersistHeader extends SliverPersistentHeaderDelegate {
  final double minExtentVal;
  final double maxExtentVal;
  final bool isCollapsed;

  ProfilePersistHeader({
    required this.minExtentVal,
    required this.maxExtentVal,
    required this.isCollapsed,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecorations.cardBottomContainer,
      child: Column(
        children: [
          if (!isCollapsed) ...[
            Gaps.v20,
            const Text(
              'Profile Header',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ] else
            const Text(
              'Profile Header',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxExtentVal;

  @override
  double get minExtent => minExtentVal;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}
