import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';

import 'package:socialv/whv/models/wishlists/whv_wishlist_model.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';

class WhvWishlistWheelList extends StatefulWidget {
  const WhvWishlistWheelList({Key? key}) : super(key: key);

  @override
  State<WhvWishlistWheelList> createState() => _WhvWishlistWheelList();
}

class _WhvWishlistWheelList extends State<WhvWishlistWheelList> {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  language.cancel,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.iconColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_selectedItemIndex == 0) {
                    addToWishlistStore.isCreatingNewWishlist = true;
                    addToWishlistStore.resetAllFields(
                      shouldResetIsCreatingNewWishlist: false,
                      shouldResetUserSelectedImageUrl: false,
                      shouldResetProductUrl: false,
                    );
                  } else {
                    addToWishlistStore.setSelectedWishlistData(
                      selectedWishlistId: wishListModelList[_selectedItemIndex]
                          .wishlistId
                          .toString(),
                      selectedWishlistName:
                          wishListModelList[_selectedItemIndex]
                              .wishlistTitle
                              .toString(),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  language.done,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.iconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<WhvWishlistModel>>(
          future: future,
          builder: (ctx, snap) {
            if (snap.hasError) {
              return SizedBox(
                height: 120,
                child: NoDataWidget(
                  imageWidget: NoDataLottieWidget(),
                  title: isError
                      ? language.somethingWentWrong
                      : language.noDataFound,
                  onRetry: () {
                    onRefresh();
                  },
                  retryText: '   ${language.clickToRefresh}   ',
                ).center(),
              );
            }

            if (snap.hasData) {
              if (snap.data.validate().isEmpty) {
                return SizedBox(
                  height: 120,
                  child: NoDataWidget(
                    imageWidget: NoDataLottieWidget(),
                    title: isError
                        ? language.somethingWentWrong
                        : language.noDataFound,
                    onRetry: () {
                      onRefresh();
                    },
                    retryText: '   ${language.clickToRefresh}   ',
                  ).center(),
                );
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
                  child: Container(
                    height: 120,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: double.infinity,
                    // color: Colors.amber.shade200,
                    child: ListWheelScrollView(
                      itemExtent: 25,
                      // controller: _scrollController,
                      diameterRatio: 1.8,
                      onSelectedItemChanged: (int index) {
                        // update the UI on selected item changes
                        //  WhvWishlistModel wishListModel =
                        //             wishListModelList[index];
                        setState(() {
                          _selectedItemIndex = index;
                        });
                      },
                      // children of the list
                      children: wishListModelList
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: wishListModelList.indexOf(e) ==
                                        _selectedItemIndex
                                    ? context.dividerColor.withOpacity(0.3)
                                    : Colors.transparent,

                                // color: context.dividerColor.withOpacity(0.3),
                              ),
                              child: Text(
                                e.wishlistTitle ?? '',
                                style: TextStyle(
                                    fontSize: 14, color: context.iconColor),
                              ),
                            ),
                          )
                          .toList(),
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
              return SizedBox(
                height: 100,
                child: LoadingWidget(isBlurBackground: false),
              );
              // Positioned(
              //   bottom: mPage != 1 ? 10 : null,
              //   child: SizedBox(
              //     height: 100,
              //     child: LoadingWidget(isBlurBackground: false),
              //   ),
              // );
            } else {
              return Offstage();
            }
          },
        ),
      ],
    );
  }
}
