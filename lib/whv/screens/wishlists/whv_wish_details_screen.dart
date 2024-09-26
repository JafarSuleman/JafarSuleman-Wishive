import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';

import '../../models/wishlists/whv_wish_model.dart';

class WhvWishDetailsScreen extends StatefulWidget {
  const WhvWishDetailsScreen({
    super.key,
    required this.wishItem,
  });

  final WhvWishModel wishItem;

  @override
  State<WhvWishDetailsScreen> createState() => _WhvWishDetailsScreenState();
}

class _WhvWishDetailsScreenState extends State<WhvWishDetailsScreen> {
  late WhvWishModel wishModel;

  @override
  initState() {
    super.initState();
    wishModel = widget.wishItem;
    updateWishViews();
  }

  updateWishViews() async {
    await whvUpdateWishViews(
      wishlistId: widget.wishItem.wishId.toString(),
    );
  }

  int calculateOffPercentage() {
    var difference =
        wishModel.salePrice.toDouble() - wishModel.maxPrice.toDouble();

    return (difference / wishModel.salePrice.toDouble() * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.iconColor),
          onPressed: () {
            finish(context);
          },
        ),
        titleSpacing: 0,
        title: Text(language.about, style: boldTextStyle(size: 22)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: radiusOnly(
            topLeft: defaultRadius,
            topRight: defaultRadius,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            borderRadius: radiusOnly(
              topLeft: defaultRadius,
              topRight: defaultRadius,
            ),
          ),
          margin: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.height,
                Center(
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      color: context.dividerColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // padding: EdgeInsets.symmetric(
                    //   vertical: 15,
                    //   horizontal: 10,
                    // ),
                    child: cachedImage(
                      wishModel.wishImage,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(25),
                  ),
                ),
                40.height,
                Text(
                  wishModel.productTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 24,
                  ),
                ),
                40.height,
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove),
                              ),
                              10.width,
                              Text(
                                wishModel.quantityDesired,
                                style: primaryTextStyle(),
                              ),
                              10.width,
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "0 to delete",
                          style: primaryTextStyle(
                            size: 14,
                            color: context.iconColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    if (wishModel.onsale)
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Text(
                              "${calculateOffPercentage()}% OFF",
                              style: primaryTextStyle(
                                color: context.iconColor.withOpacity(0.5),
                                size: 12,
                              ),
                            ),
                          ),
                          5.height,
                          Row(
                            children: [
                              Text(
                                "\$${wishModel.salePrice.toDouble().toStringAsFixed(2)}",
                                style: primaryTextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  size: 20,
                                ),
                              ),
                              3.width,
                              Text(
                                "50",
                                style: primaryTextStyle(
                                  size: 10,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${wishModel.maxPrice.toDouble().toStringAsFixed(2)}",
                              style: boldTextStyle(size: 30),
                            ),
                            3.width,
                            Text(
                              "75",
                              style: boldTextStyle(size: 12),
                            ),
                          ],
                        ),
                        Text(
                          whvLanguage.each.toUpperCase(),
                          style: boldTextStyle(
                            size: 10,
                            color: context.iconColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                40.height,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(
                    "${wishModel.wishComment.isEmptyOrNull ? whvLanguage.commentAboutThisWish : wishModel.wishComment}\n\n\n\n",
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            onPressed: () {},
            elevation: 0,
            color: context.dividerColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 11,
            ),
            child: Row(
              children: [
                Text(
                  whvLanguage.move,
                  style: boldTextStyle(
                    color: context.iconColor.withOpacity(0.5),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: context.iconColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {},
            color: context.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 12,
            ),
            child: Text(
              language.buyNow,
              style: boldTextStyle(
                color: context.cardColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
