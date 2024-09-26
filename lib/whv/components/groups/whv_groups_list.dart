import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/groups/group_model.dart';
import 'package:socialv/screens/groups/components/group_card_component.dart';
import 'package:socialv/screens/groups/screens/group_detail_screen.dart';

class WhvGroupsList extends StatefulWidget {
  const WhvGroupsList({
    super.key,
    required this.groupList,
    required this.resetPages,
    required this.onNextPage,
  });

  final List<GroupModel> groupList;

  final Function(bool) resetPages;
  final Function() onNextPage;

  @override
  State<WhvGroupsList> createState() => _WhvGroupsListState();
}

class _WhvGroupsListState extends State<WhvGroupsList> {
  @override
  void initState() {
    super.initState();
    groupStore.updateSelectedGroupIdAndIndex(
        widget.groupList.first.id ?? -1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      slideConfiguration: SlideConfiguration(
        delay: 80.milliseconds,
        verticalOffset: 0,
        horizontalOffset: 300,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 50),
      itemCount: widget.groupList.length,
      itemBuilder: (context, index) {
        GroupModel data = widget.groupList[index];
        return GroupCardComponent(
          data: widget.groupList[index],
          callback: () {
            widget.resetPages(true);
          },
        ).paddingSymmetric(vertical: 8).onTap(
          () {
            GroupDetailScreen(
              groupId: data.id.validate(),
              groupAvatarImage: data.groupAvatarImage,
              groupCoverImage: data.groupCoverImage,
              // groupMemberCount: data.memberCount.validate().toInt(),
            ).launch(context).then((value) {
              if (value ?? false) {
                widget.resetPages(value);
              }
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        );
      },
      onNextPage: () {
        widget.onNextPage();
      },
    );
  }
}
