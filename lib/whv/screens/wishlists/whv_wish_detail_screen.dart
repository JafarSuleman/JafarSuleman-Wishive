import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_data_model.dart';

class WhvWishDetailScreen extends StatefulWidget {
  WhvWishDataModel whvWishDataModel;

  WhvWishDetailScreen({required this.whvWishDataModel});

  @override
  State<WhvWishDetailScreen> createState() =>
      _WhvWishDetailScreenState(whvWishDataModel: whvWishDataModel);
}

class _WhvWishDetailScreenState extends State<WhvWishDetailScreen> {
  List<WhvWishDataModel> wishModelList = [];
  ScrollController _scrollController = ScrollController();
  WhvWishDataModel whvWishDataModel;

  _WhvWishDetailScreenState({required this.whvWishDataModel});

  int mPage = 1;
  bool mIsLastPage = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      /// scroll down
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (appStore.showShopBottom) appStore.setShopBottom(false);
      }

      /// scroll up
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!appStore.showShopBottom) appStore.setShopBottom(true);
      }

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!mIsLastPage) {
          mPage++;
          setState(() {});
          appStore.setLoading(true);
        }
      }
    });
  }

  Future<void> onRefresh() async {
    isError = false;
    mPage = 1;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    appStore.setLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      color: context.primaryColor,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: context.iconColor),
            onPressed: () {
              finish(context);
            },
          ),
          titleSpacing: 0,
          title: Text(whvLanguage.wishes, style: boldTextStyle(size: 22)),
          elevation: 0,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
              controller: _scrollController,
              child: Container(
                decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: radius(defaultAppButtonRadius)),
                width: context.width(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.network(
                            whvWishDataModel.imageVariationURL.toString()),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text("Item Id: " + whvWishDataModel.itemId.validate(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "Wishlist Id: " +
                                  whvWishDataModel.wishlistId
                                      .toString()
                                      .validate(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "Product Id: " +
                                  whvWishDataModel.productId
                                      .validate()
                                      .toString(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "Variation Id: " +
                                  whvWishDataModel.variationId
                                      .validate()
                                      .toString(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "Date Added: " +
                                  whvWishDataModel.dateAdded
                                      .validate()
                                      .capitalizeFirstLetter(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "Price: " +
                                  whvWishDataModel.price
                                      .validate()
                                      .capitalizeFirstLetter(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "In Stock: " +
                                  whvWishDataModel.inStock
                                      .validate()
                                      .toString(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                              "Quantity: " +
                                  whvWishDataModel.quantity
                                      .validate()
                                      .capitalizeFirstLetter(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text("Comment: " + whvWishDataModel.comment.validate(),
                              style: boldTextStyle())
                          .paddingSymmetric(horizontal: 10),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
