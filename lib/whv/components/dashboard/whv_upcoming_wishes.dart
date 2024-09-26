import 'package:flutter/material.dart';
import 'package:socialv/whv/models/whv_dashboard_data_model.dart';

import 'whv_upcoming_wish_item.dart';

class WhvUpcomingWishes extends StatelessWidget {
  const WhvUpcomingWishes({
    super.key,
    required this.upcomingWishes,
  });
  final List<WhvUpcomingWishlist> upcomingWishes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1 / 0.27,
      ),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: upcomingWishes.length <= 6 ? upcomingWishes.length : 6,
      itemBuilder: (context, index) => WhvUpcomingWishItem(
        wishlistItem: upcomingWishes[index],
      ),
    );
  }
}
