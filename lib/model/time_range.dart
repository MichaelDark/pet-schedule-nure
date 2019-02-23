import 'package:nure_schedule/util/date_utils.dart';

abstract class ITimeRange {
  DateTime timeStart;
  DateTime timeEnd;

  ITimeRange(this.timeStart, this.timeEnd);

  int get timeId => timeStart.hour * 100 + timeStart.minute;
  String timeStartString() => timeToString(timeStart);
  String timeEndString() => timeToString(timeEnd);

  bool equalsByTime(ITimeRange range) {
    return correspondsTime(timeStart, range.timeStart) && correspondsTime(timeEnd, range.timeEnd);
  }
}

class TimeRange extends ITimeRange {
  TimeRange.copy(ITimeRange range) : super(range.timeStart, range.timeEnd);
}
