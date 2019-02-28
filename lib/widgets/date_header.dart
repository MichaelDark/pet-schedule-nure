import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nure_schedule/scoped_model/main_model.dart';
import 'package:nure_schedule/util/date_utils.dart';
import 'package:scoped_model/scoped_model.dart';

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
      return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, _, MainModel model) {
          return SizedBox(
            height: height,
            width: width,
            // child: Icon(model.colorBrightness == Brightness.dark ? Icons.brightness_5 : Icons.brightness_3),
          );
        },
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
}
