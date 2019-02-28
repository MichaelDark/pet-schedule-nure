import 'package:intl/intl.dart';

DateTime parseDate(String dateString, String timeString) {
  List<String> dateList = dateString.trim().split('.');
  List<String> timeList = timeString.trim().split(':');
  DateTime date = DateTime(int.parse(dateList[2]), int.parse(dateList[1]), int.parse(dateList[0]));
  DateTime datetime = date.add(Duration(hours: int.parse(timeList[0]), minutes: int.parse(timeList[1])));
  return datetime;
}

bool correspondsDate(DateTime date, DateTime checkableDate) {
  return date.year == checkableDate.year && date.month == checkableDate.month && date.day == checkableDate.day;
}

bool correspondsTime(DateTime date, DateTime checkableDate) {
  return date.hour == checkableDate.hour && date.minute == checkableDate.minute;
}

String timeToString(DateTime time) => DateFormat('Hm').format(time);

String formatWeekDay(DateTime date) => DateFormat('EEEE').format(date);
String formatDate(DateTime date) => DateFormat('dd.MM.yyyy').format(date);
