import 'package:flutter/material.dart';
import 'package:socialv/whv/models/whv_dashboard_data_model.dart';

import 'whv_my_wishlists_item.dart';

class WhvMyWishlists extends StatelessWidget {
  const WhvMyWishlists({super.key, required this.myWishes});
  final List<WhvWishlist> myWishes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          myWishes.length,
          (index) => WhvMyWishlistsItem(
            wishlistItem: myWishes[index],
          ),
        ),
      ),
    );
  }
}
