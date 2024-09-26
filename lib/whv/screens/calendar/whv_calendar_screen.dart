import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/components/calendar/whv_calendar_widget.dart';
import 'package:socialv/whv/components/calendar/whv_calendar_year_widget.dart';

import '../../../components/loading_widget.dart';
import '../../constants/whv_constants.dart';
import '../../constants/whv_new_wishlist_constants.dart';
import '../../network/whv_rest_apis.dart';
import '../wishlists/whv_final_wish_wizard_screen.dart';

class WhvCalendarScreen extends StatefulWidget {
  final bool isFromMyWishlistsScreen;
  const WhvCalendarScreen({super.key, this.isFromMyWishlistsScreen = false});

  @override
  State<WhvCalendarScreen> createState() => _WhvCalendarScreenState();
}

class _WhvCalendarScreenState extends State<WhvCalendarScreen> {
  // bool isShowYearsView = false;

  @override
  void initState() {
    super.initState();
    DateTime start = DateTime(
      whvCalendarStore.selectedDay?.year ?? whvCalendarStore.selectedDate.year,
    );
    DateTime last = DateTime(
        whvCalendarStore.selectedDay?.year ??
            whvCalendarStore.selectedDate.year,
        12,
        31);
    whvCalendarStore.getMonthsBetweenDates(start, last);
    whvCalendarStore.setInitialFoucsDate();
  }

  tryCreateNewWishlist() async {
    try {
      Map body = {};
      body['userId'] = appStore.loginUserId;
      body['wishlistName'] = addToWishlistStore.wishlistName.text.trim();
      body['dueDate'] = addToWishlistStore.whvDueDate ?? WhvConstants.WhvNONE;
      body['wishlistComment'] = addToWishlistStore.wishlistComment.text.trim();
      body['wishlistPrivacy'] =
          addToWishlistStore.wishlistPrivacy.toLowerCase();
      appStore.setLoading(true);
      await whvCreateNewWishlist(requestBody: body).then((response) async {
        appStore.setLoading(false);
        if (response.status.toLowerCase() ==
            WhvConstants.WhvSuccess.toLowerCase()) {
          finish(context);
          finish(context);
          toast(
              "${response.title} ${whvLanguage.wishlistCreateSuccessMessage}");
        } else {
          appStore.setLoading(false);
          toast("${response.title} ${response.message}");
        }
      });
    } catch (e) {
      print('create new wishlist exception $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValidated = whvCalendarStore.selectedDay != null;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          whvLanguage.calendar,
          style: TextStyle(
            color: context.iconColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (isFormValidated) {
                addToWishlistStore
                    .setSelectedDate(whvCalendarStore.selectedDay!);
                if (widget.isFromMyWishlistsScreen) {
                  tryCreateNewWishlist();
                } else {
                  WhvFinalWishWizardScreen().launch(context);
                }
              }
            },
            child: Container(
              height: 8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: !isFormValidated
                      ? context.primaryColor.withOpacity(0.2)
                      : context.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Center(
                child: Text(
                  language.done,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: !isFormValidated
                          ? context.primaryColor
                          : context.cardColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                18.height,
                Text(
                  whvLanguage.setDate,
                  style: TextStyle(
                    color: context.cardColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                18.height,
                Expanded(
                    child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Observer(builder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        35.height,
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: context.cardColor,
                                barrierColor: Colors.black38,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30))),
                                builder: (BuildContext context) {
                                  return WhvCalendarYearView(
                                    onYearConfirm: () {
                                      whvCalendarStore.selectedDay =
                                          whvCalendarStore.selectedDay ??
                                              whvCalendarStore.selectedDate;
                                      DateTime start = DateTime(
                                        whvCalendarStore.selectedDay?.year ??
                                            whvCalendarStore.selectedDate.year,
                                      );
                                      DateTime last = DateTime(
                                          whvCalendarStore.selectedDay?.year ??
                                              whvCalendarStore
                                                  .selectedDate.year,
                                          12,
                                          31);
                                      whvCalendarStore.focusedDay =
                                          whvCalendarStore.selectedDay ?? start;
                                      whvCalendarStore.getMonthsBetweenDates(
                                          start, last);
                                      setState(() {});
                                    },
                                  );
                                });
                            // whvCalendarStore.toggleIxShowYearsView();
                            // setState(() {
                            //   // isShowYearsView = !isShowYearsView;
                            // });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SvgPicture.asset(
                                    ic_wish_calendar,
                                    color: context.primaryColor,
                                    height: 40,
                                  ),
                                  10.height,
                                  Text(
                                    "${whvCalendarStore.selectedDay?.year ?? whvCalendarStore.selectedDate.year}",
                                    style: TextStyle(
                                      color: context.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: context.primaryColor,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                        30.height,
                        Expanded(child:
                            SingleChildScrollView(child: WhvCalendarWidget(
                          onYearConfirm: () {
                            DateTime start = DateTime(
                              whvCalendarStore.selectedDay?.year ??
                                  whvCalendarStore.selectedDate.year,
                            );
                            DateTime last = DateTime(
                                whvCalendarStore.selectedDay?.year ??
                                    whvCalendarStore.selectedDate.year,
                                12,
                                31);
                            whvCalendarStore.getMonthsBetweenDates(start, last);
                            setState(() {});
                          },
                        ))),
                      ],
                    );
                  }),
                ))
              ],
            ),
          ),
          Observer(
            builder: (_) {
              if (appStore.isLoading) {
                return Positioned(
                  child: LoadingWidget(
                    isBlurBackground: true,
                  ),
                );
              } else {
                return Offstage();
              }
            },
          ),
        ],
      ),
    );
  }
}
