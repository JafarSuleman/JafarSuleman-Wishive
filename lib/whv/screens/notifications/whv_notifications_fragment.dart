import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/notifications/notification_model.dart';
import 'package:socialv/network/rest_apis.dart';
import 'package:socialv/screens/notification/components/notification_widget.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/screens/main/whv_main_screen.dart';

class WhvNotificationFragment extends StatefulWidget {
  final ScrollController controller;

  const WhvNotificationFragment({required this.controller});

  @override
  State<WhvNotificationFragment> createState() =>
      _WhvNotificationFragmentState();
}

class _WhvNotificationFragmentState extends State<WhvNotificationFragment>
    with TickerProviderStateMixin {
  List<NotificationModel> notificationList = [];
  late Future<List<NotificationModel>> future;

  ScrollController controller = ScrollController();

  late AnimationController _animationController;

  int mPage = 1;
  bool mIsLastPage = false;
  bool isError = false;

  @override
  void initState() {
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(milliseconds: 500);
    _animationController.drive(CurveTween(curve: Curves.easeOutQuad));
    future = getList();
    super.initState();
    init();

    widget.controller.addListener(() {
      /// pagination
      if (selectedIndex == 3) {
        if (widget.controller.position.pixels ==
            widget.controller.position.maxScrollExtent) {
          if (!mIsLastPage) {
            mPage++;
            setState(() {});

            future = getList();
          }
        }
      }
    });

    LiveStream().on(RefreshNotifications, (p0) {
      notificationList.clear();
      mPage = 1;
      future = getList();
    });
  }

  Future<void> init() async {
    appStore.setLoading(true);
    appStore.setNotificationCount(0);
  }

  Future<List<NotificationModel>> getList() async {
    appStore.setLoading(true);
    await notificationsList(page: mPage).then((value) {
      if (mPage == 1) notificationList.clear();
      mIsLastPage = value.length != 20;
      notificationList.addAll(value);
      setState(() {});

      appStore.setLoading(false);
    }).catchError((e) {
      isError = true;
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });

    return notificationList;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();

    LiveStream().dispose(RefreshNotifications);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.topCenter,
        children: [
          FutureBuilder<List<NotificationModel>>(
            future: future,
            builder: (ctx, snap) {
              if (snap.hasError) {
                return SizedBox(
                  height: context.height() * 0.8,
                  child: NoDataWidget(
                    imageWidget: NoDataLottieWidget(),
                    title: isError
                        ? language.somethingWentWrong
                        : language.noDataFound,
                    onRetry: () {
                      isError = false;
                      LiveStream().emit(RefreshNotifications);
                    },
                    retryText: '   ${language.clickToRefresh}   ',
                  ).center(),
                );
              }

              if (snap.hasData) {
                if (snap.data.validate().isEmpty && !appStore.isLoading) {
                  return SizedBox(
                    height: context.height() * 0.8,
                    child: NoDataWidget(
                      imageWidget: NoDataLottieWidget(),
                      title: isError
                          ? language.somethingWentWrong
                          : language.noDataFound,
                      onRetry: () {
                        isError = false;
                        LiveStream().emit(RefreshNotifications);
                      },
                      retryText: '   ${language.clickToRefresh}   ',
                    ).center(),
                  );
                } else {
                  return AnimatedListView(
                    padding: EdgeInsets.only(
                        bottom: 60, top: notificationList.isNotEmpty ? 52 : 8),
                    shrinkWrap: true,
                    slideConfiguration: SlideConfiguration(
                        delay: 80.milliseconds, verticalOffset: 300),
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: notificationList[index].isNew == 1
                            ? context.cardColor
                            : context.scaffoldBackgroundColor,
                        child: NotificationWidget(
                          notificationModel: notificationList[index],
                          callback: () {
                            mPage = 1;
                            future = getList();
                          },
                        ),
                      );
                    },
                  );
                }
              }
              return LoadingWidget().visible(!appStore.isLoading);
            },
          ),
          if (notificationList.isNotEmpty)
            Positioned(
              top: 16,
              right: 16,
              child: TextIcon(
                prefix: cachedImage(ic_delete,
                    color: Colors.red,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover),
                text: language.clearAll,
                textStyle: primaryTextStyle(color: Colors.red),
                onTap: () async {
                  appStore.setLoading(true);
                  await clearNotification().then((value) {
                    mPage = 1;
                    future = getList();
                  }).catchError((error) {
                    toast(error.toString());
                    appStore.setLoading(false);
                  });
                },
              ),
            ),
          if (appStore.isLoading)
            Positioned(
              bottom: mPage != 1 ? 10 : null,
              child: LoadingWidget(isBlurBackground: false)
                  .paddingTop(mPage == 1 ? context.height() * 0.3 : 0),
            )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //openWebPage(context, url: 'http://192.168.1.230/wp_themes/latest/socialv/atest');

      //     showModalBottomSheet(
      //       context: context,
      //       elevation: 0,
      //       isScrollControlled: true,
      //       backgroundColor: Colors.transparent,
      //       transitionAnimationController: _animationController,
      //       builder: (context) {
      //         return FractionallySizedBox(
      //           heightFactor: 0.7,
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Container(
      //                 width: 45,
      //                 height: 5,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(16),
      //                     color: Colors.white),
      //               ),
      //               8.height,
      //               Container(
      //                 padding: EdgeInsets.all(16),
      //                 width: context.width(),
      //                 decoration: BoxDecoration(
      //                   color: context.cardColor,
      //                   borderRadius: BorderRadius.only(
      //                       topLeft: Radius.circular(16),
      //                       topRight: Radius.circular(16)),
      //                 ),
      //                 child: LatestActivityComponent(),
      //               ).expand(),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   },
      //   child: cachedImage(ic_history,
      //       width: 26, height: 26, fit: BoxFit.cover, color: Colors.white),
      //   backgroundColor: context.primaryColor,
      // ),
    );
  }
}
