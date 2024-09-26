import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class WhvShopScreenBottomNavBar extends StatelessWidget {
  const WhvShopScreenBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: context.dividerColor.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 15,
          ),
        ],
      ),
      child: PhysicalModel(
        elevation: 12,
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.shopping_bag),
            ),
          ],
          onTap: (index) {},
          labelColor: context.primaryColor,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.tab,
          // indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: context.primaryColor,
          indicator: UnderlineTabIndicator(
            insets: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 68.0),
            borderSide: BorderSide(color: context.primaryColor, width: 3),
          ),
        ),
      ),
    );
  }
}
