import 'package:flutter/material.dart';

class DayPagerController extends ChangeNotifier {
  final DateTime initialDay;
  final DateTime minDate;
  ScrollController _scrollController = ScrollController();
  int _daysPerPage;

  DayPagerController({
    DateTime initialDay,
    DateTime minDate,
    int daysPerPage,
  })  : initialDay = initialDay ?? DateTime.now(),
        minDate = minDate ?? DateTime(2018),
        _daysPerPage = daysPerPage != null && daysPerPage > 1 ? daysPerPage : 3;

  ScrollController get scrollController => _scrollController;

  bool canDisplayDate(DateTime date) => date.isAfter(minDate);

  double calculateDayWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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

  int getDaysFromMinDate(DateTime date) => minDate.difference(date).inDays.abs();
  DateTime getDate(int daysFromMinDate) => minDate.add(Duration(days: daysFromMinDate));

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
