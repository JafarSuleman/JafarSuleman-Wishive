import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/wishlists/whv_wish_item.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_model.dart';

import 'whv_edit_wishlist_screen.dart';

class WhvWishesScreen extends StatefulWidget {
  const WhvWishesScreen({
    required this.shareKey,
    required this.wishlistId,
    this.isFromUpcomingWishlist = false,
  });
  final String? shareKey;
  final String? wishlistId;
  final bool isFromUpcomingWishlist;

  @override
  State<WhvWishesScreen> createState() =>
      _WhvWishesScreenState(wishListKey: shareKey.validate());
}

class _WhvWishesScreenState extends State<WhvWishesScreen> {
  List<WhvWishModel> wishModelList = [];
  late Future<List<WhvWishModel>> future;
  ScrollController _scrollController = ScrollController();
  String wishListKey;
  _WhvWishesScreenState({required this.wishListKey});
  int mPage = 1;
  bool mIsLastPage = false;
  bool isError = false;

  @override
  void initState() {
    future = getWishes();
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
          future = getWishes();
        }
      }
    });
  }

  Future<List<WhvWishModel>> getWishes({String? status}) async {
    appStore.setLoading(true);

    await whvGetWishes(
      shareKey: wishListKey,
      wishlistId: widget.wishlistId.toString(),
      page: mPage,
    ).then(handleGetWishesResponse).catchError(handleCatchError);

    return wishModelList;
  }

  handleGetWishesResponse(List<WhvWishModel> wishes) {
    if (mPage == 1) wishModelList.clear();

    mIsLastPage = wishes.length != 20;
    wishModelList.addAll(wishes);
    setState(() {});
    appStore.setLoading(false);
  }

  handleCatchError(dynamic e) {
    isError = true;
    setState(() {});
    appStore.setLoading(false);
    toast(e.toString(), print: true);
  }

  Future<void> onRefresh() async {
    isError = false;
    mPage = 1;
    future = getWishes();
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
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: radiusOnly(
              topLeft: defaultRadius,
              topRight: defaultRadius,
            ),
          ),
          child: Column(
            children: [
              widget.isFromUpcomingWishlist
                  ? 50.height
                  : Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          WhvEditWishlistScreen().launch(context);
                        },
                        icon: Icon(Icons.edit),
                        color: context.cardColor,
                      ),
                    ),
              Expanded(
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
                  child: Stack(
                    children: [
                      FutureBuilder<List<WhvWishModel>>(
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
                              return SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 100),
                                controller: _scrollController,
                                child: AnimatedWrap(
                                  alignment: WrapAlignment.start,
                                  itemCount: wishModelList.length,
                                  spacing: 16,
                                  runSpacing: 16,
                                  slideConfiguration: SlideConfiguration(
                                      delay: 120.milliseconds),
                                  itemBuilder: (ctx, index) {
                                    WhvWishModel wishModel =
                                        wishModelList[index];

                                    return WhvWishItem(
                                      wishModel: wishModel,
                                      wishListKey: wishListKey,
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          return Observer(
                              builder: (_) =>
                                  LoadingWidget().visible(!appStore.isLoading));
                        },
                      ),
                      Observer(
                        builder: (_) {
                          if (appStore.isLoading) {
                            return mPage != 1
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: LoadingWidget(
                                        isBlurBackground: false,
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    child: LoadingWidget(
                                      isBlurBackground: true,
                                    ),
                                  );
                          } else {
                            return Offstage();
                          }
                        },
                      ),
                    ], // Stack Children
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
