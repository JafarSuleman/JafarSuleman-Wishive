import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/messages/screens/message_screen.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/utils/colors.dart';
import 'package:socialv/utils/images.dart';

class WhvMessageFloatingActionButton extends StatelessWidget {
  const WhvMessageFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Visibility(
        visible: appStore.mainScreenSelectedTabIndex == 2,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                messageStore.setMessageCount(0);
                MessageScreen().launch(context);
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
                left: messageStore.messageCount.toString().length > 1 ? -6 : -4,
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
    );
  }
}
