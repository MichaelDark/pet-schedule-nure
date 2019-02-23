import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/util/date_utils.dart';
import 'package:nure_schedule/model/time_range.dart';

class NurePair extends TimeRange {
  static final NurePair first = NurePair._(0, _timeToDatetime(07, 45), _timeToDatetime(09, 20));
  static final NurePair second = NurePair._(1, _timeToDatetime(09, 30), _timeToDatetime(11, 05));
  static final NurePair third = NurePair._(2, _timeToDatetime(11, 15), _timeToDatetime(12, 50));
  static final NurePair fourth = NurePair._(3, _timeToDatetime(13, 10), _timeToDatetime(14, 45));
  static final NurePair fifth = NurePair._(4, _timeToDatetime(14, 55), _timeToDatetime(16, 30));
  static final NurePair sixth = NurePair._(5, _timeToDatetime(16, 40), _timeToDatetime(18, 15));
  static final NurePair seventh = NurePair._(6, _timeToDatetime(18, 25), _timeToDatetime(20, 00));

  static final List<NurePair> values = [
    first,
    second,
    third,
    fourth,
    fifth,
    sixth,
    seventh,
  ];

  static DateTime _timeToDatetime(int hour, int minute) => DateTime(2019, 01, 01, hour, minute);

  static NurePair getByTime(Event event) {
    for (NurePair pair in values) {
      if (correspondsTime(pair.timeStart, event.timeStart) && correspondsTime(pair.timeEnd, event.timeEnd)) {
        return pair;
      }
    }
    return null;
  }

  final int id;

  NurePair._(this.id, DateTime timeStart, DateTime timeEnd) : super(timeStart, timeEnd);
}
