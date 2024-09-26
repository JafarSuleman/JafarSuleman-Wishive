// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialv/utils/colors.dart';
import 'package:socialv/whv/components/trending/whv_speed_dial_menu_widget.dart';
import 'package:socialv/whv/models/whv_trending_products_model/trending_product.dart';
import 'package:socialv/whv/screens/wishlists/whv_image_selection_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socialv/main.dart';

class WhvTrendingProductDetailWebviewScreen extends StatefulWidget {
  const WhvTrendingProductDetailWebviewScreen({
    super.key,
    required this.product,
    // required this.controller,
  });
  // final ScrollController controller;
  final TrendingProduct product;

  @override
  _WhvTrendingProductDetailWebviewScreenState createState() =>
      new _WhvTrendingProductDetailWebviewScreenState();
}

class _WhvTrendingProductDetailWebviewScreenState
    extends State<WhvTrendingProductDetailWebviewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  late PullToRefreshController pullToRefreshController;

  late ContextMenu contextMenu;
  String currentUrl = "";

  bool hasStoppedLoading = false;
  bool hasCheckedProductPage = false;

  HeadlessInAppWebView? headlessWebView;
  ScrollController scrollController = ScrollController();

  var scrollPosition = 0;

  InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              id: 1,
              title: "Special",
              action: () async {
                await webviewStore.webViewController?.clearFocus();
              })
        ],
        settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {},
        onHideContextMenu: () {},
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {});

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          webviewStore.webViewController?.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          webviewStore.webViewController?.loadUrl(
              urlRequest: URLRequest(
                  url: await webviewStore.webViewController?.getUrl()));
        }
      },
    );
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Scrolled to the bottom

      print("Scrolled to the bottom");
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      // Scrolled to the top
      print("Scrolled to the top");
      whvTrendingProductDetailWebViewStore.changeStateOfFloatingButton(
          state: true);
      setState(() {});
    }
    if (scrollController.offset < scrollController.position.maxScrollExtent &&
        scrollController.offset > scrollController.position.minScrollExtent) {
      // Scrolled in between
      print("Scrolled in between");
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    webviewStore.webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Icon(
            CupertinoIcons.multiply,
            color: context.cardColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.lock,
              color: context.cardColor,
              size: 15,
            ),
            6.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productTitle ?? '',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.product.productDomain ?? '',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(widget.product.productUrl ?? '');
              },
              icon: Icon(
                Icons.share,
                color: context.cardColor,
              )),
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       CupertinoIcons.ellipsis_vertical,
          //       color: context.cardColor,
          //     ))
        ],
        backgroundColor: context.primaryColor,
      ),
      body: Stack(
        children: [
          //  SingleChildScrollView(
          //   controller: scrollController,
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height,
          InAppWebView(
            key: webViewKey,
            initialUrlRequest:
                URLRequest(url: WebUri(widget.product.productUrl ?? '')),
            initialSettings: settings,
            gestureRecognizers: <Factory<g.OneSequenceGestureRecognizer>>[
              Factory<g.OneSequenceGestureRecognizer>(
                () => g.EagerGestureRecognizer(),
              ),
            ].toSet(),
            onScrollChanged: (controller, x, y) {
              // var _isScrollingDown = scrollPosition > y;
              if (y == 0) {
                whvTrendingProductDetailWebViewStore
                    .changeStateOfFloatingButton(state: true);
              }

              // dev.log('y axis value $y');

              if (y > 20) {
                whvTrendingProductDetailWebViewStore
                    .changeStateOfFloatingButton(state: false);
              }
              setState(() {});

              // if (_isScrollingDown) {
              //   if (scrollController.offset != 0.0) {
              //     if (!scrollController
              //         .position.isScrollingNotifier.value) {
              //       log('scrolling up');
              //       scrollController.animToTop(milliseconds: 200);
              //       whvTrendingProductDetailWebView
              //           .toggleIsWebviewScrolled(false);
              //     }
              //   }
              // } else {
              //   if (scrollController.offset == 0.0) {
              //     if (!scrollController
              //         .position.isScrollingNotifier.value) {
              //       log('scrolling down');
              //       whvTrendingProductDetailWebView
              //           .changeStateOfFloatingButton(state: false);
              //       scrollController.animToBottom(milliseconds: 200);
              //       whvTrendingProductDetailWebView
              //           .toggleIsWebviewScrolled(true);
              //     }
              //   }
              // }
              // scrollPosition = y;
            },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                useOnLoadResource: true,
                useShouldOverrideUrlLoading:
                    true, // Enable URL loading interception
              ),
            ),
            contextMenu: contextMenu,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webviewStore.initializeController(controller);
            },
            onRequestFocus: (controller) async {},
            onLoadResource: (controller, resource) async {
              if (hasStoppedLoading) {
                if (!hasCheckedProductPage) {
                  hasCheckedProductPage = true;
                  await webviewStore.checkForProductPage("onLoadResource");
                }
              }
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                resources: request.resources,
                action: PermissionResponseAction.GRANT,
              );
            },
            onReceivedError: (controller, request, error) {
              pullToRefreshController.endRefreshing();
            },
            onLoadStart: (controller, url) async {
              try {
                log("onWebviewCheck: onLoadStart");

                webviewStore.updateHeadlessWebview(url.toString());

                currentUrl = url.toString();
              } catch (e) {
                log("onLoadStart exception $e");
                throw Exception(e);
              }
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
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
                if (await canLaunchUrl(Uri.parse(currentUrl))) {
                  // Launch the App
                  await launchUrl(
                    Uri.parse(currentUrl),
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              hasStoppedLoading = true;
              pullToRefreshController.endRefreshing();

              webviewStore.checkForProductPage(url.toString());
              currentUrl = url.toString();
            },
            onLoadError: (controller, url, code, message) {
              pullToRefreshController.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController.endRefreshing();
              }

              webviewStore.updateProgress(progress / 100);
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) async {
              try {
                log("onWebviewCheck: onUpdateVisitedHistory");

                webviewStore.checkForProductPage(url.toString());
                hasCheckedProductPage = false;
                currentUrl = url.toString();

                webviewStore.updateHeadlessWebview(url.toString());
              } catch (e) {
                log("exception onUpdateVisitedHistory $e ");
                throw Exception(e);
              }
            },
            androidOnReceivedTouchIconUrl: (controller, url, precomposed) {},
            onConsoleMessage: (controller, consoleMessage) {},
          ),
          Observer(
            builder: (_) {
              return webviewStore.progress < 1.0
                  ? LinearProgressIndicator(value: webviewStore.progress)
                  : SizedBox.shrink();
            },
          ),
          Positioned.fill(
            child: _validatingLoader(),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: WhvSpeedDialMenuWidget(
              onTapAddWish: () async {
                if (await isNetworkAvailable()) {
                  WhvImageSelectionScreen(
                    htmlContent: webviewStore.htmlContent,
                  ).launch(context).then(
                      (value) => addToWishlistStore.userSelectedImageUrl = '');
                } else {
                  toast(errorInternetNotAvailable);
                }
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: SpeedDialWidget(),
    );
  }

  Observer _validatingLoader() {
    return Observer(builder: (_) {
      return Visibility(
        visible: webviewStore.isValidatingUrl,
        child: AbsorbPointer(
          child: Container(
            color: context.iconColor.withOpacity(0.08),
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 4.0, sigmaY: 4.0, tileMode: TileMode.mirror),
              child: SpinKitFadingCircle(
                size: 40,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColorPrimary,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
