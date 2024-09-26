import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/fragments/notification_fragment.dart';

import 'package:socialv/utils/colors.dart';
import 'package:socialv/utils/images.dart';

import 'package:socialv/whv/screens/wishlists/whv_wishlist_screen.dart';
import 'package:socialv/whv/utils/whv_images.dart';

class WhvMainScreenAppBar extends StatefulWidget {
  final TabController tabController;

  const WhvMainScreenAppBar({
    required this.tabController,
    super.key,
  });

  @override
  State<WhvMainScreenAppBar> createState() => _WhvMainScreenAppBarState();
}

class _WhvMainScreenAppBarState extends State<WhvMainScreenAppBar> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var selectedIndex = appStore.mainScreenSelectedTabIndex;

      Widget? leadingWidget;
      double? leadingWidth;

      if (selectedIndex == 1) {
        leadingWidth = 70;
        leadingWidget = _navigationControllers(context);
      } else if (selectedIndex == 3 || selectedIndex == 4) {
        leadingWidth = 35;

        leadingWidget = Image.asset(
          ic_plus,
          height: 30,
        );
      }
      return AppBar(
        leadingWidth: leadingWidth,
        leading: selectedIndex != 0
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: leadingWidget,
              )
            : null,
        centerTitle: selectedIndex != 0 ? true : false,
        // title: WhvAppBarTitleWidget(
        //   tabController: widget.tabController,
        // ),
        actions: [
          IconButton(
            onPressed: () {
              WhvWishlistScreen().launch(context);
            },
            icon: Image.asset(
              ic_heart,
              height: 25,
              width: 25,
              color: context.iconColor,
              fit: BoxFit.fill,
            ),
          ),
          Observer(
            builder: (_) => GestureDetector(
              onTap: () {
                NotificationFragment(controller: scrollController)
                    .launch(context);
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Observer(builder: (context) {
                    return Image.asset(
                      appStore.mainScreenSelectedTabIndex == 4
                          ? ic_notification_selected
                          : ic_notification,
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                      color: appStore.mainScreenSelectedTabIndex == 4
                          ? context.primaryColor
                          : context.iconColor,
                    ).paddingOnly(top: 11, bottom: 11, right: 10);
                  }),
                  if (appStore.notificationCount != 0)
                    Positioned(
                      right: appStore.notificationCount.toString().length > 1
                          ? 4
                          : 6,
                      top: 6,
                      child: Container(
                        padding: EdgeInsets.all(
                            appStore.notificationCount.toString().length > 1
                                ? 4
                                : 6),
                        decoration: BoxDecoration(
                            color: appColorPrimary, shape: BoxShape.circle),
                        child: Text(
                          appStore.notificationCount.toString(),
                          style: boldTextStyle(
                              color: Colors.white,
                              size: 10,
                              weight: FontWeight.w700,
                              letterSpacing: 0.7),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _navigationControllers(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          child: SvgPicture.asset(
            ic_nav_controller_icon,
            height: 20,
            width: 20,
          ),
          onTap: () async {
            if (webviewStore.showWebView &&
                await webviewStore.webViewController!.canGoBack()) {
              await webviewStore.webViewController?.goBack();
            } else {
              webviewStore.webViewController?.stopLoading();
              webviewStore.toggleShowWebView(false);
              webviewStore.resetValues();
            }
          },
        ),
        Transform.rotate(
          angle: 180 * pi / 180,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            child: SvgPicture.asset(
              ic_nav_controller_icon,
              height: 20,
              width: 20,
            ),
            onTap: () async {
              await webviewStore.webViewController?.goForward();
            },
          ),
        ),
      ],
    );
  }
}
