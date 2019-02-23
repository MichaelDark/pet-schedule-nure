import 'package:intl/intl.dart';

abstract class TimeRange {
  DateTime timeStart;
  DateTime timeEnd;

  TimeRange(this.timeStart, this.timeEnd);

  String timeToString(DateTime time) => DateFormat('hh:mm').format(time);
  String timeStartString() => timeToString(timeStart);
  String timeEndString() => timeToString(timeStart);
}
