import 'dart:convert';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/whv/helpers/whv_db_helper.dart';
import 'package:socialv/whv/helpers/whv_random_id_generator.dart';
import 'package:socialv/whv/models/whv_tab_model.dart';
import 'package:socialv/whv/constants/whv_local_storage_tables.dart';
import 'package:socialv/whv/constants/whv_share_preference_key.dart';

part 'whv_tabs_store.g.dart';

class WhvTabsStore = _WhvTabsStoreBase with _$WhvTabsStore;

abstract class _WhvTabsStoreBase with Store {
  WhvDBHelper dbHelper = WhvDBHelper();

  @observable
  bool isLoading = false;

  @observable
  List<WhvTabModel> tabs = [];

  // we user filtered Tabs on tabs screen for filtering and searching tabs easily.
  @observable
  List<WhvTabModel> filteredTabs = [];

  WhvTabModel? currentOpenedTab;

  // List<WhvTabModel> get tabs => _tabs;

  @action
  String? getCurrentOpenedTab() {
    var currentTab = getStringAsync(WhvSharePreferencesKey.CURRENT_OPENED_TAB);

    if (currentTab.isNotEmpty) {
      currentOpenedTab = WhvTabModel.fromMap(jsonDecode(currentTab));
    }

    return currentTab.isEmptyOrNull ? "" : currentOpenedTab?.url;
  }

  // a user can delete the currently opened tab so we check if we still have the
  // tab in the tabs list or not.
  @action
  bool isCurrentOpenedTabAvailable() {
    if (currentOpenedTab != null) {
      return tabs.any((tab) {
        return currentOpenedTab?.id == tab.id;
      });
    } else {
      return false;
    }
  }

  // updates the current opened tab.
  @action
  updateCurrentOpenedTab(WhvTabModel tab) async {
    currentOpenedTab = WhvTabModel(
      id: tab.id,
      title: tab.title,
      url: tab.url,
      preview: tab.preview,
    );
    setValue(
      WhvSharePreferencesKey.CURRENT_OPENED_TAB,
      jsonEncode(tab.toMap()),
    );
  }

  // remove currentOpenedTab
  @action
  removeCurrentOpenedTab() async {
    await removeKey(WhvSharePreferencesKey.CURRENT_OPENED_TAB);
  }

  @action
  searchTab(String query) {
    var _filteredTabs = tabs.where((element) {
      return element.title.toLowerCase().contains(query.toLowerCase()) ||
          element.url.toLowerCase().contains(query.toLowerCase());
    }).toList();

    filteredTabs = _filteredTabs;
  }

  @action
  Future<void> getTabs() async {
    try {
      isLoading = true;
      var data = await dbHelper.getData(WhvLocalStorageTables.tabs);
      List<WhvTabModel> loadedTabs = [];

      data.forEach((tab) {
        loadedTabs.add(WhvTabModel.fromMap(tab));
      });

      tabs = loadedTabs;
      filteredTabs = loadedTabs;

      isLoading = false;
    } catch (e) {
      log("exception while getting tabs $e");
      throw Exception(e);
    }
  }

  @action
  Future<void> addTab(WhvTabModel tab) async {
    try {
      // whever the user clicks on the new tab button on tabs screen we create
      // a new dummy tab which doesn't have any url or title the id will be -1 though.
      var newTabs = tabs;

      var tabId = _getTabId();
      var finalTabModel = tab.copyWith(id: tabId);

      var data = await dbHelper.insert(
        table: WhvLocalStorageTables.tabs,
        data: finalTabModel.toMap(),
      );

      if (data != 0) {
        newTabs.add(finalTabModel);
        currentOpenedTab = finalTabModel;
        updateCurrentOpenedTab(finalTabModel);
      }

      tabs = List.from(newTabs);
      filteredTabs = tabs;
    } catch (e) {
      log("exception while adding tab $e");
      throw Exception(e);
    }
  }

  @action
  Future<void> deleteTab(tabId) async {
    try {
      var response = await dbHelper.delete(
        table: WhvLocalStorageTables.tabs,
        id: tabId,
      );

      if (response != 0) {
        var newTabs = tabs;
        var tabIndex = newTabs.indexWhere((tab) => tab.id == tabId);
        newTabs.removeAt(tabIndex);
        // we do all this just to make sure the tabs list state is updated.
        tabs = List.from(newTabs);
        filteredTabs = tabs;
      }
    } catch (e) {
      log("exception while deleting tab $e");
      throw Exception(e);
    }
  }

  // through this method we update the current opened tabs
  @action
  updateTab({
    required String title,
    required String url,
    required Uint8List? preview,
  }) {
    var currentTab = getStringAsync(WhvSharePreferencesKey.CURRENT_OPENED_TAB);

    if (currentTab.isNotEmpty) {
      var currentOpenedTabModel = WhvTabModel.fromMap(jsonDecode(currentTab));
      currentOpenedTab = currentOpenedTabModel;

      var finalCurrentOpenedTab = currentOpenedTabModel.copyWith(
        title: title,
        url: url,
        preview: preview,
      );
      updateTabBackend(finalCurrentOpenedTab);
    }
  }

  // updates the current tab on the local storage
  @action
  Future<void> updateTabBackend(WhvTabModel tab) async {
    try {
      var response = await dbHelper.updateData(
        table: WhvLocalStorageTables.tabs,
        id: tab.id,
        data: tab.toMap(),
      );
      if (response != -1) {
        updateCurrentOpenedTab(tab);
      }
    } catch (e) {
      log("exception while updating tab $e");
      throw Exception(e);
    }
  }

  int _getTabId() {
    var tabId = randomIntId();

    while (tabs.any((tab) => tab.id == tabId)) {
      tabId = randomIntId();
    }

    return tabId;
  }

  @action
  Future<void> clearTabs() async {
    try {
      await dbHelper.deleteTable(WhvLocalStorageTables.tabs);

      tabs = [];
      filteredTabs = [];
    } catch (e) {
      log("exception while clearing tabs $e");
      throw Exception(e);
    }
  }
}
