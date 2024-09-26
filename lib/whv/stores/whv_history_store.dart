import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:socialv/whv/helpers/whv_random_id_generator.dart';

import 'package:socialv/whv/helpers/whv_db_helper.dart';

import 'package:socialv/whv/models/whv_history_model.dart';
import 'package:socialv/whv/constants/whv_local_storage_tables.dart';

part 'whv_history_store.g.dart';

class WhvHistoryStore = _WhvHistoryStoreBase with _$WhvHistoryStore;

abstract class _WhvHistoryStoreBase with Store {
  WhvDBHelper dbHelper = WhvDBHelper();

  @observable
  bool isLoading = false;

  @observable
  List<WhvHistoryModel> history = [];

  @action
  Future<void> getHistory() async {
    try {
      isLoading = true;

      var data = await dbHelper.getData(WhvLocalStorageTables.history);
      List<WhvHistoryModel> loadedHistory = [];

      data.forEach((history) {
        loadedHistory.add(WhvHistoryModel.fromMap(history));
      });

      history = loadedHistory;
      isLoading = false;
    } catch (e) {
      log("exception while getting history $e");
      throw Exception(e);
    }
  }

  @action
  Future<void> addHistory(WhvHistoryModel historyItem) async {
    try {
      var isSameUrl = false;

      if (history.isNotEmpty) {
        isSameUrl =
            history.last.url.toLowerCase() == historyItem.url.toLowerCase();
      }

      if (isSameUrl) return;

      var finalHistoryModel = historyItem.copyWith(id: _getHistoryItemId());
      var data = await dbHelper.insert(
        table: WhvLocalStorageTables.history,
        data: finalHistoryModel.toMap(),
      );
      if (data != 0) {
        var newHistory = history;
        newHistory.add(finalHistoryModel);

        history = List.from(newHistory);
      }
    } catch (e) {
      log("exception while adding historyItem $e");
      throw Exception(e);
    }
  }

  // generates a unique id
  int _getHistoryItemId() {
    var historyId = randomIntId();

    while (history.any((tab) => tab.id == historyId)) {
      historyId = randomIntId();
    }

    return historyId;
  }

  @action
  Future<void> deleteHistory(historyItemId) async {
    try {
      var response = await dbHelper.delete(
        table: WhvLocalStorageTables.history,
        id: historyItemId,
      );

      if (response != 0) {
        var newHistory = history;
        var historyItemIndex =
            newHistory.indexWhere((history) => history.id == historyItemId);
        newHistory.removeAt(historyItemIndex);

        // we do all this just to make sure the history list state is updated.
        history = List.from(newHistory);
      }
    } catch (e) {
      log("exception while deleting historyItem $e");
      throw Exception(e);
    }
  }

  @action
  Future<void> clearHistory() async {
    try {
      await dbHelper.deleteTable(WhvLocalStorageTables.history);

      history = List.empty();
    } catch (e) {
      log("exception while clearing history $e");
      throw Exception(e);
    }
  }
}
