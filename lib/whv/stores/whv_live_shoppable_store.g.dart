// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_live_shoppable_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvLiveShoppableStore on _WhvLiveShoppableStoreBase, Store {
  late final _$currentUrlAtom =
      Atom(name: '_WhvLiveShoppableStoreBase.currentUrl', context: context);

  @override
  String get currentUrl {
    _$currentUrlAtom.reportRead();
    return super.currentUrl;
  }

  @override
  set currentUrl(String value) {
    _$currentUrlAtom.reportWrite(value, super.currentUrl, () {
      super.currentUrl = value;
    });
  }

  late final _$progressAtom =
      Atom(name: '_WhvLiveShoppableStoreBase.progress', context: context);

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$_WhvLiveShoppableStoreBaseActionController =
      ActionController(name: '_WhvLiveShoppableStoreBase', context: context);

  @override
  dynamic updateCurrentUrl(String newUrl) {
    final _$actionInfo = _$_WhvLiveShoppableStoreBaseActionController
        .startAction(name: '_WhvLiveShoppableStoreBase.updateCurrentUrl');
    try {
      return super.updateCurrentUrl(newUrl);
    } finally {
      _$_WhvLiveShoppableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic initializeController(InAppWebViewController controller) {
    final _$actionInfo = _$_WhvLiveShoppableStoreBaseActionController
        .startAction(name: '_WhvLiveShoppableStoreBase.initializeController');
    try {
      return super.initializeController(controller);
    } finally {
      _$_WhvLiveShoppableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateProgress(double newProgress) {
    final _$actionInfo = _$_WhvLiveShoppableStoreBaseActionController
        .startAction(name: '_WhvLiveShoppableStoreBase.updateProgress');
    try {
      return super.updateProgress(newProgress);
    } finally {
      _$_WhvLiveShoppableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeElementByTagName({required List<String> tagNames}) {
    final _$actionInfo = _$_WhvLiveShoppableStoreBaseActionController
        .startAction(name: '_WhvLiveShoppableStoreBase.removeElementByTagName');
    try {
      return super.removeElementByTagName(tagNames: tagNames);
    } finally {
      _$_WhvLiveShoppableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeElementByClassName({required List<String> classNames}) {
    final _$actionInfo =
        _$_WhvLiveShoppableStoreBaseActionController.startAction(
            name: '_WhvLiveShoppableStoreBase.removeElementByClassName');
    try {
      return super.removeElementByClassName(classNames: classNames);
    } finally {
      _$_WhvLiveShoppableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeElementById({required List<String> elementIds}) {
    final _$actionInfo = _$_WhvLiveShoppableStoreBaseActionController
        .startAction(name: '_WhvLiveShoppableStoreBase.removeElementById');
    try {
      return super.removeElementById(elementIds: elementIds);
    } finally {
      _$_WhvLiveShoppableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUrl: ${currentUrl},
progress: ${progress}
    ''';
  }
}
