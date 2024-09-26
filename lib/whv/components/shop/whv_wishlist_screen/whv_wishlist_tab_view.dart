import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';

import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/utils/images.dart';
import 'package:socialv/whv/models/wishlists/whv_wishlist_model.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_screen.dart';

class WhvWishlistTabView extends StatefulWidget {
  const WhvWishlistTabView({
    super.key,
  });

  @override
  State<WhvWishlistTabView> createState() => _WhvWishlistTabViewState();
}

class _WhvWishlistTabViewState extends State<WhvWishlistTabView> {
  List<WhvWishlistModel> wishListModelList = [];
  late Future<List<WhvWishlistModel>> future;

  ScrollController _scrollController = ScrollController();

  bool isError = false;

  int mPage = 1;
  bool mIsLastPage = false;

  @override
  initState() {
    super.initState();
    future = getWishLists();

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
          future = getWishLists();
        }
      }
    });
  }

  Future<List<WhvWishlistModel>> getWishLists({String? status}) async {
    appStore.setLoading(true);
    String loginId = appStore.loginUserId;

    await whvGetWishLists(userId: loginId, page: mPage).then((value) {
      if (mPage == 1) wishListModelList.clear();

      mIsLastPage = value.length != 20;
      wishListModelList.addAll(value);
      setState(() {});

      appStore.setLoading(false);
    }).catchError((e) {
      isError = true;
      setState(() {});
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });

    return wishListModelList;
  }

  Future<void> onRefresh() async {
    isError = false;
    mPage = 1;
    future = getWishLists();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          FutureBuilder<List<WhvWishlistModel>>(
            future: future,
            builder: (ctx, snap) {
              if (snap.hasError) {
                return NoDataWidget(
                  imageWidget: NoDataLottieWidget(),
                  title: isError
                      ? language.somethingWentWrong
                      : language.noDataFound,
                  onRetry: () {
                    onRefresh();
                  },
                  retryText: '   ${language.clickToRefresh}   ',
                ).center();
              }

              if (snap.hasData) {
                if (snap.data.validate().isEmpty) {
                  return NoDataWidget(
                    imageWidget: NoDataLottieWidget(),
                    title: isError
                        ? language.somethingWentWrong
                        : language.noDataFound,
                    onRetry: () {
                      onRefresh();
                    },
                    retryText: '   ${language.clickToRefresh}   ',
                  ).center();
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      onRefresh();
                    },
                    color: context.primaryColor,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 100),
                      controller: _scrollController,
                      child: AnimatedWrap(
                        alignment: WrapAlignment.start,
                        itemCount: wishListModelList.length,
                        spacing: 16,
                        runSpacing: 16,
                        slideConfiguration:
                            SlideConfiguration(delay: 120.milliseconds),
                        itemBuilder: (ctx, index) {
                          WhvWishlistModel wishListModel =
                              wishListModelList[index];

                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              String? shareKey = wishListModel.shareKey;
                              WhvWishesScreen(
                                shareKey: shareKey.validate(),
                                wishlistId: wishListModel.wishlistId.validate(),
                              ).launch(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: radius(defaultAppButtonRadius)),
                              width: context.width() / 2 - 24,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      cachedImage(
                                        wishListModel.wishlistImage.validate(),
                                        height: 150,
                                        width: context.width() / 2 - 24,
                                        fit: BoxFit.cover,
                                      ).cornerRadiusWithClipRRectOnly(
                                          topRight:
                                              defaultAppButtonRadius.toInt(),
                                          topLeft:
                                              defaultAppButtonRadius.toInt()),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: context.primaryColor,
                                            borderRadius: radiusOnly(
                                                topLeft: defaultAppButtonRadius,
                                                bottomRight:
                                                    defaultAppButtonRadius)),
                                        child: Text(language.sale,
                                            style: secondaryTextStyle(
                                                size: 10, color: Colors.white)),
                                      ).visible(wishListModel.shareKey
                                          .validate()
                                          .isNotEmpty),
                                      Positioned(
                                        right: 8,
                                        top: 8,
                                        child: InkWell(
                                          onTap: () {
                                            wishListModelList.removeWhere(
                                                (element) =>
                                                    element.shareKey ==
                                                    wishListModel.shareKey);
                                            setState(() {});
                                            whvDeleteWishlist(
                                                    shareKey: wishListModel
                                                        .shareKey
                                                        .validate())
                                                .then((value) {})
                                                .catchError((e) {
                                              toast(e.toString());
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: context.primaryColor
                                                    .withAlpha(30),
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              ic_heart_filled,
                                              color: Colors.red,
                                              height: 18,
                                              width: 18,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  14.height,
                                  Text(
                                          wishListModel.wishlistTitle
                                              .validate()
                                              .capitalizeFirstLetter(),
                                          style: boldTextStyle())
                                      .paddingSymmetric(horizontal: 10),
                                  Text(
                                          wishListModel.dateCreated
                                              .toString()
                                              .validate()
                                              .capitalizeFirstLetter(),
                                          style: boldTextStyle())
                                      .paddingSymmetric(horizontal: 10),
                                  Text(
                                          wishListModel.privacy
                                              .validate()
                                              .capitalizeFirstLetter(),
                                          style: boldTextStyle())
                                      .paddingSymmetric(horizontal: 10),
                                  Text(
                                          wishListModel.shareKey
                                              .validate()
                                              .capitalizeFirstLetter(),
                                          style: boldTextStyle())
                                      .paddingSymmetric(horizontal: 10),
                                  4.height,
                                  /*
                                                PriceWidget(
                                                  price: wishListModel.price,
                                                  salePrice: wishListModel.salePrice,
                                                  regularPrice: wishListModel.regularPrice,
                                                  showDiscountPercentage: false,
                                                ).paddingSymmetric(horizontal: 10),
                                                */
                                  14.height,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
              return Observer(
                  builder: (_) => LoadingWidget().visible(!appStore.isLoading));
            },
          ),
          Observer(
            builder: (_) {
              if (appStore.isLoading) {
                return Positioned(
                  bottom: mPage != 1 ? 10 : null,
                  child: LoadingWidget(
                      isBlurBackground: mPage == 1 ? true : false),
                );
              } else {
                return Offstage();
              }
            },
          ),
        ],
      ),
    );
  }
}
