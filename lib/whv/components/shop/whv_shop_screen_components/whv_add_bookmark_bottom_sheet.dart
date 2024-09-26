import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import "package:any_link_preview/src/helpers/link_analyzer.dart";
import 'package:socialv/whv/models/whv_bookmark_model.dart';

import 'whv_history_and_bookmarks_bottom_sheet/whv_history_and_bookmarks_bottom_sheet.dart';

class WhvAddBookmarkBottomSheet extends StatelessWidget {
  const WhvAddBookmarkBottomSheet({super.key});

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
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            height: 6,
            width: 45,
            margin: EdgeInsets.only(top: 10, bottom: 20),
            decoration: BoxDecoration(
                color: context.accentColor,
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Observer(builder: (context) {
          // just to observe and rebuild this widget
          boomarksStore.bookmarks;
          var isAlreadyBookmarked = boomarksStore.checkBookmarkedPageStatus(
              webviewStore.searchTextField?.text ?? "");
          return ListTile(
            onTap: () async {
              if (webviewStore.hasSearched &&
                  webviewStore.searchTextField!.text.isNotEmpty) {
                if (isAlreadyBookmarked) {
                  var bookmark = boomarksStore.bookmarks.singleWhere(
                      (element) =>
                          element.url.toLowerCase() ==
                          webviewStore.url.toLowerCase());
                  boomarksStore.removeBookmark(bookmark.id);
                } else {
                  var title = await getLinkData(webviewStore.url);

                  boomarksStore.addBookmark(
                    WhvBookmarkModel(
                      id: -1,
                      title: title ?? "",
                      url: webviewStore.url,
                      date: DateTime.now(),
                    ),
                  );
                }
              }
            },
            leading: Icon(
              isAlreadyBookmarked
                  ? FontAwesomeIcons.solidStar
                  : FontAwesomeIcons.star,
              color: context.iconColor,
            ),
            title: Text(whvLanguage.bookmarkThisPage),
          );
        }),
        ListTile(
          onTap: () {
            context.pop();
            var screenHeight = MediaQuery.of(context).size.height;

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.8,
                minHeight: screenHeight * 0.5,
              ),
              builder: (context) => WhvHistoryAndBookmarksBottomSheet(
                index: 0,
              ),
            );
          },
          leading: Icon(
            FontAwesomeIcons.clockRotateLeft,
            color: context.iconColor,
          ),
          title: Text(whvLanguage.viewHistoryAndBookmarks),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
