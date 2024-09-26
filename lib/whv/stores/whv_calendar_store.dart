import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart' as intl;
part 'whv_calendar_store.g.dart';

class WhvCalendarStore = _WhvCalendarStoreBase with _$WhvCalendarStore;

abstract class _WhvCalendarStoreBase with Store {
  @observable
  bool isLoading = false;
  @observable
  bool isShowYearsView = false;
  @observable
  DateTime focusedDay = DateTime.now();
  @observable
  DateTime? selectedDay;
  @observable
  List<DateTime> months = [];
  @observable
  var monthsScrollCon = ScrollController();
  @observable
  var calendarPageCon = PageController();
  @observable
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @observable
  var kfirstDay = DateTime(1900);
  @observable
  var kfirstDateOutDay = DateTime(1900);
  @observable
  var klastDay = DateTime(2100);

  toggleIxShowYearsView({bool? value}) {
    isShowYearsView = value ?? !isShowYearsView;
  }

  setInitialFoucsDate() {
    if (focusedDay != DateTime.now()) {
      focusedDay = DateTime.now();
      selectedDay = null;
    }
    selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

    isShowYearsView = false;
  }

  @action
  void onDaySelected(DateTime slectedDay, DateTime fcusedDay) {
    selectedDay = slectedDay;
    selectedDate = slectedDay;
    focusedDay = fcusedDay;
  }

  @action
  void getMonthsBetweenDates(DateTime startDate, DateTime endDate) {
    final List<DateTime> mmonths = [];

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      mmonths.add(currentDate);
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    }

    months = List.from(mmonths);
  }

  @action
  List<int> getYearsBetweenDates(DateTime startDate, DateTime endDate) {
    List<int> years = [];
    for (int year = startDate.year; year <= endDate.year; year++) {
      years.add(year);
    }
    return years;
  }

  @action
  gotoParticularMonth(int index) {
    calendarPageCon.animateToPage(
      index,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut,
    );
  }


  @action
  gotoParticularMonthByName(DateTime month) {
    var index = months.indexOf(month);
    calendarPageCon.animateToPage(
      index,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut,
    );
  }

  @action
  bool datesAreEqual(DateTime date1, DateTime date2) {
    final DateTime normalizedDate1 =
        DateTime(date1.year, date1.month, date1.day);
    final DateTime normalizedDate2 =
        DateTime(date2.year, date2.month, date2.day);

    return normalizedDate1.isAtSameMomentAs(normalizedDate2);
  }

  @action
  void scrollToListItem(DateTime targetDate) {
    final index = months.indexOf(targetDate);
    if (index != -1) {
      double totalWidth = 0.0;

      // Calculate the total width of items before the target date
      for (int i = 0; i < index; i++) {
        String monthName = formateDateToAbbrMonth(months[i]);
        double textWidth = _calculateTextWidth(
            monthName,
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ));
        totalWidth += textWidth; // Add the width and padding
      }

      monthsScrollCon.animateTo(
        totalWidth,
        duration: Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Use a different curve if desired
      );
    }
  }

  @action
  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.width;
  }

  @action
  String formateDateToAbbrMonth(DateTime month) {
    return intl.DateFormat("MMMM").format(month);
  }

  @action
  String formatedmonthYear({DateTime? date}) {
    return intl.DateFormat("MMM, yyyy").format(date ?? selectedDate);
  }

  @action
  String formatedAbbrDayDateMonthYear({DateTime? date}) {
    return intl.DateFormat("E d MMM, y").format(date ?? selectedDate);
  }

  @action
  setSeletedYear(int year) {
    selectedDate = DateTime(year, selectedDate.month, 1);
  }

  @action
  setSeletedMonth(DateTime mont) {
    selectedDate =
        mont; //DateTime(selectedDate.year, mont.month, selectedDate.day);
  }

  @action
  setSelectedDate() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDay?.day ?? 1);
  }

  @action
  resetSeletedDate() {
    selectedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  }
}
