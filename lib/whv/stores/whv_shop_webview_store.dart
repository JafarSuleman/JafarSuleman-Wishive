import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as htmlDom;
import 'package:socialv/whv/constants/whv_webview_constants.dart';
import 'package:socialv/whv/models/wishlists/whv_check_product_Model.dart';

import '../../main.dart';
import '../components/whv_poor_internet_connection_dialog.dart';
import '../models/wishlists/whv_scrape_model.dart';
import '../utils/whv_zip_zlid_helper.dart';

// import 'dart:developer' as dv;

part 'whv_shop_webview_store.g.dart';

class WhvShopWebviewStore = _WhvShopWebViewStoreBase with _$WhvShopWebviewStore;

abstract class _WhvShopWebViewStoreBase with Store {
  @observable
  bool hasSearched = false;

  @observable
  bool showWebView = false;

  @observable
  double progress = 0;

  String url = "";
  String speechText = "";

  @observable
  bool isListening = false;

  @observable
  bool isExtractingData = true;

  @observable
  bool isValidatingUrl = false;

  @observable
  bool isSearching = false;

  @observable
  bool hasGotSpeechText = false;

  @observable
  bool isWebviewScrolled = false;

  InAppWebViewController? webViewController;

  HeadlessInAppWebView? headlessWebView;

  @observable
  String headlessWebviewHTML = "";

  String hexHeadlessHtml = "";

  @observable
  bool isHeadlessWebviewLoading = false;

  @observable
  bool isProductDetailsPage = false;

  @observable
  String htmlContent = "";

  TextEditingController? searchTextField;

  String previousUrl = "";

  @action
  updateHeadlessWebviewHTML(String newValue) {
    headlessWebviewHTML = newValue;
  }

  @action
  parseAndSetHexHeadlessHtml() {
    var hexHtml = zipHtmlCode(headlessWebviewHTML);
    hexHeadlessHtml = hexHtml;
  }

  @action
  Future<void> runHeadlessWebviewHTML() async {
    toggleIsHeadlessWebviewLoading(true);

    await headlessWebView?.dispose();
    await headlessWebView?.run();
  }

  @action
  toggleIsProductDetailsPage(bool newValue) {
    isProductDetailsPage = newValue;
  }

  @action
  setCheckForProductPageHtmlContent(String newValue) {
    htmlContent = newValue;
  }

  @action
  toggleIsHeadlessWebviewLoading(bool newValue) {
    isHeadlessWebviewLoading = newValue;
    appStore.setLoading(newValue);
  }

  @action
  toggleIsWebviewScrolled(bool newValue) {
    isWebviewScrolled = newValue;
  }

  @action
  updateHeadlessWebview(newUrl) async {
    headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(newUrl)),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true,
        javaScriptEnabled: true,
        userAgent: whvAppStore.userDesktopAgent,
      ),
      onWebViewCreated: (controller) async {},
      onLoadStart: (controller, url) {},
      onReceivedHttpError: (controller, request, errorResponse) async {
        toggleIsHeadlessWebviewLoading(false);

        // await headlessWebView?.dispose();
      },
      onReceivedError:
          (controller, webResourceRequest, webResourceError) async {
        toggleIsHeadlessWebviewLoading(false);

        if (webResourceError.description.toLowerCase() ==
            WhvWebviewConstants.headlessWebviewNetworkErrorKey.toLowerCase()) {
          showPoorInternetConnectionDialog()
              .then((value) async => await headlessWebView?.dispose());
        }
      },
      onLoadStop: (controller, url) async {
        var htmlContent = await controller.getHtml() ?? "";
        updateHeadlessWebviewHTML(htmlContent);

        toggleIsHeadlessWebviewLoading(false);
        parseAndSetHexHeadlessHtml();

        await headlessWebView?.dispose();
      },
      onUpdateVisitedHistory: (controller, url, isReload) async {
        if (hexHeadlessHtml.isNotEmpty) {
          toggleIsHeadlessWebviewLoading(false);
        }
      },
    );
  }

  // Checks the url if it is a new url or not
  bool checkUrlChange(String currentUrl) {
    if (currentUrl.toLowerCase() != previousUrl.toLowerCase()) {
      previousUrl = currentUrl; // Updating the previous URL
      return false;
    } else {
      return true;
    }
  }

  @action
  // Function to check if the HTML content represents a product page based on keywords.
  Future<WhvCheckProductPageModel> checkForProductPage(
      String currentUrl) async {
    String htmlContent = await webViewController?.getHtml() ?? '';

    var isSameUrl = checkUrlChange(currentUrl);
    if (isSameUrl && isProductDetailsPage) {
      setCheckForProductPageHtmlContent(htmlContent);
      return WhvCheckProductPageModel(
        isProductDetailPage: true,
        htmlContent: htmlContent,
      );
    }
    print("URL changed: Not");
    toggleIsProductDetailsPage(false);

// TODO-Sohail- Code for whv-221

    // final productUrlPatterns = [
    //   RegExp(r'/products/.*'),
    //   RegExp(r'/item/.*'),
    //   RegExp(r'/p\d+\.html'),
    //   // Add more patterns as needed
    // ];

    // if (productUrlPatterns.any((pattern) => pattern.hasMatch(url))) {
    //   toggleIsProductDetailsPage(true);

    //   return WhvCheckProductPageModel(
    //       isProductDetailPage: true, htmlContent: htmlContent);
    //   // Potential product page based on URL
    // }

    BeautifulSoup bs = BeautifulSoup(htmlContent);
    var body = bs.doc;
    var htmlParsedContent = parser.parse(htmlContent);

    var buttons = htmlParsedContent.getElementsByTagName("button");

    var inputs = htmlParsedContent.getElementsByTagName("input");
    var spans = htmlParsedContent.getElementsByTagName("span");

    var hasKeyword = checkHtmlElementsForKeywords(
      buttons: buttons,
      inputs: inputs,
      spans: spans,
    );

    toggleIsProductDetailsPage(hasKeyword);
    // set the html content in the state. for passing in the page.
    setCheckForProductPageHtmlContent(
      hasKeyword ? htmlContent : '',
    );

    return WhvCheckProductPageModel(
      isProductDetailPage: hasKeyword,
      htmlContent: hasKeyword ? htmlContent : null,
    );

    // TODO-Sohail: Old Keyword check code
    // for (final keyword in whvAppStore.productKeywords) {
    //   if (body.toLowerCase().contains(keyword.toString().toLowerCase())) {
    //     toggleIsProductDetailsPage(true);
    //     return WhvCheckProductPageModel(
    //         isProductDetailPage: true, htmlContent: htmlContent);
    //   }
    // }

    // toggleIsProductDetailsPage(false);

    // return WhvCheckProductPageModel(isProductDetailPage: false);
  }

  // Checks Html Elements for product keywords

  bool checkHtmlElementsForKeywords({
    required List<htmlDom.Element> buttons,
    required List<htmlDom.Element> inputs,
    required List<htmlDom.Element> spans,
  }) {
    if (buttons.isNotEmpty) {
      var hasFoundKeyword = buttons.any((button) {
        return compareKeywords(
          elementText: button.text.toLowerCase().trim(),
          attributeValue: "",
        );
      });

      if (hasFoundKeyword) return hasFoundKeyword;
    }
    if (inputs.isNotEmpty) {
      var hasFoundKeyword = inputs.any((input) {
        var attributeValue = input.attributes['value'] ?? "";

        return compareKeywords(
          elementText: input.text.toLowerCase().trim(),
          attributeValue: attributeValue.toLowerCase().trim(),
        );
      });

      if (hasFoundKeyword) return hasFoundKeyword;
    }
    if (spans.isNotEmpty) {
      var hasFoundKeyword = spans.any((span) {
        var attributeValue = span.attributes['value'] ?? "";

        return compareKeywords(
          elementText: span.text.toLowerCase().trim(),
          attributeValue: attributeValue.toLowerCase().trim(),
        );
      });

      if (hasFoundKeyword) return hasFoundKeyword;
    }
    return false;
  }

  // Comparing the keywords
  bool compareKeywords({
    required String elementText,
    required String attributeValue,
  }) {
    return whvAppStore.productKeywords.any((keyword) {
      var keywordInLowerCase = keyword.toString().toLowerCase().trim();

      return keywordInLowerCase == elementText.toLowerCase() ||
          keywordInLowerCase == attributeValue;
    });
  }

  @action
  Future<WhvScrapeDataModel?> extractData(String htmlContent) async {
    try {
      extractDataLoading(true);
      WhvScrapeDataModel scrapeDataModel = WhvScrapeDataModel();

      var document = parser.parse(htmlContent);
      List<String> imageList = [];

/* below code is for to get all image in the web page */
      var images = document.getElementsByTagName('img');

      for (var image in images) {
        String srcImage = image.attributes['src'] ?? '';
        if (srcImage != '') {
          if (shouldSkipImageUrl(srcImage)) {
            // this check is for to avoid to add duplication urls to imageList
            if (!imageList.contains(srcImage)) {
              imageList.add(srcImage);
            }
          }
        }
      }
      var productTitle = document.getElementById("title")?.text.trim() ?? '';

      log('product title $productTitle');

      scrapeDataModel =
          scrapeDataModel.copyWith(imageUrlsList: List.from(imageList));
      var currentUrl = await webViewController?.getUrl();

      addToWishlistStore.setProductUrl(currentUrl?.uriValue.toString() ?? '');
      addToWishlistStore.setProductTitle(productTitle);
      extractDataLoading(false);

      return scrapeDataModel;
    } catch (exception) {
      extractDataLoading(false);

      log('ex extractData ${exception.toString()}');
    }
    return null;
  }

  @action
  bool shouldSkipImageUrl(String url) {
    // Check if the URL starts with "data:image/svg+xml;base64," or ends with ".svg"
    if (url.toLowerCase().startsWith("data:image/svg+xml;base64,") ||
        url.toLowerCase().endsWith(".svg") ||
        (url.toLowerCase().startsWith("data:image/gif;base64,"))) {
      return false; // Skip this URL
    }
    // Check if the URL contains the specific pattern
    if (url.contains("teads.tv/track?action=")) {
      return false; // Skip this URL
    }

    return true; // Return true for other URLs
  }

  @action
  extractDataLoading(bool newValue) {
    isExtractingData = newValue;
  }

  @action
  toggleHasSearched(bool newValue) {
    hasSearched = newValue;
  }

  @action
  toggleIsSearching(bool newValue) {
    isSearching = newValue;
  }

  /*
  toggles wether the webview should be shown or not
  */
  @action
  toggleShowWebView(bool newValue) {
    showWebView = newValue;
  }

  /*
  toggles is validating url value
  */
  @action
  toggleIsValidatingUrl(bool newValue) {
    isValidatingUrl = newValue;
  }

  /*
  initializes the webview controller
  */
  @action
  initializeController(InAppWebViewController controller) {
    toggleIsProductDetailsPage(false);
    webViewController = controller;
  }

  /*
  initialize the searchTextField Controller
  */
  @action
  initializeSearchTextController() {
    searchTextField = TextEditingController();
  }

  /*
  updates the url search progress
  */
  @action
  updateProgress(double newProgress) {
    progress = newProgress;
  }

  /*
    whenever the url is updated we updated the searchtextfield value as well
  */
  @action
  updateSearchTextFieldValue(String newValue) {
    searchTextField?.text = newValue;
    updateUrl(newValue);
  }

  /*
  updates the url whenever the url is updated
  */
  @action
  updateUrl(String newValue) {
    url = newValue;
  }

  /*
  throgh this method we load the searchtextfield value in the webview 
  */
  @action
  loadUrl({String? newUrl}) {
    // if there is any url passed to the method then use that url  otherwise
    // we use the search textfield text value.
    var _searchedText = newUrl?.trim() ?? searchTextField?.text.trim();
    toggleIsSearching(false);
    if (_searchedText != null) {
      var _url = WebUri(_searchedText);
      var newUrl = _searchedText;

      // if the url is a proper url then we directly call it in webview otherwise
      // we search it in google through google api
      if (!_url.isAbsolute) {
        // Override the values
        newUrl = newUrl.replaceAll(" ", "%20");
        newUrl = "${WhvWebviewConstants.gooleSearchURL}$newUrl";
      }

      url = newUrl;

      // if the webview is already displayed then we can use the controller
      // to load urls otherwise we need to create a new webview.
      if (showWebView) {
        webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
      }
      updateSpeechText("");
      hasSearched = true;
      if (!showWebView) {
        showWebView = true;
      }
    }
  }

  @action
  validateUrl(String url) async {
    try {
      toggleIsValidatingUrl(true);
      var isValidUrl = true;

      var urlResponse = await http.get(Uri.parse(url));
      if (urlResponse.statusCode != 200) {
        isValidUrl = false;
      }
      toggleIsValidatingUrl(false);

      return isValidUrl;
    } catch (e) {
      log("url exception: $e");
      toggleIsValidatingUrl(false);
      return false;
    }
  }

  /*
  updates the speechText whenever try to speak through mic
  */
  @action
  updateSpeechText(String newValue) {
    speechText = newValue;
  }

  @action
  toggleIsListening(bool newValue) {
    isListening = newValue;
  }

  @action
  toggleHasSpeechText(bool newValue) {
    hasGotSpeechText = newValue;
  }

  // through this method reset all the values of the store.
  @action
  resetValues() async {
    url = "";
    speechText = "";
    isListening = false;
    hasGotSpeechText = false;
    hasSearched = false;
    showWebView = false;
    searchTextField?.text = "";
    isProductDetailsPage = false;
    if (webViewController != null) webViewController?.dispose();
    webViewController = null;
  }
}
