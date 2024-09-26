// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvAppStore on _WhvAppStoreBase, Store {
  late final _$isTrendingSubTabViewScrolledAtom = Atom(
      name: '_WhvAppStoreBase.isTrendingSubTabViewScrolled', context: context);

  @override
  bool get isTrendingSubTabViewScrolled {
    _$isTrendingSubTabViewScrolledAtom.reportRead();
    return super.isTrendingSubTabViewScrolled;
  }

  @override
  set isTrendingSubTabViewScrolled(bool value) {
    _$isTrendingSubTabViewScrolledAtom
        .reportWrite(value, super.isTrendingSubTabViewScrolled, () {
      super.isTrendingSubTabViewScrolled = value;
    });
  }

  late final _$getAndSetProductKeywordsAsyncAction = AsyncAction(
      '_WhvAppStoreBase.getAndSetProductKeywords',
      context: context);

  @override
  Future getAndSetProductKeywords() {
    return _$getAndSetProductKeywordsAsyncAction
        .run(() => super.getAndSetProductKeywords());
  }

  late final _$getAndSetUserAgentsAsyncAction =
      AsyncAction('_WhvAppStoreBase.getAndSetUserAgents', context: context);

  @override
  Future getAndSetUserAgents() {
    return _$getAndSetUserAgentsAsyncAction
        .run(() => super.getAndSetUserAgents());
  }

  late final _$_WhvAppStoreBaseActionController =
      ActionController(name: '_WhvAppStoreBase', context: context);

  @override
  dynamic toggleTrendingSubTabViewScrolled(bool newValue) {
    final _$actionInfo = _$_WhvAppStoreBaseActionController.startAction(
        name: '_WhvAppStoreBase.toggleTrendingSubTabViewScrolled');
    try {
      return super.toggleTrendingSubTabViewScrolled(newValue);
    } finally {
      _$_WhvAppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isTrendingSubTabViewScrolled: ${isTrendingSubTabViewScrolled}
    ''';
  }
}
