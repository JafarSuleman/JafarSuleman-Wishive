import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/constants/whv_webview_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import "package:any_link_preview/src/helpers/link_analyzer.dart";
import 'package:flutter/gestures.dart' as g;

class WhvLiveShoppableWebView extends StatefulWidget {
  const WhvLiveShoppableWebView({
    super.key,
    required this.controller,
  });
  final ScrollController controller;
  @override
  _WhvLiveShoppableWebViewState createState() =>
      new _WhvLiveShoppableWebViewState();
}

class _WhvLiveShoppableWebViewState extends State<WhvLiveShoppableWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              id: 1,
              title: "Special",
              action: () async {
                await liveShoppableStore.webViewController?.clearFocus();
              })
        ],
        settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {},
        onHideContextMenu: () {},
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {});

    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                liveShoppableStore.webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                liveShoppableStore.webViewController?.loadUrl(
                    urlRequest: URLRequest(
                        url: await liveShoppableStore.webViewController
                            ?.getUrl()));
              }
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // through this method we get a url data like title etc.
  Future<String?> getLinkData(String newUrl) async {
    try {
      var info = await LinkAnalyzer.getInfo(
        newUrl,
      );

      if (info == null || info.hasData == false) {
        // if info is null or data is empty try to read url metadata from client side
        info = await LinkAnalyzer.getInfoClientSide(
          newUrl,
        );
      }

      return info?.title;
    } catch (e) {
      log("exception while getting link data $e");
      throw Exception(e);
    }
  }

  // TODO-Future-Work: uncomment this when needed this method is needed when we tap on a product on amazonlive etc.
  // addNewTab({
  //   required InAppWebViewController controller,
  //   required String url,
  // }) async {
  //   try {
  //     log("addNewTab $url");
  //     var urlToString = url.toString();

  //     var title = await getLinkData(urlToString);

  //     var imageResponse = await controller.takeScreenshot(
  //       screenshotConfiguration: ScreenshotConfiguration(
  //         quality: 30,
  //       ),
  //     );

  //     if (title == null || title.isEmpty) {
  //       title = Uri.parse(urlToString).host.toString();
  //     }

  //     tabsStore.addTab(
  //       WhvTabModel(
  //         id: -1,
  //         title: title,
  //         url: urlToString,
  //         preview: imageResponse,
  //       ),
  //     );
  //     appStore.tabController.animateTo(1);
  //     //TODO: load url in shop webview
  //   } catch (e) {
  //     log("addnewTab exception $e");
  //   }
  // }

  // through this method we remove headers and footers from webviews
  _removeElements() async {
    if (liveShoppableStore.currentUrl
        .contains(WhvWebviewConstants.amazon.toLowerCase())) {
      _removeAmazonElements();
    } else if (liveShoppableStore.currentUrl
        .contains(WhvWebviewConstants.walmart.toLowerCase())) {
      _removeWalmartElements();
    } else if (liveShoppableStore.currentUrl
        .contains(WhvWebviewConstants.target.toLowerCase())) {
      _removeTargetElements();
    }
  }

  // Removes Amazon Live Elements
  _removeAmazonElements() {
    // removes the header-amazon
    liveShoppableStore.removeElementByTagName(
        tagNames: WhvWebviewConstants.amazonHeaderTagNames);

    // removes the search bar header-amazon
    liveShoppableStore.removeElementByClassName(
      classNames: WhvWebviewConstants.amazonClassNames,
    );

    // removes the footer-amazon
    liveShoppableStore.removeElementById(
        elementIds: WhvWebviewConstants.amazonFooterElementIds);
  }

  // Removes Walmart Live Elements
  _removeWalmartElements() {
    liveShoppableStore.removeElementByClassName(
        classNames: WhvWebviewConstants.walmartClassNames);
    liveShoppableStore.removeElementByTagName(
        tagNames: WhvWebviewConstants.walmartTagNames);
  }

  // Removes Walmart Live Elements
  _removeTargetElements() {
    liveShoppableStore.removeElementById(
        elementIds: WhvWebviewConstants.targetElementIds);
    liveShoppableStore.removeElementByClassName(
        classNames: WhvWebviewConstants.targetClassNames);
  }

  // Removes all those elements which renders while browsing for Targetlive.
  _removeTargetOtherElementsWhenBrowsing() {
    liveShoppableStore.removeElementByClassName(
        classNames: WhvWebviewConstants.targetOtherElementClassNames);
  }

  var scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          key: webViewKey,
          initialUrlRequest:
              URLRequest(url: WebUri(liveShoppableStore.currentUrl)),
          initialUserScripts: UnmodifiableListView<UserScript>([]),
          initialSettings: settings,
          contextMenu: contextMenu,
          pullToRefreshController: pullToRefreshController,
          gestureRecognizers: <Factory<g.OneSequenceGestureRecognizer>>[
            Factory<g.OneSequenceGestureRecognizer>(
              () => g.EagerGestureRecognizer(),
            ),
          ].toSet(),
          onScrollChanged: (controller, x, y) async {
            _removeTargetOtherElementsWhenBrowsing();

            // Now Keep track of scrolling
            var _isScrollingDown = scrollPosition > y;

            if (_isScrollingDown) {
              if (widget.controller.offset != 0.0) {
                if (!widget.controller.position.isScrollingNotifier.value) {
                  widget.controller.animToTop(milliseconds: 200);

                  whvAppStore.toggleTrendingSubTabViewScrolled(false);
                }
              }
            } else {
              if (widget.controller.offset == 0.0) {
                if (!widget.controller.position.isScrollingNotifier.value) {
                  widget.controller.animToBottom(milliseconds: 200);
                  whvAppStore.toggleTrendingSubTabViewScrolled(true);
                }
              }
            }
            scrollPosition = y;
          },
          onWebViewCreated: (controller) async {
            liveShoppableStore.initializeController(controller);
            _removeElements();
          },
          onLoadStart: (controller, url) async {
            _removeElements();
          },
          onPermissionRequest: (controller, request) async {
            return PermissionResponse(
                resources: request.resources,
                action: PermissionResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunchUrl(uri)) {
                // Launch the App
                await launchUrl(
                  uri,
                );
                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }

            // TODO-Future-Work: uncomment this when needed
            // log("uriUrl shouldOverrideUrlLoading ${uri.toString()} ${uri.toString().contains("/live/")}");
            // we check if the tapped link is a product link then we don't navigate
            // the webview to a new tab instead we navigate the user to the shop
            // screen and create a new tab for the tapped product.
            // if (uri.toString().contains("ref=va_live_carousel")) {
            //   addNewTab(
            //     controller: controller,
            //     url: uri.toString(),
            //   );
            //   return NavigationActionPolicy.CANCEL;
            // } else {
            return NavigationActionPolicy.ALLOW;
            // }
          },
          onLoadStop: (controller, url) async {
            _removeElements();

            pullToRefreshController?.endRefreshing();

            this.url = url.toString();
          },
          onReceivedError: (controller, request, error) {
            pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            _removeElements();
            if (progress == 100) {
              pullToRefreshController?.endRefreshing();
            }

            liveShoppableStore.updateProgress(progress / 100);
          },
          onUpdateVisitedHistory: (controller, url, isReload) {
            _removeElements();
            this.url = url.toString();
          },
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
        ),
        Observer(
          builder: (_) {
            return liveShoppableStore.progress < 1.0
                ? LinearProgressIndicator(value: liveShoppableStore.progress)
                : SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
