import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:socialv/whv/helpers/whv_random_id_generator.dart';

import 'package:socialv/whv/helpers/whv_db_helper.dart';

import 'package:socialv/whv/constants/whv_local_storage_tables.dart';

import '../models/whv_bookmark_model.dart';

part 'whv_bookmarks_store.g.dart';

class WhvBookmarksStore = _WhvBookmarksStoreBase with _$WhvBookmarksStore;

abstract class _WhvBookmarksStoreBase with Store {
  WhvDBHelper dbHelper = WhvDBHelper();

  @observable
  bool isLoading = false;

  @observable
  List<WhvBookmarkModel> bookmarks = [];

  @action
  bool checkBookmarkedPageStatus(String url) {
    var isThisUrlAlreadyBookmarked = bookmarks
        .any((element) => element.url.toLowerCase() == url.toLowerCase());
    return isThisUrlAlreadyBookmarked;
  }

  @action
  Future<void> getBookmarks() async {
    try {
      isLoading = true;
      var data = await dbHelper.getData(WhvLocalStorageTables.bookmarks);
      List<WhvBookmarkModel> loadedBookmarks = [];

      data.forEach((bookmark) {
        loadedBookmarks.add(WhvBookmarkModel.fromMap(bookmark));
      });

      bookmarks = loadedBookmarks;
      isLoading = false;
    } catch (e) {
      log("exception while getting bookmark $e");
      throw Exception(e);
    }
  }

  @action
  Future<void> addBookmark(WhvBookmarkModel bookmarkItem) async {
    try {
      var finalBookmarkModel = bookmarkItem.copyWith(id: _getBookmarkItemId());
      var data = await dbHelper.insert(
        table: WhvLocalStorageTables.bookmarks,
        data: finalBookmarkModel.toMap(),
      );
      if (data != 0) {
        var newBookmarks = bookmarks;
        newBookmarks.add(finalBookmarkModel);

        bookmarks = List.from(newBookmarks);
      }
    } catch (e) {
      log("exception while adding bookmarksItem $e");
      throw Exception(e);
    }
  }

  // generates a unique id
  int _getBookmarkItemId() {
    var bookmarkId = randomIntId();

    while (bookmarks.any((tab) => tab.id == bookmarkId)) {
      bookmarkId = randomIntId();
    }

    return bookmarkId;
  }

  @action
  Future<void> removeBookmark(int bookmarkId) async {
    try {
      var response = await dbHelper.delete(
        table: WhvLocalStorageTables.bookmarks,
        id: bookmarkId,
      );

      if (response != 0) {
        var newBookmarks = bookmarks;
        var bookmarkIndex =
            newBookmarks.indexWhere((bookmark) => bookmark.id == bookmarkId);
        newBookmarks.removeAt(bookmarkIndex);

        // we do all this just to make sure the bookmarks list state is updated.
        bookmarks = List.from(newBookmarks);
      }
    } catch (e) {
      log("exception while deleting bookmark $e");
      throw Exception(e);
    }
  }

  @action
  Future<void> clearBookmarks() async {
    try {
      await dbHelper.deleteTable(WhvLocalStorageTables.bookmarks);

      bookmarks = List.empty();
    } catch (e) {
      log("exception while clearing bookmarks $e");
      throw Exception(e);
    }
  }
}
