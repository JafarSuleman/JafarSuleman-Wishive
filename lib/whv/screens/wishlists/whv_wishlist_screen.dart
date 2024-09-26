import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/home/components/user_detail_bottomsheet_widget.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/components/wishlists/whv_my_wishlist_body.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/screens/wishlists/whv_create_new_wishlist_screen.dart';

import '../../../screens/profile/screens/member_profile_screen.dart';

final GlobalKey<WhvMyWishlistBodyState> wishlistBodyKey =
    GlobalKey<WhvMyWishlistBodyState>();

class WhvWishlistScreen extends StatefulWidget {
  const WhvWishlistScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WhvWishlistScreen> createState() => _WhvWishlistScreenState();
}

class _WhvWishlistScreenState extends State<WhvWishlistScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(milliseconds: 500);
    _animationController.drive(CurveTween(curve: Curves.easeOutQuad));
  }

  @override
  void dispose() {
    appStore.setLoading(false);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.iconColor),
          onPressed: () {
            finish(context);
          },
        ),
        titleSpacing: 0,
        title: Text(whvLanguage.myWishlists, style: boldTextStyle(size: 22)),
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addToWishlistStore.isCreatingNewWishlist = true;
              WhvCreateNewWishlistScreen(isFromMyWishlistsScreen: true)
                  .launch(context)
                  .then((value) async {
                addToWishlistStore.resetAllFields();

                await wishlistBodyKey.currentState?.getWishLists();
              });
            },
            icon: Image.asset(
              ic_plus,
              height: 27,
              width: 27,
              color: context.iconColor,
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              ic_search,
              color: context.iconColor,
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
                        memberId: appStore.loginUserId.validate().toInt())
                    .launch(context);
              },
              icon: cachedImage(appStore.loginAvatarUrl,
                      height: 30, width: 30, fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(15),
            ),
          ),
        ],
      ),
      body: WhvMyWishlistBody(
        key: wishlistBodyKey,
      ),
    );
  }
}
