import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import 'package:socialv/whv/models/whv_top_site_model.dart';

class WhvTopSiteItem extends StatelessWidget {
  const WhvTopSiteItem({
    super.key,
    required this.topSite,
  });

  final WhvTopSiteModel topSite;

  // gets the title first character
  String get titleFirstChar {
    if (topSite.url.isEmpty) {
      return "";
    }

    var domain = Uri.parse(topSite.url).host.toString();

    return domain.split(".")[1].substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        webviewStore.updateSearchTextFieldValue(topSite.url);
        webviewStore.loadUrl();
      },
      child: SizedBox(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(topSite.color).withOpacity(1.0),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 80,
              width: 80,
              child: Center(
                child: Text(
                  titleFirstChar,
                  style: boldTextStyle(
                    size: 30,
                    color: context.cardColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 80,
              child: Text(
                topSite.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: boldTextStyle(
                  size: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
