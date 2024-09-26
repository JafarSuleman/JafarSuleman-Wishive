import 'dart:io';

import 'package:socialv/main.dart';

handleWebviewsMediaPlayback({
  required int selectedTabIndex,
  required bool shouldPause,
}) {
  var isOnShoppableLiveScreen = selectedTabIndex == 3;
  var isOnShopScreen = selectedTabIndex == 1;

  // NOTE: Handles Shop Screen Webview
  // we check if the user is on the shop screen and if the user navgates
  // to a different page then we pause the shop screen media palybacks
  if (isOnShopScreen) {
    if (webviewStore.webViewController != null) {
      if (shouldPause) {
        if (Platform.isAndroid) {
          webviewStore.webViewController!.pause();
        } else if (Platform.isIOS) {
          webviewStore.webViewController!.pauseAllMediaPlayback();
        }
      } else {
        // if the user is navigating to the shop screen for the second time or so (note: in the current session of the app)
        // then we resume the previous media playbacks.
        if (Platform.isAndroid) {
          webviewStore.webViewController!.resume();
        }
      }
    }
  }

  // NOTE: Handles Shoppable Live Webview
  // if the user is navigating to a screen other than the shoppable live
  // then we pause all the media playbacks and when the user navigates
  // back to the shoppable live screen then we resume the media playbacks.
  if (isOnShoppableLiveScreen) {
    if (liveShoppableStore.webViewController != null) {
      if (shouldPause) {
        if (Platform.isAndroid) {
          liveShoppableStore.webViewController!.pause();
        } else if (Platform.isIOS) {
          liveShoppableStore.webViewController!.pauseAllMediaPlayback();
        }
      } else {
        if (Platform.isAndroid) {
          liveShoppableStore.webViewController!.resume();
        }
      }
    }
  }
}
