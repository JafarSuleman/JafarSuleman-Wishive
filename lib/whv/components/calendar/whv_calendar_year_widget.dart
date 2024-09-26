import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart' as intl;
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

class WhvCalendarYearView extends StatefulWidget {
  final void Function() onYearConfirm;
  const WhvCalendarYearView({super.key, required this.onYearConfirm});

  @override
  State<WhvCalendarYearView> createState() => _WhvCalendarYearViewState();
}

class _WhvCalendarYearViewState extends State<WhvCalendarYearView> {

  final ScrollController _scrollController = ScrollController();
  List<GlobalKey> _yearKeys = [];
  List<GlobalKey> _monthKeys = [];
  bool isYearScrolled = false;
  bool isMonthScrolled = false;


  void _scrollToIndex(int index, List<GlobalKey>keys) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final keyContext = keys[index].currentContext;
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
  void initState() {
    super.initState();
    DateTime start = DateTime(whvCalendarStore.selectedDate.year,);
    DateTime last = DateTime(whvCalendarStore.selectedDate.year,12,31);
    whvCalendarStore.getMonthsBetweenDates(start, last);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.height,
          Text(
            whvCalendarStore.formatedAbbrDayDateMonthYear(),
            style: TextStyle(
                fontSize: 16,
                color: context.primaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
          // Observer(builder: (_) {
          //   return Text(
          //     whvCalendarStore.formatedAbbrDayDateMonthYear(),
          //     style: TextStyle(
          //         fontSize: 16,
          //         color: context.primaryColor,
          //         fontWeight: FontWeight.bold
          //     ),
          //   );
          // }),
          60.height,
          Divider(color: const Color(0xFFBCC0C6), thickness: 0.5,),
          SizedBox(
            height: 30,
            width: 260,
            child: Observer(builder: (_) {
              return ListView.builder(
                controller: whvCalendarStore.monthsScrollCon,
                itemCount: whvCalendarStore.months.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  DateTime month = whvCalendarStore.months[index];
                  bool isSeleted = whvCalendarStore.datesAreEqual(whvCalendarStore.selectedDate, month);
                  if(!isMonthScrolled && isSeleted){
                    _scrollToIndex(index, _monthKeys);
                    isMonthScrolled = true;
                  }
                  return InkWell(
                    key: _monthKeys[index],
                    onTap: () {
                      whvCalendarStore.setSeletedMonth(month);
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        intl.DateFormat("MMMM").format(month),
                        style: TextStyle(
                            color: isSeleted
                                ? context.primaryColor
                                : context.dividerColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Divider(color: const Color(0xFFBCC0C6), thickness: 0.5,),
          20.height,
          SizedBox(
            width: 150,
            child: Column(
              children: [
                Divider(color: const Color(0xFFBCC0C6), thickness: 0.5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 10.0, // Adjust the spacing as needed
                      runSpacing: 10.0, // Adjust the run spacing as needed
                      children: getYearsBetweenDates().map((data) {
                        int year = data.values.first;
                        int index = data.keys.first;
                        bool isSeleted = whvCalendarStore.selectedDate.year == year;
                        if(!isYearScrolled && isSeleted){
                          _scrollToIndex(index, _yearKeys);
                          isYearScrolled = true;
                        }
                        return InkWell(
                          key: _yearKeys[index],
                          onTap: () {
                            whvCalendarStore.setSeletedYear(year);
                            DateTime start = DateTime(whvCalendarStore.selectedDate.year,);
                            DateTime end = DateTime(whvCalendarStore.selectedDate.year,12,31);
                            whvCalendarStore.getMonthsBetweenDates(start, end);
                            // if (DateTime.now().year < year) {
                            //   whvCalendarStore.scrollToListItem(DateTime(year, 1, 1));
                            //   whvCalendarStore.setSeletedMonth(DateTime(year, 1, 1));
                            // } else {
                            whvCalendarStore.scrollToListItem(start);
                            whvCalendarStore.setSeletedMonth(start);
                            // }

                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              year.toString(),
                              style: TextStyle(
                                  color: isSeleted
                                      ? context.primaryColor
                                      : context.dividerColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Divider(color: const Color(0xFFBCC0C6), thickness: 0.5,),
              ],
            ),
          ),
          60.height,
          InkWell(
            onTap: () {

              if (whvCalendarStore.selectedDate.month == whvCalendarStore.kfirstDay.month) {
                whvCalendarStore.focusedDay = DateTime.now();
              } else {
                whvCalendarStore.focusedDay = whvCalendarStore.selectedDate;
              }
              DateTime selection = whvCalendarStore.selectedDate;
              whvCalendarStore.selectedDay = DateTime(selection.year, selection.month,whvCalendarStore.selectedDay?.day??selection.day);
              widget.onYearConfirm.call();
              finish(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: context.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 28,
                color: context.cardColor,
              ),
            ),
          ),
          80.height,
        ],
      ),
    );
  }

  List<Map<int, int>>getYearsBetweenDates(){
    List<Map<int, int>> result = <Map<int, int>>[];
    List<int> years = whvCalendarStore.getYearsBetweenDates(
      whvCalendarStore.kfirstDay,
      whvCalendarStore.klastDay,
    );
    int totalYears = years.length;
    _monthKeys = [];
    _yearKeys = [];
    _yearKeys = List.generate(totalYears, (index){
      result.add({
        index :  years[index],
      });
      _monthKeys.add(GlobalKey());
      return GlobalKey();
    });
    return result;
  }
}
