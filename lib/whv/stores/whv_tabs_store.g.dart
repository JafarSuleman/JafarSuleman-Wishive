// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_tabs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvTabsStore on _WhvTabsStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_WhvTabsStoreBase.isLoading', context: context);

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

  late final _$tabsAtom =
      Atom(name: '_WhvTabsStoreBase.tabs', context: context);

  @override
  List<WhvTabModel> get tabs {
    _$tabsAtom.reportRead();
    return super.tabs;
  }

  @override
  set tabs(List<WhvTabModel> value) {
    _$tabsAtom.reportWrite(value, super.tabs, () {
      super.tabs = value;
    });
  }

  late final _$filteredTabsAtom =
      Atom(name: '_WhvTabsStoreBase.filteredTabs', context: context);

  @override
  List<WhvTabModel> get filteredTabs {
    _$filteredTabsAtom.reportRead();
    return super.filteredTabs;
  }

  @override
  set filteredTabs(List<WhvTabModel> value) {
    _$filteredTabsAtom.reportWrite(value, super.filteredTabs, () {
      super.filteredTabs = value;
    });
  }

  late final _$updateCurrentOpenedTabAsyncAction =
      AsyncAction('_WhvTabsStoreBase.updateCurrentOpenedTab', context: context);

  @override
  Future updateCurrentOpenedTab(WhvTabModel tab) {
    return _$updateCurrentOpenedTabAsyncAction
        .run(() => super.updateCurrentOpenedTab(tab));
  }

  late final _$removeCurrentOpenedTabAsyncAction =
      AsyncAction('_WhvTabsStoreBase.removeCurrentOpenedTab', context: context);

  @override
  Future removeCurrentOpenedTab() {
    return _$removeCurrentOpenedTabAsyncAction
        .run(() => super.removeCurrentOpenedTab());
  }

  late final _$getTabsAsyncAction =
      AsyncAction('_WhvTabsStoreBase.getTabs', context: context);

  @override
  Future<void> getTabs() {
    return _$getTabsAsyncAction.run(() => super.getTabs());
  }

  late final _$addTabAsyncAction =
      AsyncAction('_WhvTabsStoreBase.addTab', context: context);

  @override
  Future<void> addTab(WhvTabModel tab) {
    return _$addTabAsyncAction.run(() => super.addTab(tab));
  }

  late final _$deleteTabAsyncAction =
      AsyncAction('_WhvTabsStoreBase.deleteTab', context: context);

  @override
  Future<void> deleteTab(dynamic tabId) {
    return _$deleteTabAsyncAction.run(() => super.deleteTab(tabId));
  }

  late final _$updateTabBackendAsyncAction =
      AsyncAction('_WhvTabsStoreBase.updateTabBackend', context: context);

  @override
  Future<void> updateTabBackend(WhvTabModel tab) {
    return _$updateTabBackendAsyncAction.run(() => super.updateTabBackend(tab));
  }

  late final _$clearTabsAsyncAction =
      AsyncAction('_WhvTabsStoreBase.clearTabs', context: context);

  @override
  Future<void> clearTabs() {
    return _$clearTabsAsyncAction.run(() => super.clearTabs());
  }

  late final _$_WhvTabsStoreBaseActionController =
      ActionController(name: '_WhvTabsStoreBase', context: context);

  @override
  String? getCurrentOpenedTab() {
    final _$actionInfo = _$_WhvTabsStoreBaseActionController.startAction(
        name: '_WhvTabsStoreBase.getCurrentOpenedTab');
    try {
      return super.getCurrentOpenedTab();
    } finally {
      _$_WhvTabsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isCurrentOpenedTabAvailable() {
    final _$actionInfo = _$_WhvTabsStoreBaseActionController.startAction(
        name: '_WhvTabsStoreBase.isCurrentOpenedTabAvailable');
    try {
      return super.isCurrentOpenedTabAvailable();
    } finally {
      _$_WhvTabsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic searchTab(String query) {
    final _$actionInfo = _$_WhvTabsStoreBaseActionController.startAction(
        name: '_WhvTabsStoreBase.searchTab');
    try {
      return super.searchTab(query);
    } finally {
      _$_WhvTabsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateTab(
      {required String title,
      required String url,
      required Uint8List? preview}) {
    final _$actionInfo = _$_WhvTabsStoreBaseActionController.startAction(
        name: '_WhvTabsStoreBase.updateTab');
    try {
      return super.updateTab(title: title, url: url, preview: preview);
    } finally {
      _$_WhvTabsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tabs: ${tabs},
filteredTabs: ${filteredTabs}
    ''';
  }
}
