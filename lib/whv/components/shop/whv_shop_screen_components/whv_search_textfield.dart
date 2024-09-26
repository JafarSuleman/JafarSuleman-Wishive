import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/main.dart';

import 'package:socialv/whv/utils/whv_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../whv_speech_listener_dialog.dart';
import 'whv_add_bookmark_bottom_sheet.dart';

class WhvSearchTextField extends StatefulWidget {
  const WhvSearchTextField({
    super.key,
  });

  @override
  State<WhvSearchTextField> createState() => _WhvSearchTextFieldState();
}

class _WhvSearchTextFieldState extends State<WhvSearchTextField> {
  final _searchTextFieldFocusNode = FocusNode();

  initState() {
    super.initState();
    _searchTextFieldFocusNode.addListener(() {
      if (_searchTextFieldFocusNode.hasFocus) {
        webviewStore.toggleIsSearching(true);
        webviewStore.searchTextField?.selection = TextSelection(
          baseOffset: 0,
          extentOffset: webviewStore.searchTextField?.value.text.length ?? 0,
        );
      }
    });
  }

  String formatURL(String input) {
    String formattedURL = input.trim();
    if (!formattedURL.startsWith('http://') &&
        !formattedURL.startsWith('https://')) {
      formattedURL = 'https://' + formattedURL;
    }
    return formattedURL;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: context.dividerColor.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 8, right: 5),
      child: Observer(builder: (_) {
        return Row(
          children: [
            InkWell(
              child: webviewStore.hasSearched
                  ? Image.asset(
                      ic_bars,
                      color: context.iconColor,
                      height: 18,
                      width: 18,
                    )
                  : Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: context.iconColor,
                      size: 18,
                    ),
              onTap: () {
                if (webviewStore.hasSearched) {
                  boomarksStore.getBookmarks();
                  var screenHeight = MediaQuery.of(context).size.height;

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      maxHeight: screenHeight < 600
                          ? screenHeight < 300
                              ? screenHeight
                              : screenHeight * 0.5
                          : screenHeight * 0.35,
                    ),
                    builder: (context) => WhvAddBookmarkBottomSheet(),
                  );
                } else {
                  webviewStore.loadUrl();
                }
              },
            ),
            Expanded(
              child: TextField(
                controller: webviewStore.searchTextField,
                focusNode: _searchTextFieldFocusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: whvLanguage.searchOrEnterWebsite,
                  hintStyle: secondaryTextStyle(size: 11),
                  contentPadding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                    bottom: 10,
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                onSubmitted: (value) async {
                  // this is the mechanism for search and formating a url
                  if (value.isNotEmpty) {
                    String newURL = value;

                    if (!value.contains(" ")) {
                      if (value.contains(".")) {
                        var isUrlLaunchable =
                            await canLaunchUrl(Uri.parse(newURL));

                        if (!isUrlLaunchable) {
                          if (!value.contains("www")) {
                            newURL = "www." + newURL;
                          }
                        }
                        newURL = formatURL(newURL);

                        var isValidUrl = await webviewStore.validateUrl(newURL);

                        if (isValidUrl) {
                          webviewStore.loadUrl(newUrl: newURL);
                        } else {
                          webviewStore.loadUrl();
                        }
                      } else {
                        webviewStore.loadUrl();
                      }
                    } else {
                      webviewStore.loadUrl();
                    }
                  }
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    webviewStore.toggleHasSearched(false);
                  }
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            InkWell(
              child: Icon(
                webviewStore.hasSearched ? Icons.replay_outlined : Icons.mic,
                color: context.iconColor,
              ),
              onTap: () async {
                if (webviewStore.hasSearched) {
                  webviewStore.webViewController?.reload();
                } else {
                  webviewStore.toggleIsSearching(false);
                  await showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: WhvSpeachListeningDialog(),
                    ),
                  );

                  if (webviewStore.speechText != "") {
                    webviewStore
                        .updateSearchTextFieldValue(webviewStore.speechText);
                    webviewStore.loadUrl();
                  }
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
