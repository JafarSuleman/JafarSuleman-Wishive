import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/wishlists/whv_new_wishlist_card.dart';
import 'package:socialv/whv/components/wishlists/whv_existing_wishlist_cart.dart';

import 'package:socialv/whv/models/wishlists/whv_wishlist_model.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';

class WhvExistingWishlistView extends StatefulWidget {
  const WhvExistingWishlistView({Key? key, required this.selectedWishlistIndex})
      : super(key: key);

  final Function(int) selectedWishlistIndex;

  @override
  State<WhvExistingWishlistView> createState() => _WhvExistingWishlistView();
}

class _WhvExistingWishlistView extends State<WhvExistingWishlistView> {
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

  // The index of the selected item (the one at the middle of the wheel)
  // In the beginning, it's the index of the first item
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<WhvWishlistModel>>(
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
                  if (wishListModelList.any((element) =>
                          element.wishlistTitle ==
                          whvLanguage.createNewWishlist) ==
                      false) {
                    wishListModelList.insert(
                        0,
                        WhvWishlistModel(
                            wishlistTitle: whvLanguage.createNewWishlist));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      onRefresh();
                    },
                    color: context.primaryColor,
                    child: ListView.builder(
                      itemCount: wishListModelList.length,
                      shrinkWrap: true,
                      controller: _scrollController,
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                      itemBuilder: (BuildContext context, int index) {
                        var wishlistData = wishListModelList[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedItemIndex = index;
                              widget.selectedWishlistIndex(index);
                            });
                            if (_selectedItemIndex == 0) {
                              addToWishlistStore.isCreatingNewWishlist = true;
                              addToWishlistStore.resetAllFields(
                                shouldResetIsCreatingNewWishlist: false,
                                shouldResetUserSelectedImageUrl: false,
                                shouldResetProductUrl: false,
                              );
                            } else {
                              addToWishlistStore.setSelectedWishlistData(
                                selectedWishlistId:
                                    wishlistData.wishlistId.toString(),
                                selectedWishlistName:
                                    wishlistData.wishlistTitle.toString(),
                              );
                              if (wishlistData.dueDate != null) {
                                addToWishlistStore
                                    .setSelectedDate(wishlistData.dueDate!);
                              }
                            }
                          },
                          child: index == 0
                              ? WhvNewWishlistCard(
                                  isSelected: _selectedItemIndex == index,
                                ).paddingBottom(15)
                              : ExistingWishlistCard(
                                  wishlistData: wishlistData,
                                  isSelected: _selectedItemIndex == index,
                                ),
                        );
                      },
                    ),
                  );
                }
              }
              return Observer(
                  builder: (_) =>
                      LoadingWidget().visible(!appStore.isLoading)).center();
            },
          ),
        ),
        Observer(
          builder: (_) {
            if (appStore.isLoading) {
              log("loading loadering");
              return Expanded(
                child: LoadingWidget(isBlurBackground: false).center(),
              );
            } else {
              return Offstage();
            }
          },
        ),
      ],
    );
  }
}
