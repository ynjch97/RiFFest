import 'package:flutter/material.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';

class FestivalPosterInfo extends StatelessWidget {
  final String festivalName;
  final String startDate;
  final String endDate;
  final String imageLink;
  final int dDay; // D-Day
  final int rating; // 순위
  final double starRating; // 별점
  final void Function(BuildContext) onTapFunction;

  const FestivalPosterInfo({
    super.key,
    required this.festivalName,
    required this.startDate,
    required this.endDate,
    required this.imageLink,
    required this.dDay,
    required this.rating,
    required this.starRating,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 150,
            width: 110,
            decoration: BoxDecorations.posterContainer,
            // 포스터 사진, D-Day, 순위, 별점 등의 정보
            child: Stack(
              children: [
                FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover, // fit 방식
                    placeholder: "assets/images/kelly.png",
                    image: imageLink,
                  ),
                ),
                if (dDay > 0) // D-Day
                  Positioned(
                    top: Sizes.size5,
                    left: Sizes.size5,
                    child: DecoratedBox(
                      decoration: BoxDecorations.posterIconContainer,
                      child: Text(
                        " D-$dDay ",
                        style: TextStyles.largeBoldTextWhite,
                      ),
                    ),
                  ),
                if (rating > 0) // 순위
                  Positioned(
                    bottom: Sizes.size5,
                    left: Sizes.size5,
                    width: Sizes.size22,
                    child: DecoratedBox(
                      decoration: BoxDecorations.posterIconContainer,
                      child: Text(
                        rating.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyles.largeBoldTextWhite,
                      ),
                    ),
                  ),
                if (starRating > 0) // 별점
                  Positioned(
                    bottom: Sizes.size5,
                    right: Sizes.size5,
                    child: SizedBox(
                      height: Sizes.size22,
                      child: DecoratedBox(
                        decoration: BoxDecorations.posterIconContainer,
                        child: Text(
                          " ★ $starRating ",
                          style: TextStyles.defaultBoldTextWhite,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Gaps.v3,
          Text(
            festivalName,
            style: TextStyles.defaultText,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Gaps.v2,
          Text(
            "$startDate ~ $endDate",
            style: TextStyles.tinyText,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
