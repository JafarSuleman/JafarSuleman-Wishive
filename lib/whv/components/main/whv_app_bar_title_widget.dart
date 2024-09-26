import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/app_constants.dart';

class WhvAppBarTitleWidget extends StatelessWidget {
  final int tabIndex;

  const WhvAppBarTitleWidget({
    required this.tabIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var title = "";

    if (tabIndex == 1) {
      title = whvLanguage.wishlists;
    } else if (tabIndex == 2) {
      title = language.shop;
    } else if (tabIndex == 3) {
      title = language.notifications;
    }

    return tabIndex == 0
        ? _dashboardScreenTitle(context)
        : Text(
            title,
            style: GoogleFonts.leagueSpartan(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff07142e),
            ),
          );
  }

  Row _dashboardScreenTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(APP_ICON, width: 26),
        4.width,
        Text(APP_NAME,
            style: boldTextStyle(
                color: context.primaryColor, size: 24, fontFamily: fontFamily)),
      ],
    );
  }
}
