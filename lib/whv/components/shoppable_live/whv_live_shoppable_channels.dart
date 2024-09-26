import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/main.dart';

class WhvLiveShoppableChannels extends StatelessWidget {
  const WhvLiveShoppableChannels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: context.iconColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Observer(builder: (context) {
          var currentUrl = liveShoppableStore.currentUrl;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: liveShoppableStore.channels.map((channel) {
              var isCurrentSelectedChannel = currentUrl.toLowerCase() !=
                  channel['url'].toString().toLowerCase();
              return InkWell(
                onTap: () {
                  liveShoppableStore
                      .updateCurrentUrl(channel['url'].toString());
                  if (liveShoppableStore.webViewController != null) {
                    liveShoppableStore.webViewController?.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri(channel['url'].toString()),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: isCurrentSelectedChannel
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            channel['icon']!,
                            height: 50,
                          ),
                        )
                      : DottedBorderWidget(
                          radius: channel['title']?.toLowerCase() == 'target'
                              ? 500
                              : 4,
                          // gap: 0,
                          padding: const EdgeInsets.all(4.0),
                          color: context.primaryColor,
                          child: Image.asset(
                            channel['icon']!,
                            height: 50,
                          ),
                        ),
                ),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
