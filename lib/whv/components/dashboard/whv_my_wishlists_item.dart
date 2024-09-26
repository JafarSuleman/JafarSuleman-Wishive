import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/models/whv_dashboard_data_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_screen.dart';

class WhvMyWishlistsItem extends StatelessWidget {
  const WhvMyWishlistsItem({
    super.key,
    required this.wishlistItem,
  });
  final WhvWishlist wishlistItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String? shareKey = wishlistItem.shareKey;
        WhvWishesScreen(
          shareKey: shareKey.validate(),
          wishlistId: wishlistItem.wishlistId.validate(),
        ).launch(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: cachedImage(wishlistItem.wishlistImage,
                    height: 40, width: 40, fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(20),
          ),
          10.height,
          Text(
            wishlistItem.wishlistTitle,
            style: GoogleFonts.leagueSpartan(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.iconColor,
            ),
          ),
          7.height,
          Text(
            DateFormat('yyyy-MM-dd')
                .format(wishlistItem.dueDate)
                .toString()
                .validate()
                .capitalizeFirstLetter(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.leagueSpartan(
              fontSize: 14,
              color: context.iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
