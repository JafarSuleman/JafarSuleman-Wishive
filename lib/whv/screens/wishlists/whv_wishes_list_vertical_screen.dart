import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/posts/post_model.dart';
import 'package:socialv/whv/components/wishlists/whv_wish_vertical_view.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/components/wishlists/whv_wish_item.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_wishes_list_horizontal_screen.dart';

import '../../../screens/profile/screens/member_profile_screen.dart';
import '../../../utils/cached_network_image.dart';
import 'whv_edit_wishlist_screen.dart';

class WhvWishesListVerticalViewScreen extends StatefulWidget {
  const WhvWishesListVerticalViewScreen({
    required this.wishPost,
    this.navigateToWishId = 0,
  });
  final PostModel wishPost;
  final int navigateToWishId;

  @override
  State<WhvWishesListVerticalViewScreen> createState() => _WhvWishesListVerticalViewScreenState();
}

class _WhvWishesListVerticalViewScreenState extends State<WhvWishesListVerticalViewScreen> {
  List<WhvWishModel> wishModelList = [];
  late Future<List<WhvWishModel>> future;
  ScrollController _scrollController = ScrollController();
  String wishTitle = '';
  int mPage = 1;
  bool mIsLastPage = false;
  bool isError = false;
  bool isAnimate = false;

  @override
  void initState() {
    if(widget.navigateToWishId!=0){
      isAnimate = true;
    }
    wishTitle = parseHtmlString(widget.wishPost.wishTitle.validate().replaceAll('</br>', '\n'));
    future = getWishes();
    super.initState();

    _scrollController.addListener(() {
      /// scroll down
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
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
      shareKey: '',
      wishlistId: widget.wishPost.activityId.toString(),
      page: mPage,
    ).then(handleGetWishesResponse).catchError(handleCatchError);

    return wishModelList;
  }

  handleGetWishesResponse(List<WhvWishModel> wishes, {bool }) {
    if (mPage == 1) wishModelList.clear();
    mIsLastPage = wishes.length != 20;
    wishModelList.addAll(wishes.reversed.toList());
    setState(() {});
    if(isAnimate){
      WidgetsBinding.instance.addPostFrameCallback((callback){
        isAnimate = false;
        int index = -1;
        for(int i=0; i<wishModelList.length; i++){
          if('${wishModelList[i].id}' == '${widget.navigateToWishId}'){
            index = i;
            break;
          }
        }
        print('index:-> $index');
        if(index!=-1){
          double animatePosition = context.width() * index;
          _scrollController.animateToPosition(animatePosition, milliseconds: 400);
        }
      });
    }
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
            icon: Icon(Icons.arrow_back_ios, color: context.iconColor),
            onPressed: () {
              finish(context);
            },
          ),
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(wishTitle,textAlign: TextAlign.center, style: boldTextStyle(size: 18)),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  cachedImage(
                    widget.wishPost.userImage.validate(),
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(100),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.wishPost.userName.validate(),
                            style: boldTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).flexible(),
                          if (widget.wishPost.isUserVerified == 1) Image.asset(ic_tick_filled, width: 18, height: 18, color: blueTickColor).paddingSymmetric(horizontal: 4),
                        ],
                      ),
                      Text(widget.wishPost.userEmail.validate(), style: secondaryTextStyle()),
                    ],
                  ).expand(),
                  Text(convertToAgo(widget.wishPost.dateRecorded.validate()), style: secondaryTextStyle()),
                ],
              ).paddingSymmetric(horizontal: 16).onTap(() {
                MemberProfileScreen(memberId: widget.wishPost.userId.validate()).launch(context);
              }, splashColor: Colors.transparent, highlightColor: Colors.transparent),
              20.height,
              Divider(height: 0),
              16.height,
              if(widget.wishPost.wishListComment.validate().isNotEmpty)
                Text(
                  widget.wishPost.wishListComment.validate(),
                  style: primaryTextStyle(size: 12,color: Color(0xFF48494D)),
                ).paddingOnly(left: 8,bottom: 10),
              Expanded(
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
                              padding: EdgeInsets.only(top: 16, bottom: 100),
                              controller: _scrollController,
                              child: AnimatedWrap(
                                alignment: WrapAlignment.start,
                                itemCount: wishModelList.length,
                                spacing: 16,
                                listAnimationType: ListAnimationType.Slide,
                                runSpacing: 16,
                                slideConfiguration: SlideConfiguration(delay: 120.milliseconds),
                                itemBuilder: (ctx, index) {
                                  WhvWishModel wishModel = wishModelList[index];
                                  return WhvWishItemVerticalView(
                                    wishModel: wishModel,
                                    onWishPressed: (){
                                      WhvWishesListHorizontalViewScreen(
                                        wishPost: widget.wishPost,
                                        wishModelList: wishModelList,
                                        navigateToWishId: wishModel.id.toInt(),
                                      ).launch(context);
                                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
