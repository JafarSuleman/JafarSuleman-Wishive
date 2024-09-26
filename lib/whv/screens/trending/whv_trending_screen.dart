import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/screens/shop/whv_trending_shop_screen.dart';
import 'package:socialv/whv/screens/shoppable_live/whv_live_shoppable_screen.dart';

class WhvTrendingScreen extends StatelessWidget {
  const WhvTrendingScreen({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Observer(builder: (context) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: whvAppStore.isTrendingSubTabViewScrolled ? 30 : 0,
              child: 30.height,
            );
          }),
          _tabbar(context),
          Expanded(
            child: TabBarView(
              children: [
                WhvTrendingShopScreen(
                  scrollController: controller,
                ),
                WhvLiveShoppableScreen(
                  controller: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _tabbar(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xffEBEDEE),
      ),
      padding: EdgeInsets.all(3),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.cardColor,
        ),
        labelColor: Color(0xff07142e),
        unselectedLabelColor: Color(0xff07142e).withOpacity(0.78),
        unselectedLabelStyle: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelStyle: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(
            text: whvLanguage.onWishive,
          ),
          Tab(
            text: whvLanguage.liveMarketplace,
          ),
        ],
      ),
    );
  }
}
