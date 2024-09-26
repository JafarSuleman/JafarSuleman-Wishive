import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_screen.dart';

import '../../models/whv_dashboard_data_model.dart';

class WhvUpcomingWishItem extends StatelessWidget {
  const WhvUpcomingWishItem({
    super.key,
    required this.wishlistItem,
  });
  final WhvUpcomingWishlist wishlistItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String? shareKey = wishlistItem.shareKey;
        WhvWishesScreen(
          shareKey: shareKey.validate(),
          isFromUpcomingWishlist: true,
          wishlistId: wishlistItem.wishlistId,
        ).launch(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(4),
        child: Row(
          children: [
            cachedImage(wishlistItem.avatarFull,
                    height: 40, width: 40, fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(100),
            5.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    wishlistItem.name.toString(),
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.iconColor,
                    ),
                  ),
                  4.height,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          wishlistItem.wishlistTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 12,
                            color: context.iconColor,
                          ),
                        ),
                      ),
                      Text(
                        " | ",
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 12,
                          color: context.iconColor,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          DateFormat('yyyy-MM-dd')
                              .format(wishlistItem.dueDate)
                              .toString()
                              .validate()
                              .capitalizeFirstLetter(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 11,
                            color: context.iconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
