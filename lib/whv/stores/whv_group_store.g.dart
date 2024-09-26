// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whv_group_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhvGroupStore on _WhvGroupStoreBase, Store {
  late final _$selectedGroupIdAtom =
      Atom(name: '_WhvGroupStoreBase.selectedGroupId', context: context);

  @override
  int get selectedGroupId {
    _$selectedGroupIdAtom.reportRead();
    return super.selectedGroupId;
  }

  @override
  set selectedGroupId(int value) {
    _$selectedGroupIdAtom.reportWrite(value, super.selectedGroupId, () {
      super.selectedGroupId = value;
    });
  }

  late final _$selectedGroupIndexAtom =
      Atom(name: '_WhvGroupStoreBase.selectedGroupIndex', context: context);

  @override
  int get selectedGroupIndex {
    _$selectedGroupIndexAtom.reportRead();
    return super.selectedGroupIndex;
  }

  @override
  set selectedGroupIndex(int value) {
    _$selectedGroupIndexAtom.reportWrite(value, super.selectedGroupIndex, () {
      super.selectedGroupIndex = value;
    });
  }

  late final _$groupListAtom =
      Atom(name: '_WhvGroupStoreBase.groupList', context: context);

  @override
  List<GroupModel> get groupList {
    _$groupListAtom.reportRead();
    return super.groupList;
  }

  @override
  set groupList(List<GroupModel> value) {
    _$groupListAtom.reportWrite(value, super.groupList, () {
      super.groupList = value;
    });
  }

  late final _$_WhvGroupStoreBaseActionController =
      ActionController(name: '_WhvGroupStoreBase', context: context);

  @override
  dynamic setGroupsList(List<GroupModel> newGroupList) {
    final _$actionInfo = _$_WhvGroupStoreBaseActionController.startAction(
        name: '_WhvGroupStoreBase.setGroupsList');
    try {
      return super.setGroupsList(newGroupList);
    } finally {
      _$_WhvGroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateSelectedGroupIdAndIndex(int groudId, int index) {
    final _$actionInfo = _$_WhvGroupStoreBaseActionController.startAction(
        name: '_WhvGroupStoreBase.updateSelectedGroupIdAndIndex');
    try {
      return super.updateSelectedGroupIdAndIndex(groudId, index);
    } finally {
      _$_WhvGroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedGroupId: ${selectedGroupId},
selectedGroupIndex: ${selectedGroupIndex},
groupList: ${groupList}
    ''';
  }
}
