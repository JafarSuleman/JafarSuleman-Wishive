import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_details_screen.dart';

class WhvWishItem extends StatelessWidget {
  const WhvWishItem({
    super.key,
    required this.wishModel,
    required this.wishListKey,
  });

  final WhvWishModel wishModel;
  final String wishListKey;

  int calculateOffPercentage() {
    var difference =
        wishModel.salePrice.toDouble() - wishModel.maxPrice.toDouble();

    return (difference / wishModel.salePrice.toDouble() * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: radius(defaultAppButtonRadius),
      onTap: () {
        WhvWishDetailsScreen(wishItem: wishModel).launch(context);
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
              child:
                  cachedImage(wishModel.wishImage, width: 90, fit: BoxFit.cover)
                      .cornerRadiusWithClipRRectOnly(
                topLeft: defaultAppButtonRadius.toInt(),
                bottomLeft: defaultAppButtonRadius.toInt(),
              ),
            ),
            // 10.width,
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wishModel.productTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.height,
                            Text(
                              "${whvLanguage.qty}: ${wishModel.quantityGranted} [${wishModel.quantityDesired}]",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                color: context.iconColor,
                              ),
                            ),
                            10.height,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 18,
                                ),
                                5.width,
                                Text(
                                  "${wishModel.numberOfViews} ${whvLanguage.views}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 12,
                                    color: context.iconColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            5.height,
                            Text(
                              wishModel.onsale
                                  ? "\$ ${wishModel.salePrice.toDouble().toStringAsFixed(2)}"
                                  : "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                color: context.dividerColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            5.height,
                            Text(
                              "\$ ${wishModel.maxPrice.toDouble().toStringAsFixed(2)}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 20,
                                color: context.iconColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            5.height,
                            RichText(
                              text: TextSpan(
                                  text: wishModel.inStock
                                      ? whvLanguage.inStock + " "
                                      : whvLanguage.outOfStock + " ",
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 12,
                                    color: context.iconColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: wishModel.onsale
                                          ? "${calculateOffPercentage()}% OFF"
                                          : "",
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 12,
                                        color: context.dividerColor,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
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
    );
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: radius(defaultAppButtonRadius),
      ),
      width: context.width() / 2 - 24,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Item Id: " + wishModel.wishId.validate().toString(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text("Product Id: " + wishModel.productId.validate().toString(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text("Variation Id: " + wishModel.variationId.validate().toString(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text(
                "Date Added: " +
                    wishModel.dateCreated
                        .toString()
                        .validate()
                        .capitalizeFirstLetter(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text("Price: " + wishModel.price.validate().capitalizeFirstLetter(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text("In Stock: " + wishModel.inStock.validate().toString(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text(
                "Quantity: " +
                    wishModel.quantityDesired
                        .validate()
                        .capitalizeFirstLetter(),
                style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
        Text("Wishlist Key: " + wishListKey.validate(), style: boldTextStyle())
            .paddingSymmetric(horizontal: 10),
      ]),
    );
  }
}
