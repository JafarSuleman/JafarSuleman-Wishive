import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';

import '../whv_history_or_bookmark_item_widget.dart';

class WhvBookmarksList extends StatefulWidget {
  const WhvBookmarksList({super.key});

  @override
  State<WhvBookmarksList> createState() => _WhvBookmarksListState();
}

class _WhvBookmarksListState extends State<WhvBookmarksList> {
  @override
  initState() {
    super.initState();
    boomarksStore.getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return boomarksStore.isLoading
          ? LoadingWidget()
          : boomarksStore.bookmarks.isEmpty
              ? NoDataLottieWidget()
              : ListView.builder(
                  itemCount: boomarksStore.bookmarks.length,
                  itemBuilder: (context, index) {
                    var bookmarkItem = boomarksStore.bookmarks[index];
                    return WhvHistoryOrBookmarkItemWidget(
                      key: ValueKey(bookmarkItem.id),
                      id: bookmarkItem.id,
                      title: bookmarkItem.title,
                      url: bookmarkItem.url,
                      onDelete: () {
                        boomarksStore.removeBookmark(bookmarkItem.id);
                      },
                    );
                  },
                );
    });
  }

  Widget _createGroupHeader(
    DateTime dateTime, {
    bool isGroupSeprator = false,
  }) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: isGroupSeprator ? null : 120,
        height: 40,
        margin: EdgeInsets.only(left: 10),
        decoration: isGroupSeprator
            ? null
            : BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          DateFormat.yMMMd().format(dateTime),
          textAlign: TextAlign.center,
          style: secondaryTextStyle(color: context.cardColor),
        ),
      ),
    );
  }
}
