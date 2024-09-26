import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/models/whv_history_model.dart';

import '../whv_history_or_bookmark_item_widget.dart';

class WhvHistoryListView extends StatefulWidget {
  const WhvHistoryListView({super.key});

  @override
  State<WhvHistoryListView> createState() => _WhvHistoryListViewState();
}

class _WhvHistoryListViewState extends State<WhvHistoryListView> {
  @override
  initState() {
    super.initState();
    historyStore.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return historyStore.isLoading
          ? LoadingWidget()
          : historyStore.history.isEmpty
              ? NoDataLottieWidget()
              : GroupedListView<WhvHistoryModel, DateTime>(
                  elements: historyStore.history,
                  order: GroupedListOrder.DESC,
                  reverse: true,
                  floatingHeader: true,
                  // useStickyGroupSeparators: true,
                  groupBy: (WhvHistoryModel historyItem) => DateTime(
                    historyItem.date.year,
                    historyItem.date.month,
                    historyItem.date.day,
                  ),

                  groupSeparatorBuilder: (value) => _createGroupHeader(
                    value,
                    isGroupSeprator: true,
                  ),
                  groupHeaderBuilder: (historyItem) =>
                      _createGroupHeader(historyItem.date),
                  itemBuilder: (_, WhvHistoryModel historyItem) =>
                      WhvHistoryOrBookmarkItemWidget(
                    key: ValueKey(historyItem.id),
                    id: historyItem.id,
                    title: historyItem.title,
                    url: historyItem.url,
                    onDelete: () {
                      historyStore.deleteHistory(historyItem.id);
                    },
                  ),
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
