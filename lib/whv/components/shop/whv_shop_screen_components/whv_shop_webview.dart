// ignore_for_file: deprecated_member_use

import 'dart:ui';

import "package:any_link_preview/src/helpers/link_analyzer.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' as g;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/utils/colors.dart';
import 'package:socialv/whv/models/whv_history_model.dart';
import 'package:socialv/whv/models/whv_tab_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:socialv/main.dart';

class WhvShopWebView extends StatefulWidget {
  const WhvShopWebView({
    super.key,
    required this.controller,
  });
  final ScrollController controller;

  @override
  _WhvShopWebViewState createState() => new _WhvShopWebViewState();
}

class _WhvShopWebViewState extends State<WhvShopWebView> {
  final GlobalKey webViewKey = GlobalKey();

  late PullToRefreshController pullToRefreshController;

  late ContextMenu contextMenu;
  String currentUrl = "";

  bool hasStoppedLoading = false;
  bool hasCheckedProductPage = false;

  HeadlessInAppWebView? headlessWebView;

  var scrollPosition = 0;

  InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  @override
  void initState() {
    super.initState();

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

// TODO-Sohail- Code for whv-221

  // void _setupJavaScriptInterface() {
  //   webviewStore.webViewController?.addJavaScriptHandler(
  //     handlerName: 'callDartFunction',
  //     callback: (args) {
  //       print("Dart Function Called: $args"); // Handle data from JavaScript
  //       // webviewStore.webViewController?.evaluateJavascript(
  //       //     source:
  //       //         "alert('Data received from Dart: $args')"); // Send data back to JavaScript
  //     },
  //   );
  // }

  // void _setupJavaScriptpageLoadedWithHtml() {
  //   webviewStore.webViewController?.addJavaScriptHandler(
  //     handlerName: 'pageLoadedWithHtml', // Handler for HTML content
  //     callback: (args) {
  //       if (args.isNotEmpty && args[0] is String) {
  //         String htmlContent = args[0];
  //         print(
  //             "pageLoadedWithHtml: Page loaded! Received HTML content (length: ${htmlContent.length})");
  //         // Process the HTML content here (e.g., save, analyze)
  //       } else {
  //         print(
  //             "pageLoadedWithHtml: Invalid HTML data received from JavaScript");
  //       }
  //     },
  //   );
  // }

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

  @override
  void dispose() {
    webviewStore.toggleIsSearching(false);

    super.dispose();
    webviewStore.webViewController?.dispose();
  }
// TODO-Sohail- Code for whv-221
//   String script = """
// // window.addEventListener('load', function() {
// //   if (document.readyState === 'complete') {

// //   // Your JavaScript code to listen for events or retrieve data
// //   var htmlContent = document.documentElement.outerHTML;
// //   // window.flutter_inappwebview.callHandler('pageLoadedWithHtml', htmlContent);

// //   }
// // // window.flutter_inappwebview.callHandler('callDartFunction', {title: 'My Page Title', url: document.URL})
// // // });

// window.onload = function() {
//   // Your code to be executed when the page loads successfully
//   console.log("Page loaded successfully!");
//   // You can call a Dart handler here (explained later)
//   // alert('Data received from Dart: onLoad')
//   window.flutter_inappwebview.callHandler('callDartFunction', {title: 'My Page Title', url: document.URL})
// };

// var htmlContent = document.documentElement.innerHTML;

// //  function isProductPage() {
//   // 1. Check for URL Patterns (with Regular Expressions):
//   // var url = window.location.href;
// //  var productUrlPatterns = [
// //     /\/products\/.*/, // Common product URL structure
// //     /\/shopping\/.*/, // Common product URL structure
// //     /\/item\/.*/,        // Another common pattern
// //     /\/p\d+\.html/      // Pattern with product ID and .html extension
// //   ];

// //   var url = "https://www.reebok.eu/en-gb/shopping/club-c-bulc-shoes-20138464";

// //   for (var i = 0; i < productUrlPatterns.length; i++) {
// //     var pattern = new RegExp(productUrlPatterns[i]);
// //     if (pattern.test(url)) {
// //         console.log("true")
// //       return true; // Potential product page based on URL patterns
// //     }

// //   }

// //   // 2. Check for Product-Specific Elements (Flexible Approach):
// //   var addToIndicators = ["add to cart", "add to basket", "add to bag"]; // Common button text variations
// //   var productIndicators = [
// //     { selector: ".product-title", weight: 2 },
// //     { selector: "h1[data-testid*='product-name']", weight: 2 },
// //     { selector: "meta[property='og:title'][content*='product']", weight: 1 }, // Check for Open Graph meta tags
// //     { selector: ".price", weight: 1 }, // Look for price element
// //     { selector: "button:not([disabled])", textContent: addToIndicators, weight: 3 } // Check button text content
// //   ];

// //   var totalWeight = 0;
// //   var foundElements = 0;

// //   for (var i = 0; i < productIndicators.length; i++) {
// //     var element;

// //     if (productIndicators[i].selector) {
// //       element = document.querySelector(productIndicators[i].selector);
// //     } else if (productIndicators[i].textContent) {
// //       // Check for buttons with specific text content (case-insensitive)
// //       var buttons = document.querySelectorAll("button:not([disabled])");
// //       for (var j = 0; j < buttons.length; j++) {
// //         var buttonText = buttons[j].textContent.toLowerCase();
// //         if (addToIndicators.some(text => buttonText.includes(text))) {
// //           element = buttons[j];
// //           break;
// //         }
// //       }
// //     }

// //     if (element) {
// //       totalWeight += productIndicators[i].weight;
// //       foundElements++;
// //     }
// //   }

// //   // Heuristic-based threshold determination:
// //   var threshold = 0.6 * productIndicators.reduce((acc, curr) => acc + curr.weight, 0); // Consider total weight of indicators
// //   return foundElements / productIndicators.length >= threshold; // Adjust threshold based on weight and confidence level

// // }

// function isAddToCartButtonPresent() {
//   // 1. Check for Buttons with Text "Add to Cart" (Case-Insensitive):
//   var addToCartButtons = document.querySelectorAll("button:not([disabled])"); // Select non-disabled buttons
//   for (var i = 0; i < addToCartButtons.length; i++) {
//     var buttonText = addToCartButtons[i].textContent.toLowerCase();
//     if (buttonText.includes("add to bag")) {
//       return true; // Found "Add to Cart" button
//     }
//   }

//   // 2. Check for Alternative Text Variations (Optional):
//   // You can uncomment this section and add additional variations
//   // var addToCartVariations = ["add to basket", "add to bag"]; // Optional
//   // for (var i = 0; i < addToCartButtons.length; i++) {
//   //   var buttonText = addToCartButtons[i].textContent.toLowerCase();
//   //   if (addToCartVariations.some(text => buttonText.includes(text))) {
//   //     return true; // Found alternative variation
//   //   }
//   // }

//   // 3. Additional Heuristics (Optional):
//   // You can further refine the logic by checking for specific button classes or attributes

//   return false; // No "Add to Cart" button found
// }

// var isProductPage =  isAddToCartButtonPresent();
// // console.log(isProductPage);

// window.flutter_inappwebview.callHandler('callDartFunction', {title: 'My Page Title', isProductPage: isProductPage})
// """;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri(webviewStore.url)),
          initialSettings: settings,
          gestureRecognizers: <Factory<g.OneSequenceGestureRecognizer>>[
            Factory<g.OneSequenceGestureRecognizer>(
              () => g.EagerGestureRecognizer(),
            ),
          ].toSet(),
          onScrollChanged: (controller, x, y) {
            var _isScrollingDown = scrollPosition > y;

            if (_isScrollingDown) {
              if (widget.controller.offset != 0.0) {
                if (!widget.controller.position.isScrollingNotifier.value) {
                  widget.controller.animToTop(milliseconds: 200);
                  webviewStore.toggleIsWebviewScrolled(false);
                }
              }
            } else {
              if (widget.controller.offset == 0.0) {
                if (!widget.controller.position.isScrollingNotifier.value) {
                  widget.controller.animToBottom(milliseconds: 200);
                  webviewStore.toggleIsWebviewScrolled(true);
                }
              }
            }
            scrollPosition = y;
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

// TODO-Sohail- Code for whv-221

            // _setupJavaScriptpageLoadedWithHtml();
            // _setupJavaScriptInterface();
            // webviewStore.webViewController?.evaluateJavascript(source: script);
            // UserScript userScript = UserScript(
            //   source: script,
            //   injectionTime: UserScriptInjectionTime.AT_DOCUMENT_END,
            // );
            // webviewStore.webViewController
            //     ?.addUserScript(userScript: userScript);
          },
          onRequestFocus: (controller) async {},
          onLoadResource: (controller, resource) async {
// TODO-Sohail- Code for whv-221

            // if (hasStoppedLoading) {
            //   if (!hasCheckedProductPage) {
            //     hasCheckedProductPage = true;
            //     await webviewStore.checkForProductPage("onLoadResource");
            //   }
            // }
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

              var oldUrl = currentUrl;
              var isSameUrl =
                  oldUrl.toLowerCase() == url.toString().toLowerCase();

              webviewStore.updateHeadlessWebview(url.toString());

              currentUrl = url.toString();

              var urlToString = url.toString();

              var title = await getLinkData(urlToString);

              if (title == null || title.isEmpty) {
                title = Uri.parse(urlToString).host.toString();
              }

              webviewStore.toggleHasSearched(true);

              // we only add the search url to history only if the url is Search for
              // the first time if its reloaded then we don't add the url to history.
              // if (isSameUrl) {

              // we get the url website title if its not able to find it then we
              // assign the host of the url to the title.

              historyStore.addHistory(
                WhvHistoryModel(
                  id: -1,
                  title: title,
                  url: urlToString,
                  date: DateTime.now(),
                ),
              );
              // }
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
            log("onWebviewCheck: onLoadStop");

// TODO-Sohail- Code for whv-221

            // webviewStore.webViewController?.evaluateJavascript(
            //     source:
            //         "window.flutter_inappwebview.callHandler('callDartFunction')");

            // webviewStore.webViewController?.evaluateJavascript(source: script);

            webviewStore.checkForProductPage(url.toString());
            currentUrl = url.toString();

            try {
              var urlToString = url.toString();

              var title = await getLinkData(urlToString);

              var imageResponse = await controller.takeScreenshot(
                screenshotConfiguration: ScreenshotConfiguration(
                  quality: 30,
                ),
              );

              if (title == null || title.isEmpty) {
                title = Uri.parse(urlToString).host.toString();
              }

              var isCurrentOpenedTabAvailable =
                  tabsStore.isCurrentOpenedTabAvailable();

              // if the current opened tab is not available in the tabs list on
              // local storage then we create a new tab. if its available then we
              // update tab url.
              if (tabsStore.tabs.isEmpty || !isCurrentOpenedTabAvailable) {
                tabsStore.addTab(
                  WhvTabModel(
                    id: -1,
                    title: title,
                    url: urlToString,
                    preview: imageResponse,
                  ),
                );
              } else {
                tabsStore.updateTab(
                  title: title,
                  url: urlToString,
                  preview: imageResponse,
                );
              }
            } catch (e) {
              log("onLoadStop exception $e");
            }
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

// TODO-Sohail- Code for whv-221

              // webviewStore.webViewController?.evaluateJavascript(
              //     source:
              //         "window.flutter_inappwebview.callHandler('callDartFunction')");
              // webviewStore.webViewController
              //     ?.evaluateJavascript(source: script);

              webviewStore.checkForProductPage(url.toString());
              hasCheckedProductPage = false;
              currentUrl = url.toString();

              webviewStore.updateHeadlessWebview(url.toString());

              webviewStore.updateSearchTextFieldValue(url.toString());

              var urlToString = url.toString();
              var title = await getLinkData(urlToString);

              var imageResponse = await controller.takeScreenshot(
                screenshotConfiguration: ScreenshotConfiguration(
                  quality: 30,
                ),
              );

              if (title == null || title.isEmpty) {
                title = Uri.parse(urlToString).host.toString();
              }

              // we update the tab url whenever the user searches something and url is changed.
              tabsStore.updateTab(
                title: title,
                url: urlToString,
                preview: imageResponse,
              );
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
      ],
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
