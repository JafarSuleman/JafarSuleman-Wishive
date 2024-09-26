// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_calendar_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvCalendarStore on _WhvCalendarStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_WhvCalendarStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isShowYearsViewAtom =
      Atom(name: '_WhvCalendarStoreBase.isShowYearsView', context: context);

  @override
  bool get isShowYearsView {
    _$isShowYearsViewAtom.reportRead();
    return super.isShowYearsView;
  }

  @override
  set isShowYearsView(bool value) {
    _$isShowYearsViewAtom.reportWrite(value, super.isShowYearsView, () {
      super.isShowYearsView = value;
    });
  }

  late final _$focusedDayAtom =
      Atom(name: '_WhvCalendarStoreBase.focusedDay', context: context);

  @override
  DateTime get focusedDay {
    _$focusedDayAtom.reportRead();
    return super.focusedDay;
  }

  @override
  set focusedDay(DateTime value) {
    _$focusedDayAtom.reportWrite(value, super.focusedDay, () {
      super.focusedDay = value;
    });
  }

  late final _$selectedDayAtom =
      Atom(name: '_WhvCalendarStoreBase.selectedDay', context: context);

  @override
  DateTime? get selectedDay {
    _$selectedDayAtom.reportRead();
    return super.selectedDay;
  }

  @override
  set selectedDay(DateTime? value) {
    _$selectedDayAtom.reportWrite(value, super.selectedDay, () {
      super.selectedDay = value;
    });
  }

  late final _$monthsAtom =
      Atom(name: '_WhvCalendarStoreBase.months', context: context);

  @override
  List<DateTime> get months {
    _$monthsAtom.reportRead();
    return super.months;
  }

  @override
  set months(List<DateTime> value) {
    _$monthsAtom.reportWrite(value, super.months, () {
      super.months = value;
    });
  }

  late final _$monthsScrollConAtom =
      Atom(name: '_WhvCalendarStoreBase.monthsScrollCon', context: context);

  @override
  ScrollController get monthsScrollCon {
    _$monthsScrollConAtom.reportRead();
    return super.monthsScrollCon;
  }

  @override
  set monthsScrollCon(ScrollController value) {
    _$monthsScrollConAtom.reportWrite(value, super.monthsScrollCon, () {
      super.monthsScrollCon = value;
    });
  }

  late final _$calendarPageConAtom =
      Atom(name: '_WhvCalendarStoreBase.calendarPageCon', context: context);

  @override
  PageController get calendarPageCon {
    _$calendarPageConAtom.reportRead();
    return super.calendarPageCon;
  }

  @override
  set calendarPageCon(PageController value) {
    _$calendarPageConAtom.reportWrite(value, super.calendarPageCon, () {
      super.calendarPageCon = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_WhvCalendarStoreBase.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$kfirstDayAtom =
      Atom(name: '_WhvCalendarStoreBase.kfirstDay', context: context);

  @override
  DateTime get kfirstDay {
    _$kfirstDayAtom.reportRead();
    return super.kfirstDay;
  }

  @override
  set kfirstDay(DateTime value) {
    _$kfirstDayAtom.reportWrite(value, super.kfirstDay, () {
      super.kfirstDay = value;
    });
  }

  late final _$kfirstDateOutDayAtom =
      Atom(name: '_WhvCalendarStoreBase.kfirstDateOutDay', context: context);

  @override
  DateTime get kfirstDateOutDay {
    _$kfirstDateOutDayAtom.reportRead();
    return super.kfirstDateOutDay;
  }

  @override
  set kfirstDateOutDay(DateTime value) {
    _$kfirstDateOutDayAtom.reportWrite(value, super.kfirstDateOutDay, () {
      super.kfirstDateOutDay = value;
    });
  }

  late final _$klastDayAtom =
      Atom(name: '_WhvCalendarStoreBase.klastDay', context: context);

  @override
  DateTime get klastDay {
    _$klastDayAtom.reportRead();
    return super.klastDay;
  }

  @override
  set klastDay(DateTime value) {
    _$klastDayAtom.reportWrite(value, super.klastDay, () {
      super.klastDay = value;
    });
  }

  late final _$_WhvCalendarStoreBaseActionController =
      ActionController(name: '_WhvCalendarStoreBase', context: context);

  @override
  void onDaySelected(DateTime slectedDay, DateTime fcusedDay) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.onDaySelected');
    try {
      return super.onDaySelected(slectedDay, fcusedDay);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getMonthsBetweenDates(DateTime startDate, DateTime endDate) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.getMonthsBetweenDates');
    try {
      return super.getMonthsBetweenDates(startDate, endDate);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<int> getYearsBetweenDates(DateTime startDate, DateTime endDate) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.getYearsBetweenDates');
    try {
      return super.getYearsBetweenDates(startDate, endDate);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic gotoParticularMonth(int index) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.gotoParticularMonth');
    try {
      return super.gotoParticularMonth(index);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic gotoParticularMonthByName(DateTime month) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.gotoParticularMonthByName');
    try {
      return super.gotoParticularMonthByName(month);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool datesAreEqual(DateTime date1, DateTime date2) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.datesAreEqual');
    try {
      return super.datesAreEqual(date1, date2);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void scrollToListItem(DateTime targetDate) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.scrollToListItem');
    try {
      return super.scrollToListItem(targetDate);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double _calculateTextWidth(String text, TextStyle style) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase._calculateTextWidth');
    try {
      return super._calculateTextWidth(text, style);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String formateDateToAbbrMonth(DateTime month) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.formateDateToAbbrMonth');
    try {
      return super.formateDateToAbbrMonth(month);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String formatedmonthYear({DateTime? date}) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.formatedmonthYear');
    try {
      return super.formatedmonthYear(date: date);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String formatedAbbrDayDateMonthYear({DateTime? date}) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.formatedAbbrDayDateMonthYear');
    try {
      return super.formatedAbbrDayDateMonthYear(date: date);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSeletedYear(int year) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.setSeletedYear');
    try {
      return super.setSeletedYear(year);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSeletedMonth(DateTime mont) {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.setSeletedMonth');
    try {
      return super.setSeletedMonth(mont);
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedDate() {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.setSelectedDate');
    try {
      return super.setSelectedDate();
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetSeletedDate() {
    final _$actionInfo = _$_WhvCalendarStoreBaseActionController.startAction(
        name: '_WhvCalendarStoreBase.resetSeletedDate');
    try {
      return super.resetSeletedDate();
    } finally {
      _$_WhvCalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isShowYearsView: ${isShowYearsView},
focusedDay: ${focusedDay},
selectedDay: ${selectedDay},
months: ${months},
monthsScrollCon: ${monthsScrollCon},
calendarPageCon: ${calendarPageCon},
selectedDate: ${selectedDate},
kfirstDay: ${kfirstDay},
kfirstDateOutDay: ${kfirstDateOutDay},
klastDay: ${klastDay}
    ''';
  }
}
