import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import '../utils/whv_images.dart';

showPoorInternetConnectionDialog() async {
  toast(errorInternetNotAvailable);
  await showDialog(
    context: navigatorKey.currentState!.context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: radius(defaultAppButtonRadius),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ic_prod_page_layout,
            height: 140,
          ),
          10.height,
          Text(
            whvLanguage.poorNetworkForHeadlessWebviewErrorMessage,
            textAlign: TextAlign.center,
            style: boldTextStyle(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: Text(
            whvLanguage.close,
          ),
        ),
      ],
    ),
  );
}
