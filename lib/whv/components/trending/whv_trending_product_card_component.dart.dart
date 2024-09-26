import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/screens/shop/components/price_widget.dart';

import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/models/whv_trending_products_model/trending_product.dart';
import 'package:socialv/whv/screens/shop/whv_trending_product_detail_webview_screen.dart';

import '../../../models/woo_commerce/wishlist_model.dart';

class WhvTrendingProductCardComponent extends StatefulWidget {
  final TrendingProduct product;

  const WhvTrendingProductCardComponent({required this.product});

  @override
  State<WhvTrendingProductCardComponent> createState() =>
      _WhvTrendingProductCardComponentState();
}

class _WhvTrendingProductCardComponentState
    extends State<WhvTrendingProductCardComponent> {
  late TrendingProduct product;
  List<WishlistModel> orderList = [];

  @override
  void initState() {
    product = widget.product;

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        WhvTrendingProductDetailWebviewScreen(
          product: widget.product,
        ).launch(context);
        // ProductDetailScreen(id: product.id.validate()).launch(context);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: radius(defaultAppButtonRadius)),
        width: context.width() / 2 - 24,
        child: Column(
          children: [
            Stack(
              children: [
                cachedImage(
                  product.productImageUrl?.isNotEmpty ?? false
                      ? product.productImageUrl
                      : '',
                  height: 150,
                  width: context.width() / 2 - 24,
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRectOnly(
                    topRight: defaultAppButtonRadius.toInt(),
                    topLeft: defaultAppButtonRadius.toInt()),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                //   decoration: BoxDecoration(
                //       color: context.primaryColor,
                //       borderRadius: radiusOnly(
                //           topLeft: defaultAppButtonRadius, bottomRight: 4)),
                //   child: Text(language.sale,
                //       style: secondaryTextStyle(size: 10, color: Colors.white)),
                // ).visible(product.onSale.validate()),
              ],
            ),
            16.height,
            Text(
              product.productTitle.validate().capitalizeFirstLetter(),
              style: boldTextStyle(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ).paddingSymmetric(horizontal: 10),
            4.height,
            PriceWidget(
              price: product.price,
              // priceHtml: product.priceHtml,
              // salePrice: product.salePrice,
              regularPrice: product.regularPrice,
              // showDiscountPercentage: false,
            ).paddingSymmetric(horizontal: 10),
            8.height,
            RatingBarWidget(
              onRatingChanged: (rating) {
                //
              },
              activeColor: Colors.amber,
              inActiveColor: Colors.amber,
              rating: double.tryParse(product.averageRating ?? '3.0') ??
                  3.0, //, product. .validate().toDouble(),
              size: 18,
              disable: true,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
