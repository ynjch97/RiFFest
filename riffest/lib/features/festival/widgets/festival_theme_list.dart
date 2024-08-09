import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riffest/common/widgets/list_icon_btn.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/text_styles.dart';

import 'festival_poster_info.dart';

class FestivalThemeList extends StatelessWidget {
  final String themeName;

  const FestivalThemeList({
    super.key,
    required this.themeName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 테마 제목
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              themeName,
              style: TextStyles.highlightText,
            ),
            ListIconBtn(
              icon: FontAwesomeIcons.angleRight,
              onTapFunction: (p0) {},
            ),
          ],
        ),
        Gaps.v7,
        // 테마별 horizontal 목록
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 10, // 수평 스크롤 아이템 개수
            itemBuilder: (context, index) {
              // 포스터, 페스티벌명, 기간 정보
              return FestivalPosterInfo(
                festivalName: "2024 펜타포트 락페스티벌 Pentaport Rock Festival",
                startDate: "24.08.02",
                endDate: "24.08.04",
                imageLink: [
                  "https://ticketimage.interpark.com/Play/image/large/24/24009132_p.gif",
                  "https://cdn.imweb.me/thumbnail/20240528/8affb0255501f.jpg"
                ][index % 2],
                dDay: 4,
                rating: 13,
                starRating: 3.5,
                onTapFunction: (p0) {},
              );
            },
            separatorBuilder: (context, index) {
              return Gaps.h12;
            },
          ),
        ),
      ],
    );
  }
}
