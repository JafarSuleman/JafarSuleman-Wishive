import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/wishlists/whv_upcoming_wishlist_item.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';

import '../../models/wishlists/whv_upcoming_wishlist_model.dart';

class WhvUpcomingWishlistBody extends StatefulWidget {
  const WhvUpcomingWishlistBody({
    super.key,
  });

  @override
  State<WhvUpcomingWishlistBody> createState() =>
      _WhvUpcomingWishlistBodyState();
}

class _WhvUpcomingWishlistBodyState extends State<WhvUpcomingWishlistBody> {
  List<WhvUpcomingWishlistModel> wishListModelList = [];
  late Future<List<WhvUpcomingWishlistModel>> future;

  ScrollController _scrollController = ScrollController();

  bool isError = false;

  int mPage = 1;
  bool mIsLastPage = false;

  @override
  initState() {
    super.initState();
    future = getUpcomingWishLists();

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
          future = getUpcomingWishLists();
        }
      }
    });
  }

  Future<List<WhvUpcomingWishlistModel>> getUpcomingWishLists(
      {String? status}) async {
    appStore.setLoading(true);
    String loginId = appStore.loginUserId;

    await whvGetUpcomingWishLists(userId: loginId, page: mPage).then((value) {
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
    future = getUpcomingWishLists();
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
      child: Stack(
        children: [
          FutureBuilder<List<WhvUpcomingWishlistModel>>(
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
                          WhvUpcomingWishlistModel wishListModel =
                              wishListModelList[index];

                          return WhvUpcomingWishlistItem(
                            wishlistModel: wishListModel,
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
        ],
      ),
    );
  }
}
