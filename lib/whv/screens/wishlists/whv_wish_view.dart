import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_data_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_detail_screen.dart';

class WhvWishScreen extends StatefulWidget {

  String? shareKey;

  int wishListId;

  WhvWishScreen({required this.wishListId});

  @override
  State<WhvWishScreen> createState() => _WhvWishScreenState(wishListId: wishListId.validate());
}

class _WhvWishScreenState extends State<WhvWishScreen> {

  List<WhvWishDataModel> wishModelList = [];
  late Future<List<WhvWishDataModel>> whvWishes;
  ScrollController _scrollController = ScrollController();
  int wishListId;
  _WhvWishScreenState({required this.wishListId});
  int mPage = 1;
  bool mIsLastPage = false;
  bool isError = false;

  @override
  void initState() {
    whvWishes = getTheWishes();
    super.initState();

    _scrollController.addListener(() {
      /// scroll down
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (appStore.showShopBottom) appStore.setShopBottom(false);
      }

      /// scroll up
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!appStore.showShopBottom) appStore.setShopBottom(true);
      }

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!mIsLastPage) {
          mPage++;
          setState(() {});
          appStore.setLoading(true);
          whvWishes = getTheWishes();
        }
      }
    });
  }

  Future<List<WhvWishDataModel>> getTheWishes() async {
    appStore.setLoading(true);

    await whvGetTheWishes(wishListId: wishListId, page: mPage).then((value) {
      if (mPage == 1) wishModelList.clear();

      mIsLastPage = value.length != 20;
      wishModelList.addAll(value);
      setState(() {});
      appStore.setLoading(false);
    }).catchError((e) {
      isError = true;
      setState(() {});
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });

    return wishModelList;
  }

  Future<void> onRefresh() async {
    isError = false;
    mPage = 1;
    whvWishes = getTheWishes();
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
            FutureBuilder<List<WhvWishDataModel>>(
              future: whvWishes,
              builder: (ctx, snap) {

                if (snap.hasError) {
                  return NoDataWidget(
                    imageWidget: NoDataLottieWidget(),
                    title: isError ? language.somethingWentWrong : language.noDataFound,
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
                      title: isError ? language.somethingWentWrong : language.noDataFound,
                      onRetry: () {
                        onRefresh();
                      },
                      retryText: '   ${language.clickToRefresh}   ',
                    ).center();
                  }
                  else {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
                      controller: _scrollController,
                      child: AnimatedWrap(
                        alignment: WrapAlignment.start,
                        itemCount: wishModelList.length,
                        spacing: 16,
                        runSpacing: 16,
                        slideConfiguration: SlideConfiguration(delay: 120.milliseconds),
                        itemBuilder: (ctx, index) {
                          WhvWishDataModel wishModel = wishModelList[index];

                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              String wid = (wishModel.itemId).toString();
                              //whvDeleteWish(wishId: wid);
                              WhvWishDetailScreen(whvWishDataModel: wishModel).launch(context);
                              //finish(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(color: context.cardColor, borderRadius: radius(defaultAppButtonRadius)),
                              width: context.width() / 2 - 24,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                    Text("Item Id: " + wishModel.itemId.validate(), style: boldTextStyle()).paddingSymmetric(horizontal: 10),
                                    SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image.network(wishModel.imageVariationURL.toString()),
                                    )
                                  ]
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return Observer(builder: (_) => LoadingWidget().visible(!appStore.isLoading));
              },
            ),
            Observer(
              builder: (_) {
                if (appStore.isLoading) {
                  return Positioned(
                    bottom: mPage != 1 ? 10 : null,
                    child: LoadingWidget(isBlurBackground: mPage == 1 ? true : false),
                  );
                }
                else {
                  return Offstage();
                }
              },
            ),
          ], // Stack Children
        ),
      ),
    );
  }
}
