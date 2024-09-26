import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/images.dart';

import 'package:socialv/whv/components/wishlists/whv_existing_wishlist_imag_container.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/constants/whv_new_wishlist_constants.dart';
import 'package:socialv/whv/components/wishlists/whv_progressbar.dart';

import 'package:socialv/whv/models/wishlists/whv_wishlist_model.dart';

class ExistingWishlistCard extends StatelessWidget {
  const ExistingWishlistCard(
      {super.key, required this.wishlistData, this.isSelected = false});
  final WhvWishlistModel wishlistData;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.cardColor,
        border: isSelected
            ? Border.all(
                color: context.primaryColor,
              )
            : null,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ExistingWishlistImagContainer(
                imageUrl: wishlistData.wishlistImage ?? ''),
            15.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  10.height,
                  Text(
                    wishlistData.wishlistTitle ?? '',
                    style: TextStyle(
                        color: context.iconColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    wishlistData.dueDate != null
                        ? DateFormat('yyyy-MM-dd').format(wishlistData.dueDate!)
                        : "",
                    style: TextStyle(
                        color: context.iconColor.withOpacity(0.8),
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        wishlistData.totalNumberOfWishes != null
                            ? '${wishlistData.totalNumberOfWishes.toString()} ${whvLanguage.items}'
                            : "",
                        style: TextStyle(
                            color: context.iconColor.withOpacity(0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      ProgressBar(),
                      wishlistData.privacy == WhvConstants.WhvShare
                          ? SvgPicture.asset(
                              ic_people,
                              height: 20,
                            )
                          : SvgPicture.asset(
                              ic_wish_lock,
                              height: 20,
                            )
                    ],
                  ),
                ],
              ),
            )
          ],
        ).paddingRight(24),
      ),
    ).paddingBottom(15);
  }
}
