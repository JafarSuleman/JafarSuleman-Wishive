// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/trending/whv_trending_product_card_component.dart.dart';

import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/models/whv_trending_products_model/trending_product.dart';
import 'package:socialv/whv/models/whv_trending_products_model/whv_trending_filter_model.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import '../../../utils/app_constants.dart';

class WhvTrendingShopScreen extends StatefulWidget {
  // final int? categoryId;
  // final String? categoryName;

  final ScrollController scrollController;

  const WhvTrendingShopScreen({
    // this.categoryId,
    // this.categoryName,
    required this.scrollController,
  });

  @override
  State<WhvTrendingShopScreen> createState() => _WhvTrendingShopScreenState();
}

class _WhvTrendingShopScreenState extends State<WhvTrendingShopScreen> {
  ScrollController _scrollController = ScrollController();

  List<TrendingProduct> productList = [];

  late Future<List<TrendingProduct>> future;

  int mPage = 1;
  bool mIsLastPage = false;
  bool isError = false;

  List<WhvTrendingFilterModel> trendingFilterList = [
    WhvTrendingFilterModel(
        title: whvLanguage.latest,
        sortBy: WhvConstants.dateCreatedGmt,
        orderBy: WhvConstants.desc),
    WhvTrendingFilterModel(
        title: whvLanguage.customerRating,
        sortBy: WhvConstants.averageRating,
        orderBy: WhvConstants.desc),
    WhvTrendingFilterModel(
        title: whvLanguage.priceHighToLow,
        sortBy: WhvConstants.price,
        orderBy: WhvConstants.desc),
    WhvTrendingFilterModel(
        title: whvLanguage.priceLowToHigh,
        sortBy: WhvConstants.price,
        orderBy: WhvConstants.asc),
  ];

  @override
  void initState() {
    future = getTrendingProducts();
    super.initState();

    _scrollController.addListener(() {
      /// scroll down
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (appStore.showShopBottom) appStore.setShopBottom(false);

        // handle top appbar hiding
        if (widget.scrollController.offset == 0.0) {
          if (!widget.scrollController.position.isScrollingNotifier.value) {
            widget.scrollController.animToBottom(milliseconds: 200);
            whvAppStore.toggleTrendingSubTabViewScrolled(true);
          }
        }
      }

      /// scroll up
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!appStore.showShopBottom) appStore.setShopBottom(true);

        // handle top appbar hiding
        if (widget.scrollController.offset != 0.0) {
          if (!widget.scrollController.position.isScrollingNotifier.value) {
            widget.scrollController.animToTop(milliseconds: 200);

            whvAppStore.toggleTrendingSubTabViewScrolled(false);
          }
        }
      }

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!mIsLastPage) {
          mPage++;
          setState(() {});
          appStore.setLoading(true);
          future = getTrendingProducts();
        }
      }
    });

    LiveStream().on(STREAM_FILTER_ORDER_BY, (p0) {
      mPage = 1;
      future = getTrendingProducts();
      setState(() {});
    });

    afterBuildCreated(() async {
      appStore.setShopBottom(true);
    });
  }

  Future<List<TrendingProduct>> getTrendingProducts({
    String sortBy = WhvConstants.dateCreatedGmt,
    String orderBy = WhvConstants.desc,
  }) async {
    if (mPage == 1) productList.clear();
    appStore.setLoading(true);

    await whvGetTheTrendingProducts(
      sortBy: sortBy,
      orderBy: orderBy,
      page: mPage,
    ).then((value) {
      mIsLastPage = (value.trendingProducts?.length ?? 0) != PER_PAGE;
      productList.addAll(value.trendingProducts ?? []);
      setState(() {});

      appStore.setLoading(false);
    }).catchError((e) {
      isError = true;
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });

    return productList;
  }

  Future<void> onRefresh() async {
    isError = false;
    mPage = 1;
    future = getTrendingProducts();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    appStore.setLoading(false);
    LiveStream().dispose(STREAM_FILTER_ORDER_BY);
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
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            FutureBuilder<List<TrendingProduct>>(
              future: future,
              builder: (ctx, snap) {
                if (snap.hasError && !appStore.isLoading) {
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
                  if (snap.data.validate().isEmpty && !appStore.isLoading) {
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
                      padding: EdgeInsets.only(bottom: 60),
                      controller: _scrollController,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedWrap(
                            alignment: WrapAlignment.start,
                            itemCount: productList.length,
                            spacing: 16,
                            runSpacing: 16,
                            slideConfiguration:
                                SlideConfiguration(delay: 120.milliseconds),
                            itemBuilder: (ctx, index) {
                              return WhvTrendingProductCardComponent(
                                  product: productList[index]);
                            },
                          ).paddingSymmetric(horizontal: 16),
                          16.height,
                        ],
                      ),
                    );
                  }
                }
                return Center(
                    child: LoadingWidget().visible(!appStore.isLoading));
              },
            ),
            // Positioned(
            //   bottom: mPage != 1 ? context.navigationBarHeight + 8 : null,
            //   child: Observer(builder: (context) {
            //     return LoadingWidget(
            //             isBlurBackground: mPage == 1 ? true : false)
            //         .center()
            //         .visible(appStore.isLoading);
            //   }),
            // ),
            Observer(builder: (_) {
              // log('mPage $mPage');
              return mPage != 1
                  ? SizedBox()
                  : Center(
                      child: LoadingWidget(
                      isBlurBackground: mPage != 1 ? true : false,
                    ).visible(appStore.isLoading));
            })
          ],
        ),
        floatingActionButton: Observer(
          builder: (_) => AnimatedSlide(
            offset: appStore.showShopBottom ? Offset.zero : Offset(0, 0.5),
            duration: Duration(milliseconds: 350),
            child: mPage != 1 && appStore.isLoading
                ? LoadingWidget().paddingBottom(15)
                : Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: boxDecorationDefault(
                        color: context.primaryColor, borderRadius: radius(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextIcon(
                          text: language.sortBy,
                          textStyle: primaryTextStyle(
                              color:
                                  appStore.isDarkMode ? bodyDark : Colors.white,
                              size: 12),
                          prefix: Image.asset(ic_sort_by,
                              height: 18,
                              width: 18,
                              color:
                                  appStore.isDarkMode ? bodyDark : Colors.white,
                              fit: BoxFit.cover),
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: radiusOnly(
                                      topLeft: defaultRadius,
                                      topRight: defaultRadius)),
                              builder: (_) {
                                return SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(language.sortBy,
                                              style: boldTextStyle()),
                                          // TextButton(
                                          //     onPressed: () {
                                          //       finish(
                                          //           context,
                                          //           WhvTrendingFilterModel(
                                          //               value: WhvConstants.date, title: 'Clear'));
                                          //     },
                                          //     child: Text(language.clearAll, style: boldTextStyle())),
                                        ],
                                      ).paddingSymmetric(horizontal: 16),
                                      AnimatedListView(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        itemCount: trendingFilterList.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (_, index) {
                                          var data = trendingFilterList[index];

                                          return InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  productList.clear();
                                                  future = getTrendingProducts(
                                                      sortBy: data.sortBy,
                                                      orderBy: data.orderBy);
                                                });
                                                finish(context);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(data.title,
                                                    style: primaryTextStyle(
                                                        weight:
                                                            FontWeight.w500)),
                                              ));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
