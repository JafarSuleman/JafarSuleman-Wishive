import 'package:flutter/material.dart';
import 'package:socialv/main.dart';

import '../whv_clear_history_or_bookmark_button.dart';
import '../whv_section_title.dart';
import 'whv_bookmarks_list.dart';

class WhvBookmarkTabView extends StatelessWidget {
  const WhvBookmarkTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: WhvSectionTitle(text: whvLanguage.bookmarks),
        ),
        WhvClearHistoryOrBookmarkButton(
          title: whvLanguage.clearBookmarks,
          onPressed: () {
            boomarksStore.clearBookmarks();
          },
        ),
        Expanded(
          child: WhvBookmarksList(),
        ),
      ],
    );
  }
}
