import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riffest/constants/decorations.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/sizes.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/festival_theme_model.dart';
import 'package:riffest/features/festival/models/festival_model.dart';
import 'package:riffest/utils.dart';

class FestivalPosterInfo extends StatelessWidget {
  final FestivalModel festival;
  final FestivalThemeModel theme;
  final int idx;
  final void Function(BuildContext) onTapFunction;

  const FestivalPosterInfo({
    super.key,
    required this.festival,
    required this.theme,
    required this.idx,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    String startDate =
        DateFormat('yy.MM.dd').format(DateTime.parse(festival.startDate));
    String endDate =
        DateFormat('yy.MM.dd').format(DateTime.parse(festival.endDate));

    return GestureDetector(
      onTap: () => onTapFunction(context),
      child: SizedBox(
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
                      placeholder: "assets/images/placeholder.png",
                      image:
                          "https://firebasestorage.googleapis.com/v0/b/riffest-43f8d.appspot.com/o/festival%2F${festival.key}?alt=media",
                      imageErrorBuilder: (context, error, stackTrace) {
                        // 이미지 로드 실패 시 placeholder 이미지로 대체
                        return Image.asset(
                          "assets/images/placeholder.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  if (theme.isDDay) // D-Day
                    Positioned(
                      top: Sizes.size5,
                      left: Sizes.size5,
                      child: DecoratedBox(
                        decoration: BoxDecorations.posterIconContainer,
                        child: Text(
                          " ${calcDayDiff(festival.startDate)} ", // todo: 계산한 값으로 넣기
                          style: TextStyles.largeBoldTextWhite,
                        ),
                      ),
                    ),
                  if (theme.isRating) // 순위
                    Positioned(
                      bottom: Sizes.size5,
                      left: Sizes.size5,
                      width: Sizes.size22,
                      child: DecoratedBox(
                        decoration: BoxDecorations.posterIconContainer,
                        child: Text(
                          (idx + 1).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyles.largeBoldTextWhite,
                        ),
                      ),
                    ),
                  if (theme.isStarRating) // 별점
                    Positioned(
                      bottom: Sizes.size5,
                      right: Sizes.size5,
                      child: SizedBox(
                        height: Sizes.size22,
                        child: DecoratedBox(
                          decoration: BoxDecorations.posterIconContainer,
                          child: const Text(
                            " ★ 4.0 ",
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
              festival.name,
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
      ),
    );
  }
}
