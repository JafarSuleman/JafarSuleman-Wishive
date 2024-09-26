import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import 'whv_bookmark_tab_view/whv_bookmark_tab_view.dart';
import 'whv_history_tab_view/whv_history_tab_view.dart';

class WhvHistoryAndBookmarksBottomSheet extends StatefulWidget {
  const WhvHistoryAndBookmarksBottomSheet({
    super.key,
    this.index = 1,
  });
  final int index;
  @override
  State<WhvHistoryAndBookmarksBottomSheet> createState() =>
      _WhvHistoryAndBookmarksBottomSheetState();
}

class _WhvHistoryAndBookmarksBottomSheetState
    extends State<WhvHistoryAndBookmarksBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.index,
      child: Column(
        children: [
          Center(
            child: Container(
              height: 6,
              width: 45,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: context.accentColor,
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                WhvBookmarkTabView(),
                WhvHistoryTabView(),
              ],
            ),
          ),
          Container(
            color: context.cardColor,
            child: TabBar(
              unselectedLabelColor: context.iconColor,
              tabs: [
                Tab(
                  text: whvLanguage.bookmarks,
                  icon: Icon(FontAwesomeIcons.star),
                ),
                Tab(
                  text: whvLanguage.history,
                  icon: Icon(Icons.history),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
