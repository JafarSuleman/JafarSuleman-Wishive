import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/cached_network_image.dart';

import 'package:socialv/whv/models/wishlists/whv_wishlist_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_screen.dart';
import 'package:socialv/whv/utils/whv_images.dart';

class WhvWishlistItem extends StatelessWidget {
  const WhvWishlistItem({
    super.key,
    required this.wishlistModel,
  });

  final WhvWishlistModel wishlistModel;

  @override
  Widget build(BuildContext context) {
    var percentageOfWishesGranted =
        wishlistModel.percentageOfWishesGranted?.floor() ?? 0;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(defaultAppButtonRadius),
        bottomRight: Radius.circular(defaultAppButtonRadius),
      ),
      child: Slidable(
        key: ValueKey(wishlistModel.wishlistId),
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: context.primaryColor,
              foregroundColor: context.cardColor,
              child: Icon(Icons.edit),
            ),
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: context.cardColor,
              child: Icon(Icons.delete_outline),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: radius(defaultAppButtonRadius),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            String? shareKey = wishlistModel.shareKey;
            WhvWishesScreen(
              shareKey: shareKey.validate(),
              wishlistId: wishlistModel.wishlistId.validate(),
            ).launch(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: radius(defaultAppButtonRadius),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 1),
                    color: context.dividerColor.withOpacity(0.1),
                  ),
                ]),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.dividerColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultAppButtonRadius),
                      bottomLeft: Radius.circular(defaultAppButtonRadius),
                    ),
                  ),
                  child: cachedImage(
                    wishlistModel.wishlistImage.validate(),
                    width: 90,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRectOnly(
                    topLeft: defaultAppButtonRadius.toInt(),
                    bottomLeft: defaultAppButtonRadius.toInt(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          wishlistModel.wishlistTitle ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.primaryColor,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                              wishlistModel.dateCreated ?? DateTime.now()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 14,
                            color: context.iconColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${wishlistModel.totalNumberOfWishes} ${whvLanguage.items}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 14,
                                  color: context.iconColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: context.primaryColor,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: LinearProgressIndicator(
                                    minHeight: 15,
                                    value: percentageOfWishesGranted / 100,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        context.primaryColor.withOpacity(0.35)),
                                    backgroundColor: context.cardColor,
                                  ),
                                ),
                              ),
                            ),
                            10.width,
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "$percentageOfWishesGranted%",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.leagueSpartan(
                                      fontSize: 14,
                                      color: context.iconColor,
                                    ),
                                  ),
                                  10.width,
                                  SvgPicture.asset(
                                    wishlistModel.privacy?.toLowerCase() ==
                                            "share"
                                        ? ic_share_wishlist
                                        : ic_private_wishlist,
                                    height: 20,
                                    width: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
