import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/membership/screens/membership_plans_screen.dart';
import 'package:socialv/screens/messages/screens/message_screen.dart';
import 'package:socialv/screens/notification/components/latest_activity_component.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/utils/colors.dart';
import 'package:socialv/utils/images.dart';
import 'package:socialv/whv/screens/wishlists/whv_image_selection_screen.dart';

import '../shop/heart_button/heart_button.dart';

class WhvMainScreenFoaltingActionButtons extends StatelessWidget {
  final TabController tabController;
  final AnimationController animationController;
  const WhvMainScreenFoaltingActionButtons({
    required this.tabController,
    required this.animationController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (tabController.index == 2)
          Align(
            alignment: Alignment.centerRight,
            child: Observer(builder: (context) {
              return Visibility(
                visible: webviewStore.showWebView &&
                    webviewStore.isProductDetailsPage,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (await isNetworkAvailable()) {
                      //  whvCheckProductPageModel.htmlContent ?? ''
                      // WhvCheckProductPageModel whvCheckProductPageModel =
                      //     await webviewStore
                      //         .checkForProductPage(webviewStore.url);
                      // _openAddtoWishlistBottomSheet(context);
                      WhvImageSelectionScreen(
                        htmlContent: webviewStore.htmlContent,
                      ).launch(context).then((value) =>
                          addToWishlistStore.userSelectedImageUrl = '');
                    } else {
                      toast(errorInternetNotAvailable);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HeartButton(),
                  ),
                ),
              );
            }),
          ),
        if (tabController.index != 1)
          Column(
            children: [
              10.height,
              FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    elevation: 0,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    transitionAnimationController: animationController,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 45,
                              height: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white),
                            ),
                            8.height,
                            Container(
                              padding: EdgeInsets.all(16),
                              width: context.width(),
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                              ),
                              child: LatestActivityComponent(),
                            ).expand(),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: cachedImage(ic_history,
                    width: 26,
                    height: 26,
                    fit: BoxFit.cover,
                    color: Colors.white),
              ),
              10.height,
              Observer(
                builder: (_) => Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        if (pmpStore.privateMessaging) {
                          messageStore.setMessageCount(0);
                          MessageScreen().launch(context);
                        } else {
                          MembershipPlansScreen().launch(context);
                        }
                      },
                      child: cachedImage(ic_chat,
                          width: 26,
                          height: 26,
                          fit: BoxFit.cover,
                          color: Colors.white),
                      backgroundColor: context.primaryColor,
                    ),
                    if (messageStore.messageCount != 0)
                      Positioned(
                        left: messageStore.messageCount.toString().length > 1
                            ? -6
                            : -4,
                        top: -5,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: blueTickColor, shape: BoxShape.circle),
                          child: Text(
                            messageStore.messageCount.toString(),
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
            ],
          ),
      ],
    );
  }
}
