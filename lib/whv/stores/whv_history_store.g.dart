// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvHistoryStore on _WhvHistoryStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_WhvHistoryStoreBase.isLoading', context: context);

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

  late final _$historyAtom =
      Atom(name: '_WhvHistoryStoreBase.history', context: context);

  @override
  List<WhvHistoryModel> get history {
    _$historyAtom.reportRead();
    return super.history;
  }

  @override
  set history(List<WhvHistoryModel> value) {
    _$historyAtom.reportWrite(value, super.history, () {
      super.history = value;
    });
  }

  late final _$getHistoryAsyncAction =
      AsyncAction('_WhvHistoryStoreBase.getHistory', context: context);

  @override
  Future<void> getHistory() {
    return _$getHistoryAsyncAction.run(() => super.getHistory());
  }

  late final _$addHistoryAsyncAction =
      AsyncAction('_WhvHistoryStoreBase.addHistory', context: context);

  @override
  Future<void> addHistory(WhvHistoryModel historyItem) {
    return _$addHistoryAsyncAction.run(() => super.addHistory(historyItem));
  }

  late final _$deleteHistoryAsyncAction =
      AsyncAction('_WhvHistoryStoreBase.deleteHistory', context: context);

  @override
  Future<void> deleteHistory(dynamic historyItemId) {
    return _$deleteHistoryAsyncAction
        .run(() => super.deleteHistory(historyItemId));
  }

  late final _$clearHistoryAsyncAction =
      AsyncAction('_WhvHistoryStoreBase.clearHistory', context: context);

  @override
  Future<void> clearHistory() {
    return _$clearHistoryAsyncAction.run(() => super.clearHistory());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
history: ${history}
    ''';
  }
}
