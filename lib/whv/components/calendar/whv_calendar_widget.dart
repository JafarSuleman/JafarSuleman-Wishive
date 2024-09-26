import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class WhvCalendarWidget extends StatefulWidget {
  final void Function() onYearConfirm;
  const WhvCalendarWidget({super.key, required this.onYearConfirm});

  @override
  State<WhvCalendarWidget> createState() => _WhvCalendarWidgetState();
}

class _WhvCalendarWidgetState extends State<WhvCalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool isScrolledToMonth = false;
  List<GlobalKey>_keys = List.generate(whvCalendarStore.months.length, (index) => GlobalKey());


  void scrollToSelectedMonth(int index){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final keyContext = _keys[index].currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return TableCalendar(
        daysOfWeekHeight: 18,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          weekendStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14, color: Colors.yellow.shade900),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return Column(
              children: [
                Divider(color: const Color(0xFFBCC0C6), thickness: 1.5,),
                5.height,
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    controller: whvCalendarStore.monthsScrollCon,
                    itemCount: whvCalendarStore.months.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime month = whvCalendarStore.months[index];
                      bool isSeleted = whvCalendarStore.datesAreEqual(DateTime(day.year, day.month, 1), month);
                      if(!isScrolledToMonth && isSeleted){
                        isScrolledToMonth = true;
                        scrollToSelectedMonth(index);
                      }
                      return InkWell(
                        key: _keys[index],
                        onTap: () {
                          if(isSeleted){
                            return;
                          }
                          whvCalendarStore.setSeletedMonth(month);
                          int difference = differenceInMonths(whvCalendarStore.kfirstDay, month);
                          whvCalendarStore.gotoParticularMonth(difference);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            intl.DateFormat("MMMM").format(month),
                            style: TextStyle(
                                color: isSeleted
                                    ? context.primaryColor
                                    : context.dividerColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                5.height,
                Divider(color: const Color(0xFFBCC0C6), thickness: 1.5,),
                30.height,
              ],
            );
          },
          todayBuilder: (context, day, day2) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow.shade900,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(intl.DateFormat('dd').format(day),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.yellow.shade900)),
              ),
            );
          },
        ),
        firstDay: whvCalendarStore.kfirstDay,
        lastDay: whvCalendarStore.klastDay,
        focusedDay: whvCalendarStore.focusedDay,
        selectedDayPredicate: (day) => isSameDay((whvCalendarStore.selectedDay??whvCalendarStore.selectedDate), day),
        calendarFormat: _calendarFormat,
        // eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        headerStyle: HeaderStyle(
            leftChevronIcon: SizedBox(),
            rightChevronIcon: SizedBox(),
            formatButtonDecoration: BoxDecoration(
                color: Theme.of(context).textTheme.bodyMedium!.color)),
        calendarStyle: CalendarStyle(
          tablePadding: EdgeInsets.zero,
          markerDecoration: BoxDecoration(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              shape: BoxShape.circle),
          defaultTextStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          weekendTextStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14, color: Colors.yellow.shade900),
          outsideDaysVisible: false,
        ),
        onDaySelected: (date1,date2,){
          whvCalendarStore.onDaySelected(date1,date2,);
          widget.onYearConfirm.call();
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          DateTime start = DateTime(focusedDay.year,);
          DateTime last = DateTime(focusedDay.year,12,31);
          whvCalendarStore.getMonthsBetweenDates(start, last);
          whvCalendarStore.scrollToListItem(DateTime(focusedDay.year, focusedDay.month, focusedDay.day));
        },
        onCalendarCreated: (pageController) {
          whvCalendarStore.calendarPageCon = pageController;
        },
      );
    });
  }

  int differenceInMonths(DateTime date1, DateTime date2) {
    int yearsDiff = date2.year - date1.year;
    int monthsDiff = date2.month - date1.month;
    return yearsDiff * 12 + monthsDiff;
  }
}
