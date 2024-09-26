import 'package:flutter/material.dart';
import 'package:socialv/whv/models/whv_dashboard_data_model.dart';

import '../notification/whv_activity_item.dart';

class WhvLatestActivities extends StatelessWidget {
  const WhvLatestActivities({
    super.key,
    required this.latestActivities,
  });
  final List<WhvLatestActivity> latestActivities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: latestActivities
          .map(
            (activity) => WhvActivityItem(activity: activity),
          )
          .toList(),
    );
  }
}
