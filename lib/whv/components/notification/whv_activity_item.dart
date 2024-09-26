import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/screens/profile/screens/member_profile_screen.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/utils/cached_network_image.dart';

import '../../models/whv_dashboard_data_model.dart';

class WhvActivityItem extends StatelessWidget {
  const WhvActivityItem({
    super.key,
    required this.activity,
  });

  final WhvLatestActivity activity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MemberProfileScreen(
          memberId: activity.userId.toInt().validate(),
        ).launch(context);
      },
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activity.avatarFull.validate() != 'false')
                cachedImage(activity.avatarFull.validate(),
                        height: 40, width: 40, fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(20),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (activity.content.validate().isNotEmpty)
                    Text(parseHtmlString(activity.content.validate()),
                        style: primaryTextStyle(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2)
                  else if (activity.content.validate().isNotEmpty)
                    Text(
                        '${activity.component.toString().validate()} ' +
                            parseHtmlString(activity.content.validate()),
                        style: primaryTextStyle(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                  Text(convertToAgo(activity.dateCreated.toString()),
                      style: secondaryTextStyle()),
                ],
              ).expand(),
            ],
          ),
          Divider(height: 32),
        ],
      ),
    );
  }
}
