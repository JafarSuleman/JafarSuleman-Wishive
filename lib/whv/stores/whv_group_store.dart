import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:socialv/models/groups/group_model.dart';

part 'whv_group_store.g.dart';

class WhvGroupStore = _WhvGroupStoreBase with _$WhvGroupStore;

abstract class _WhvGroupStoreBase with Store {
  @observable
  int selectedGroupId = -1;

  @observable
  int selectedGroupIndex = -1;

  @observable
  List<GroupModel> groupList = [];

  // we use this pagecontroller on group_screnn.dart for the pageview of groups.
  late PageController groupsPageController;

  @action
  setGroupsList(List<GroupModel> newGroupList) {
    groupList = List.from(newGroupList);
  }

  // initializing the pagecontroller
  initializePageController(PageController pageController) {
    groupsPageController = pageController;
  }

  @action
  updateSelectedGroupIdAndIndex(int groudId, int index) {
    selectedGroupId = groudId;
    selectedGroupIndex = index;
  }
}
