// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_bookmarks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvBookmarksStore on _WhvBookmarksStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_WhvBookmarksStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$bookmarksAtom =
      Atom(name: '_WhvBookmarksStoreBase.bookmarks', context: context);

  @override
  List<WhvBookmarkModel> get bookmarks {
    _$bookmarksAtom.reportRead();
    return super.bookmarks;
  }

  @override
  set bookmarks(List<WhvBookmarkModel> value) {
    _$bookmarksAtom.reportWrite(value, super.bookmarks, () {
      super.bookmarks = value;
    });
  }

  late final _$getBookmarksAsyncAction =
      AsyncAction('_WhvBookmarksStoreBase.getBookmarks', context: context);

  @override
  Future<void> getBookmarks() {
    return _$getBookmarksAsyncAction.run(() => super.getBookmarks());
  }

  late final _$addBookmarkAsyncAction =
      AsyncAction('_WhvBookmarksStoreBase.addBookmark', context: context);

  @override
  Future<void> addBookmark(WhvBookmarkModel bookmarkItem) {
    return _$addBookmarkAsyncAction.run(() => super.addBookmark(bookmarkItem));
  }

  late final _$removeBookmarkAsyncAction =
      AsyncAction('_WhvBookmarksStoreBase.removeBookmark', context: context);

  @override
  Future<void> removeBookmark(int bookmarkId) {
    return _$removeBookmarkAsyncAction
        .run(() => super.removeBookmark(bookmarkId));
  }

  late final _$clearBookmarksAsyncAction =
      AsyncAction('_WhvBookmarksStoreBase.clearBookmarks', context: context);

  @override
  Future<void> clearBookmarks() {
    return _$clearBookmarksAsyncAction.run(() => super.clearBookmarks());
  }

  late final _$_WhvBookmarksStoreBaseActionController =
      ActionController(name: '_WhvBookmarksStoreBase', context: context);

  @override
  bool checkBookmarkedPageStatus(String url) {
    final _$actionInfo = _$_WhvBookmarksStoreBaseActionController.startAction(
        name: '_WhvBookmarksStoreBase.checkBookmarkedPageStatus');
    try {
      return super.checkBookmarkedPageStatus(url);
    } finally {
      _$_WhvBookmarksStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
bookmarks: ${bookmarks}
    ''';
  }
}
