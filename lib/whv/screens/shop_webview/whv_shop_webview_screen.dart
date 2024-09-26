import 'dart:io';

import 'package:flutter/material.dart';

import 'package:socialv/main.dart';
import 'package:socialv/whv/components/shop/whv_shop_screen_components/whv_shop_screen_body.dart';

class WhvShopWebviewScreen extends StatefulWidget {
  const WhvShopWebviewScreen({
    super.key,
    this.url,
    this.isCreateNewTab = false,
    required this.controller,
  });

  final String? url;
  final bool isCreateNewTab;
  final ScrollController controller;

  @override
  State<WhvShopWebviewScreen> createState() => _WhvShopWebviewScreenState();
}

class _WhvShopWebviewScreenState extends State<WhvShopWebviewScreen>
    with AutomaticKeepAliveClientMixin, RouteAware {
  @override
  initState() {
    super.initState();

    var url = widget.url;

    // if this page was opened from the app  home page the we get the current
    // opened tab from shared prefs and directly load the url.
    if (!widget.isCreateNewTab) {
      url = tabsStore.getCurrentOpenedTab();
    }

    tabsStore.getTabs();
    historyStore.getHistory();

    // if this page was opened by tapping a tab from the tabs page then we pass
    // the tapped tab url to this page and load and display the webview.
    if (url != null && url.isNotEmpty) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          webviewStore.updateSearchTextFieldValue(url ?? "");

          if (webviewStore.showWebView) {
            webviewStore.loadUrl(newUrl: url);
            webviewStore.toggleShowWebView(true);
          } else {
            await Future.delayed(Duration(milliseconds: 200));
            webviewStore.toggleShowWebView(true);
          }
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // WHV
    //routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPush() {
    final route = ModalRoute.of(context)!.settings.name;

    _pauseWebviewMediaPlayback();
  }

  @override
  void didPopNext() {
    final route = ModalRoute.of(context)!.settings.name;

    _resumeWebviewMediaPlayback();
  }

  @override
  void didPushNext() {
    final route = ModalRoute.of(context)!.settings.name;

    _pauseWebviewMediaPlayback();
  }

  @override
  void didPop() {
    final route = ModalRoute.of(context)!.settings.name;

    _resumeWebviewMediaPlayback();
  }

  _resumeWebviewMediaPlayback() {
    if (webviewStore.webViewController != null) {
      if (Platform.isAndroid) {
        webviewStore.webViewController!.resume();
      }
    }
  }

  _pauseWebviewMediaPlayback() {
    // we check if the user is on the shop screen and if the user navgates
    // to a different page then we pause the shop screen media palybacks

    if (webviewStore.webViewController != null) {
      if (Platform.isAndroid) {
        webviewStore.webViewController!.pause();
      } else if (Platform.isIOS) {
        webviewStore.webViewController!.pauseAllMediaPlayback();
      }
    }
  }

  @override
  void dispose() {
    // WHV
    //routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WhvShopScreenBody(
      url: widget.url,
      controller: widget.controller,
    );
  }
}
