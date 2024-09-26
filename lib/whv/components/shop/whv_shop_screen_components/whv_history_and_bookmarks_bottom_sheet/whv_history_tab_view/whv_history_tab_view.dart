import 'package:flutter/material.dart';
import 'package:socialv/main.dart';

import '../whv_clear_history_or_bookmark_button.dart';
import '../whv_section_title.dart';
import 'whv_history_list_view.dart';

class WhvHistoryTabView extends StatelessWidget {
  const WhvHistoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: WhvSectionTitle(text: whvLanguage.history),
        ),
        WhvClearHistoryOrBookmarkButton(
          title: whvLanguage.clearHistory,
          onPressed: () {
            historyStore.clearHistory();
          },
        ),
        Expanded(
          child: WhvHistoryListView(),
        ),
      ],
    );
  }
}
