import 'package:nure_schedule/api/model/event.dart';
import 'package:nure_schedule/api/util/date_utils.dart';

class NurePair {
  static final NurePair first = NurePair._(0, formatTime(07, 45), formatTime(09, 20));
  static final NurePair second = NurePair._(1, formatTime(09, 30), formatTime(11, 05));
  static final NurePair third = NurePair._(2, formatTime(11, 15), formatTime(12, 50));
  static final NurePair fourth = NurePair._(3, formatTime(13, 10), formatTime(14, 45));
  static final NurePair fifth = NurePair._(4, formatTime(14, 55), formatTime(16, 30));
  static final NurePair sixth = NurePair._(5, formatTime(16, 40), formatTime(18, 15));
  static final NurePair seventh = NurePair._(6, formatTime(18, 25), formatTime(20, 00));

  static final List<NurePair> values = [
    first,
    second,
    third,
    fourth,
    fifth,
    sixth,
    seventh,
  ];

  static DateTime formatTime(int hour, int minute) => DateTime(2019, 01, 01, hour, minute);

  static NurePair getByTime(Event event) {
    for (NurePair pair in values) {
      if (correspondsTime(pair.timeStart, event.datetimeStart) && correspondsTime(pair.timeEnd, event.datetimeEnd)) {
        return pair;
      }
    }
    return null;
  }

  final int id;
  final DateTime timeStart;
  final DateTime timeEnd;

  NurePair._(this.id, this.timeStart, this.timeEnd);
}
