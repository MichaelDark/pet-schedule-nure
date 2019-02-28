import 'package:flutter/material.dart';
import 'package:nure_schedule/widgets/date_header.dart';

class ScheduleController extends ChangeNotifier {
  final DateTime initialDay;
  final DateTime minPossibleDate;
  final double _screenWidth;
  ScrollController _scrollController = ScrollController();
  int _daysPerPage;

  ScheduleController(
    BuildContext context, {
    DateTime initialDay,
    DateTime minDate,
    int daysPerPage,
  })  : initialDay = initialDay ?? DateTime.now(),
        minPossibleDate = minDate ?? DateTime(2018),
        _screenWidth = MediaQuery.of(context).size.width,
        _daysPerPage = daysPerPage != null && daysPerPage > 1 ? daysPerPage : 3;

  int get daysPerPage => _daysPerPage;

  ScrollController get scrollController => _scrollController;

  bool canDisplayDate(DateTime date) => date.isAfter(minPossibleDate);

  double calculateDayWidth() {
    double screenWidth = _screenWidth - headersSize;
    double dayWidth = screenWidth / _daysPerPage;
    return dayWidth;
  }

  void calculateInitialOffset() {
    if (canDisplayDate(initialDay)) {
      int daysFromMinDate = getDaysFromMinDate(initialDay);
      double scrollOffset = calculateOffset(daysFromMinDate);
      _scrollController = ScrollController(initialScrollOffset: scrollOffset);
    } else {
      _scrollController = ScrollController();
    }
  }

  double calculateOffset(int daysFromMinDate) {
    return daysFromMinDate * calculateDayWidth();
  }

  void jumpTo(DateTime date) {
    if (canDisplayDate(date)) {
      int daysFromMinDate = getDaysFromMinDate(date);
      double scrollOffset = calculateOffset(daysFromMinDate);
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
