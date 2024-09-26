import 'dart:developer';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mobx/mobx.dart';
import 'package:socialv/whv/constants/whv_webview_constants.dart';

part 'whv_live_shoppable_store.g.dart';

class WhvLiveShoppableStore = _WhvLiveShoppableStoreBase
    with _$WhvLiveShoppableStore;

abstract class _WhvLiveShoppableStoreBase with Store {
  var channels = WhvWebviewConstants.channels;

  @observable
  String currentUrl = "";

  InAppWebViewController? webViewController;

  @observable
  double progress = 0;

  @action
  updateCurrentUrl(String newUrl) {
    currentUrl = newUrl;
  }

  /*
  initializes the webview controller
  */
  @action
  initializeController(InAppWebViewController controller) {
    webViewController = controller;
  }

  /*
  updates the url search progress
  */
  @action
  updateProgress(double newProgress) {
    progress = newProgress;
  }

  // can remove html elements by tag names
  @action
  removeElementByTagName({required List<String> tagNames}) {
    var javascriptString = "";

    tagNames.forEach(
      (tag) {
        javascriptString = javascriptString +
            "var head = document.getElementsByTagName('$tag')[0];" +
            "head.parentNode.removeChild(head);";
      },
    );
    webViewController!
        .evaluateJavascript(
            source: "javascript:(function() { " + javascriptString + "})()")
        // .then((value) => log('removeElementByTagName Page finished loading Javascript'))
        .catchError((onError) => log('removeElementByTagName Error: $onError'));
  }

  // can remove html elements by class names
  @action
  removeElementByClassName({required List<String> classNames}) {
    var javascriptString = "";

    classNames.forEach(
      (className) {
        javascriptString = javascriptString +
            "var liveDestinationHeader = Array.from(document.getElementsByClassName('$className'));" +
            "liveDestinationHeader[0].remove();";
      },
    );

    webViewController!
        .evaluateJavascript(
            source: "javascript:(function() { " + javascriptString + "})()")
        // .then((value) =>
        //     log('removeElementByClassName Page finished loading Javascript'))
        .catchError(
            (onError) => log('removeElementByClassName Error: $onError'));
  }

  // can remove html elements by ids
  @action
  removeElementById({required List<String> elementIds}) {
    var javascriptString = "";

    elementIds.forEach(
      (elementId) {
        javascriptString = javascriptString +
            "var navFooter = document.getElementById('$elementId');" +
            "navFooter.parentNode.removeChild(navFooter);";
      },
    );
    webViewController!
        .evaluateJavascript(
            source: "javascript:(function() { " + javascriptString + "})()")
        // .then((value) =>
        //     log('removeElementById Page finished loading Javascript'))
        .catchError((onError) => log('removeElementById Error: $onError'));
  }
}
