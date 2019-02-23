import 'package:flutter/material.dart';
import 'package:nure_schedule/widgets/date_header.dart';

class ScheduleController extends ChangeNotifier {
  final DateTime initialDay;
  final DateTime minPossibleDate;
  ScrollController _scrollController = ScrollController();
  int _daysPerPage;

  ScheduleController({
    DateTime initialDay,
    DateTime minDate,
    int daysPerPage,
  })  : initialDay = initialDay ?? DateTime.now(),
        minPossibleDate = minDate ?? DateTime(2018),
        _daysPerPage = daysPerPage != null && daysPerPage > 1 ? daysPerPage : 3;

  ScrollController get scrollController => _scrollController;

  bool canDisplayDate(DateTime date) => date.isAfter(minPossibleDate);

  double calculateDayWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - headersSize;
    double dayWidth = screenWidth / _daysPerPage;
    return dayWidth;
  }

  void calculateInitialOffset(BuildContext context) {
    if (canDisplayDate(initialDay)) {
      int daysFromMinDate = getDaysFromMinDate(initialDay);
      double scrollOffset = calculateOffset(context, daysFromMinDate);
      _scrollController = ScrollController(initialScrollOffset: scrollOffset);
    } else {
      _scrollController = ScrollController();
    }
  }

  double calculateOffset(BuildContext context, int daysFromMinDate) {
    return daysFromMinDate * calculateDayWidth(context);
  }

  void jumpTo(BuildContext context, DateTime date) {
    if (canDisplayDate(date)) {
      int daysFromMinDate = getDaysFromMinDate(date);
      double scrollOffset = calculateOffset(context, daysFromMinDate);
      scrollController.animateTo(
        scrollOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  int getDaysFromMinDate(DateTime date) => minPossibleDate.difference(date).inDays.abs();
  DateTime getDate(int daysFromMinDate) => minPossibleDate.add(Duration(days: daysFromMinDate));

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
