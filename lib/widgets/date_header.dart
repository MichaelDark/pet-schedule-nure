import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nure_schedule/util/date_utils.dart';

const double headersSize = 40;

class DateHeader extends StatelessWidget {
  final DateTime day;
  final double width;
  final double height;

  DateHeader({this.width, this.day}) : height = headersSize;
  DateHeader.leftTopCorner()
      : height = headersSize,
        width = headersSize,
        day = null;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (day == null) {
      return Opacity(
        opacity: 0,
        child: SizedBox(
          height: height,
          width: width,
        ),
      );
    }

    bool isToday = correspondsDate(day, DateTime.now());
    TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: isToday ? theme.accentTextTheme.display1.color : theme.textTheme.display1.color,
      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
    );
    return Container(
      padding: EdgeInsets.all(5),
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(formatWeekDay(day), style: textStyle),
          Text(formatDate(day), style: textStyle),
        ],
      ),
    );
  }

  String formatWeekDay(DateTime date) => DateFormat('EEEE').format(date);
  String formatDate(DateTime date) => DateFormat('dd.MM.yyyy').format(date);
}
