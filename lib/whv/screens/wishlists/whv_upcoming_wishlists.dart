import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import '../../components/wishlists/whv_upcoming_wishlist_body.dart';

class WhvUpcomingWishlistScreen extends StatefulWidget {
  const WhvUpcomingWishlistScreen({
    Key? key,
    this.isFromUpcomingWishlist = false,
  }) : super(key: key);
  final bool isFromUpcomingWishlist;

  @override
  State<WhvUpcomingWishlistScreen> createState() =>
      _WhvUpcomingWishlistScreenState();
}

class _WhvUpcomingWishlistScreenState extends State<WhvUpcomingWishlistScreen>
    with TickerProviderStateMixin {
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    appStore.setLoading(false);
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
        title:
            Text(whvLanguage.upcomingWishlists, style: boldTextStyle(size: 22)),
        elevation: 2,
        centerTitle: true,
      ),
      body: WhvUpcomingWishlistBody(),
    );
  }
}
