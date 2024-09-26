import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/main.dart';

class WhvHistoryOrBookmarkItemWidget extends StatelessWidget {
  const WhvHistoryOrBookmarkItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.url,
    required this.onDelete,
  });

  final int id;
  final String title;
  final String url;
  final VoidCallback onDelete;

  // gets the title first character
  String get titleFirstChar {
    if (url.isEmptyOrNull) {
      return "";
    }
    var domain = Uri.parse(url).host.toString();

    return domain.split(".")[1].substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          context.pop();
          webviewStore.loadUrl(newUrl: url);
        },
        child: Dismissible(
          key: ValueKey(id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            onDelete();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(top: 3, right: 10),
                alignment: Alignment.center,
                child: Text(
                  titleFirstChar,
                  style: primaryTextStyle(
                    color: context.cardColor,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: primaryTextStyle(
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      url,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: secondaryTextStyle(
                        size: 13,
                      ),
                    ),
                    Divider(
                      color: context.dividerColor.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: onDelete, icon: Icon(Icons.close_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
