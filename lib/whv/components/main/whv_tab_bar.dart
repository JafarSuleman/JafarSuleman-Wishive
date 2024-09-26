import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/colors.dart';
import 'package:socialv/utils/images.dart';
import 'package:socialv/whv/utils/whv_images.dart';

class WhvTabBar extends StatelessWidget {
  const WhvTabBar({
    super.key,
    required this.onTap,
    required this.onMoreOptionsTap,
    required this.tabController,
    required this.selectedIndex,
  });

  final TabController? tabController;

  final void Function(int) onTap;
  final void Function() onMoreOptionsTap;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TabBar(
            indicatorColor: context.primaryColor,
            controller: tabController,
            onTap: onTap,
            tabs: [
              Tooltip(
                richMessage: TextSpan(
                    text: language.home,
                    style: secondaryTextStyle(color: Colors.white)),
                child: Image.asset(
                  selectedIndex == 0 ? ic_home_selected : ic_home,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: selectedIndex == 0
                      ? context.primaryColor
                      : context.iconColor,
                ).paddingSymmetric(vertical: 9),
              ),
              Tooltip(
                richMessage: TextSpan(
                    text: language.wishlist,
                    style: secondaryTextStyle(color: Colors.white)),
                child: SvgPicture.asset(
                  selectedIndex == 1 ? ic_wishlist_filled : ic_wishlist,
                  height: 24,
                  width: 24,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 1
                        ? context.primaryColor
                        : context.iconColor,
                    BlendMode.srcIn,
                  ),
                ).paddingSymmetric(vertical: 11),
              ),
              Tooltip(
                richMessage: TextSpan(
                    text: language.shop,
                    style: secondaryTextStyle(color: Colors.white)),
                child: SvgPicture.asset(
                  selectedIndex == 2 ? ic_shop_filled : ic_shop,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      selectedIndex == 2
                          ? context.primaryColor
                          : context.iconColor,
                      BlendMode.srcIn),
                ).paddingSymmetric(vertical: 11),
              ),
              Tooltip(
                richMessage: TextSpan(
                    text: language.notifications,
                    style: secondaryTextStyle(color: Colors.white)),
                child: selectedIndex == 3
                    ? Image.asset(
                        ic_notification_selected,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                        color: context.primaryColor,
                      ).paddingSymmetric(vertical: 11)
                    : Observer(
                        builder: (_) => Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              ic_notification,
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                              color: context.iconColor,
                            ).paddingSymmetric(vertical: 11),
                            if (appStore.notificationCount != 0)
                              Positioned(
                                right: appStore.notificationCount
                                            .toString()
                                            .length >
                                        1
                                    ? -6
                                    : -4,
                                top: 3,
                                child: Container(
                                  padding: EdgeInsets.all(appStore
                                              .notificationCount
                                              .toString()
                                              .length >
                                          1
                                      ? 4
                                      : 6),
                                  decoration: BoxDecoration(
                                      color: appColorPrimary,
                                      shape: BoxShape.circle),
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
          ),
        ),
        GestureDetector(
          onTap: onMoreOptionsTap,
          child: SvgPicture.asset(
            ic_hamburger,
            height: 24,
            width: 24,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              context.iconColor,
              BlendMode.srcIn,
            ),
          ).paddingSymmetric(vertical: 9, horizontal: 20),
        ),
      ],
    );
  }
}
