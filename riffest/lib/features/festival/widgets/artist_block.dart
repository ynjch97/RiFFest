import 'package:flutter/material.dart';
import 'package:riffest/constants/colours.dart';
import 'package:riffest/constants/gaps.dart';
import 'package:riffest/constants/text_styles.dart';
import 'package:riffest/features/festival/models/time_table_model.dart';
import 'package:riffest/features/festival/widgets/time_table_stage.dart';
import 'package:riffest/utils.dart';

class ArtistBlock extends StatefulWidget {
  final TimeTableStage widget;
  final TimeTableModel timeTable;
  final double perHeight; // 1 min 높이
  final bool isDark;

  const ArtistBlock({
    super.key,
    required this.widget,
    required this.timeTable,
    required this.perHeight,
    required this.isDark,
  });

  @override
  State<ArtistBlock> createState() => _ArtistBlockState();
}

class _ArtistBlockState extends State<ArtistBlock> {
  bool blockToggle = false;

  void _onBlockTap() {
    setState(() {
      blockToggle = !blockToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onBlockTap,
      child: Container(
        height: calcMinDiff(
                    widget.widget.festival.startDate,
                    widget.timeTable.startTime,
                    widget.widget.festival.startDate,
                    widget.timeTable.endTime)
                .toDouble() *
            widget.perHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: blockToggle
              ? Colours.bgDarkGrey
              : Color(int.parse(widget.widget.festival.mainColor)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.timeTable.artist,
              style: blockToggle
                  ? TextStyles.defaultBoldTextGray
                  : widget.isDark
                      ? TextStyles.defaultBoldTextWhite
                      : TextStyles.defaultBoldText,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              maxLines: 1,
              softWrap: false,
            ),
            Gaps.v2,
            Text(
              "${widget.timeTable.startTime} - ${widget.timeTable.endTime} (${calcMinDiff(widget.widget.festival.startDate, widget.timeTable.startTime, widget.widget.festival.startDate, widget.timeTable.endTime)})",
              style: blockToggle
                  ? TextStyles.tinyTextGray
                  : widget.isDark
                      ? TextStyles.tinyTextWhite
                      : TextStyles.tinyText,
            ),
          ],
        ),
      ),
    );
  }
}
