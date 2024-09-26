import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/dashboard_api_response.dart';
import 'package:socialv/models/pmp_models/membership_model.dart';
import 'package:socialv/models/posts/post_in_list_model.dart';
import 'package:socialv/models/reactions/reactions_model.dart';
import 'package:socialv/network/pmp_repositry.dart';
import 'package:socialv/network/rest_apis.dart';
import 'package:socialv/screens/fragments/home_fragment.dart';
import 'package:socialv/screens/groups/screens/group_detail_screen.dart';
import 'package:socialv/screens/home/components/user_detail_bottomsheet_widget.dart';
import 'package:socialv/screens/membership/screens/membership_plans_screen.dart';
import 'package:socialv/screens/messages/screens/message_screen.dart';
import 'package:socialv/screens/post/screens/comment_screen.dart';
import 'package:socialv/screens/post/screens/single_post_screen.dart';
import 'package:socialv/screens/profile/screens/member_profile_screen.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/utils/chat_reaction_list.dart';
import 'package:socialv/whv/components/main/whv_floating_action_buttons.dart';
import 'package:socialv/whv/components/main/whv_more_options_bottom_sheet.dart';
import 'package:socialv/whv/constants/whv_notifications.dart';

import 'package:socialv/whv/screens/shop_webview/whv_shop_webview_screen.dart';
import 'package:socialv/whv/screens/trending/whv_trending_screen.dart';
import 'package:socialv/whv/screens/wishlists/whv_wishlist_screen.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/utils/webviews_handler.dart';
import 'package:socialv/whv/utils/whv_images.dart';

import '../../components/main/whv_app_bar_title_widget.dart';
import '../../components/main/whv_tab_bar.dart';
import '../dashboard/whv_dashboard_screen.dart';
import '../notifications/whv_notifications_fragment.dart';
import '../search/whv_search_fragment.dart';

import '../delta/home_page_widget.dart';
import '../delta/home_page_model.dart';

int selectedIndex = 0;

class WhvMainScreen extends StatefulWidget {
  @override
  State<WhvMainScreen> createState() => _WhvMainScreenState();
}

List<VisibilityOptions>? visibilities;
List<StoryActions>? storyActions;
List<VisibilityOptions>? accountPrivacyVisibility;
List<ReportType>? reportTypes;
List<PostInListModel>? postInListDashboard;
List<ReactionsModel> reactions = [];

class _WhvMainScreenState extends State<WhvMainScreen>
    with TickerProviderStateMixin {
  bool hasUpdate = false;
  late AnimationController _animationController;

  ScrollController _controller = ScrollController();

  late TabController tabController;

  bool onAnimationEnd = true;

  List<Widget> appFragments = [];

  @override
  void initState() {
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(milliseconds: 500);
    _animationController.drive(CurveTween(curve: Curves.easeOutQuad));

    super.initState();
    tabController = TabController(length: 4, vsync: this);
    getChatEmojiList();

    init();
  }

  Future<void> init() async {
    appFragments.addAll([
      HomeFragment(controller: _controller),
      WhvDashboardScreen(
        scrollController: _controller,
        tabController: tabController,
        onTabChanged: changeTab,
      ),
      WhvShopWebviewScreen(controller: _controller), // index 2
      WhvNotificationFragment(controller: _controller),
    ]);

    afterBuildCreated(() {
      if (isMobile) {
        OneSignal.shared.setNotificationOpenedHandler(
            (OSNotificationOpenedResult notification) async {
          notification.notification.additionalData!.entries
              .forEach((element) async {
            if (element.key == WhvNotificationAction.whvIsComment) {
              int postId = notification.notification.additionalData!.entries
                  .firstWhere((element) =>
                      element.key == WhvNotificationAction.whvPostId)
                  .value;
              if (postId != 0) {
                CommentScreen(postId: postId).launch(context);
              }
            } else if (element.key == WhvNotificationAction.whvPostId) {
              if (element.value.toString().toInt() != 0) {
                SinglePostScreen(postId: element.value.toString().toInt())
                    .launch(context);
              }
            } else if (element.key == WhvNotificationAction.whvUserID) {
              MemberProfileScreen(memberId: element.value).launch(context);
            } else if (element.key == WhvNotificationAction.whvGroupID) {
              if (pmpStore.viewSingleGroup) {
                GroupDetailScreen(groupId: element.value).launch(context);
              } else {
                MembershipPlansScreen().launch(context);
              }
            } else if (element.key == WhvNotificationAction.whvThreadID) {
              if (pmpStore.privateMessaging) {
                MessageScreen().launch(context);
              } else {
                MembershipPlansScreen().launch(context);
              }
            }
          });
        });
      }
    });

    await getReactionsList();
    defaultReactionsList();

    _controller.addListener(() {});

    selectedIndex = 0;
    setState(() {});

    getDetails();

    Map req = {
      WhvConstants.WhvPlayerID:
          getStringAsync(SharePreferencesKey.ONE_SIGNAL_PLAYER_ID),
      WhvConstants.WhvAdd: 1
    };

    await setPlayerId(req).then((value) {}).catchError((e) {
      log("Player id error : ${e.toString()}");
    });

    getNonce().then((value) {
      appStore.setNonce(value.storeApiNonce.validate());
    }).catchError(onError);

    setStatusBarColorBasedOnTheme();

    activeUser();
    getNotificationCount();
    getMediaList();
    getProductKeywordsAndUserAgents();

    if (pmpStore.pmpEnable) getUsersLevel();
  }

  changeTab(int index) {
    // NOTE: We only handle webview when we are on Shop or Shoppable Live Screen
    // if (selectedIndex == 1 || selectedIndex == 3)
    //   handleWebviewsMediaPlayback(
    //     shouldPause:
    //     selectedTabIndex: selectedIndex,
    //   );

    _pauseOrResumeShoppableLiveWebviewPlayback(
      shouldPause: index != 3 ||
          index != 1, // True if the user is on shoppable live or shop screen
    );
    selectedIndex = index;
    setState(() {});
  }

  _openMoreOptionsBottomSheet() {
    _pauseOrResumeShoppableLiveWebviewPlayback(
      shouldPause: true,
    );
    showModalBottomSheet(
      elevation: 0,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: _animationController,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.93,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
              ),
              8.height,
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: WhvMoreOptionsBotomSheet(
                  callback: () {},
                ),
              ).expand(),
            ],
          ),
        );
      },
    ).then((value) {
      _pauseOrResumeShoppableLiveWebviewPlayback(
        shouldPause: false,
      );
    });
  }

  Future<void> getProductKeywordsAndUserAgents() async {
    await whvAppStore.getAndSetProductKeywords();
    await whvAppStore.getAndSetUserAgents();
  }

  Future<void> getMediaList() async {
    await getMediaTypes().then((value) {
      if (value.any((element) => element.type == MediaTypes.gif)) {
        appStore.setShowGif(true);
      }
    }).catchError((e) {
      //
    });
    setState(() {});
  }

  _pauseOrResumeShoppableLiveWebviewPlayback({
    required bool shouldPause,
  }) {
    // NOTE: We only handle webview when we are on Shop or Shoppable Live Screen
    if (selectedIndex == 2) {
      handleWebviewsMediaPlayback(
        shouldPause: shouldPause,
        selectedTabIndex: selectedIndex,
      );
    }
  }

  Future<void> getDetails() async {
    await getDashboardDetails().then((value) {
      appStore.setNotificationCount(value.notificationCount.validate());
      appStore.setWebsocketEnable(value.isWebsocketEnable.validate());
      appStore.setVerificationStatus(value.verificationStatus.validate());
      visibilities = value.visibilities.validate();
      accountPrivacyVisibility = value.accountPrivacyVisibility.validate();
      reportTypes = value.reportTypes.validate();
      appStore.setShowStoryHighlight(value.isHighlightStoryEnable.validate());
      appStore.suggestedUserList = value.suggestedUser.validate();
      appStore.suggestedGroupsList = value.suggestedGroups.validate();
      appStore.setShowWooCommerce(value.isWoocommerceEnable.validate());
      appStore.setWooCurrency(parseHtmlString(value.wooCurrency.validate()));
      appStore.setGiphyKey(parseHtmlString(value.giphyKey.validate()));
      appStore.setReactionsEnable(value.isReactionEnable.validate());
      appStore.setLMSEnable(value.isLMSEnable.validate());
      appStore.setCourseEnable(value.isCourseEnable.validate());
      appStore.setDisplayPostCount(value.displayPostCount.validate());
      appStore.setDisplayPostCommentsCount(
          value.displayPostCommentsCount.validate());
      appStore
          .setDisplayFriendRequestBtn(value.displayFriendRequestBtn.validate());
      appStore.setShopEnable(value.isShopEnable.validate());
      appStore.setIOSGiphyKey(parseHtmlString(value.iosGiphyKey.validate()));
      messageStore.setMessageCount(value.unreadMessagesCount.validate());
      storyActions = value.storyActions.validate();
    }).catchError(onError);
  }

  Future<void> getReactionsList() async {
    await getReactions().then((value) {
      reactions = value;
    }).catchError((e) {
      log('Error: ${e.toString()}');
    });

    setState(() {});
  }

  Future<void> defaultReactionsList() async {
    await getDefaultReaction().then((value) {
      if (value.isNotEmpty) {
        appStore.setDefaultReaction(value.first);
      } else {
        if (reactions.isNotEmpty) appStore.setDefaultReaction(reactions.first);
      }
    }).catchError((e) {
      log('Error: ${e.toString()}');
    });
    setState(() {});
  }

  /*
  Future<void> postIn() async {
    await getPostInList().then((value) {
      if (value.isNotEmpty) {
        postInListDashboard = value;
      }
    }).catchError(onError);

    setState(() {});
  }
  */

  Future<void> getUsersLevel() async {
    await getMembershipLevelForUser(userId: appStore.loginUserId.toInt())
        .then((value) {
      String? levelId;
      if (value != null) {
        MembershipModel membership = MembershipModel.fromJson(value);

        levelId = membership.id;
        setState(() {});
        pmpStore.setPmpMembership(levelId.validate());
      }

      setRestrictions(levelId: levelId);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      onWillPop: () {
        if (selectedIndex != 0) {
          selectedIndex = 0;
          tabController.index = 0;
          setState(() {});
          return Future.value(true);
        }
        return Future.value(true);
      },
      child: RefreshIndicator(
        onRefresh: () {
          if (tabController.index == 0) {
            LiveStream().emit(WhvConstants.WhvOnDashboardData);
          } else if (tabController.index == 2) {
            LiveStream().emit(GetUserStories);
            LiveStream().emit(OnAddPost);
          } else if (tabController.index == 3) {
            LiveStream().emit(STREAM_FILTER_ORDER_BY);
          } else if (tabController.index == 4) {
            LiveStream().emit(RefreshNotifications);
          }

          return Future.value(true);
        },
        color: context.primaryColor,
        child: Scaffold(
          body: CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              Theme(
                data: ThemeData(useMaterial3: false),
                child: SliverAppBar(
                  forceElevated: true,
                  elevation: 0.5,
                  expandedHeight: 110,
                  floating: true,
                  pinned: false,
                  backgroundColor: context.scaffoldBackgroundColor,
                  title: WhvAppBarTitleWidget(
                    tabIndex: tabController.index,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        _pauseOrResumeShoppableLiveWebviewPlayback(
                          shouldPause: true,
                        );
                        WhvWishlistScreen().launch(context).then((value) {
                          _pauseOrResumeShoppableLiveWebviewPlayback(
                            shouldPause: false,
                          );
                        });
                      },
                      icon: Image.asset(
                        ic_heart,
                        height: 25,
                        width: 25,
                        color: context.iconColor,
                        fit: BoxFit.fill,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _pauseOrResumeShoppableLiveWebviewPlayback(
                          shouldPause: true,
                        );
                        WhvSearchFragment().launch(context).then((value) {
                          _pauseOrResumeShoppableLiveWebviewPlayback(
                            shouldPause: false,
                          );
                        });
                      },
                      icon: Image.asset(
                        ic_search,
                        color: context.iconColor,
                        height: 22,
                        width: 22,
                        fit: BoxFit.fill,
                      ).paddingRight(10),
                    ),
                    // FFF POC
                    IconButton(
                      onPressed: () {
                        HomePageWidget().launch(context);
                      },
                      icon: Image.asset(
                        ic_confetti,
                        color: context.primaryColor,
                        height: 22,
                        width: 22,
                        fit: BoxFit.fill,
                      ).paddingRight(10),
                    ),
                    Observer(
                      builder: (_) => IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          MemberProfileScreen(
                                  memberId:
                                      appStore.loginUserId.validate().toInt())
                              .launch(context);
                        },
                        icon: cachedImage(appStore.loginAvatarUrl,
                                height: 30, width: 30, fit: BoxFit.cover)
                            .cornerRadiusWithClipRRect(15),
                      ),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
                    child: WhvTabBar(
                      tabController: tabController,
                      onTap: changeTab,
                      onMoreOptionsTap: _openMoreOptionsBottomSheet,
                      selectedIndex: selectedIndex,
                    ),
                  ),
                ),
              ),
              tabController.index == 2
                  ? SliverFillRemaining(
                      child: appFragments[tabController.index],
                    )
                  : SliverToBoxAdapter(
                      child: appFragments[tabController.index],
                    ),
            ],
          ),
          floatingActionButton: WhvMainScreenFoaltingActionButtons(
            tabController: tabController,
            animationController: _animationController,
          ),
        ),
      ),
    );
  }
}
