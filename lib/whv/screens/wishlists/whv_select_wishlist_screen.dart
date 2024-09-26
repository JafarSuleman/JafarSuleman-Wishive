// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/images.dart';
import 'package:socialv/whv/components/wishlists/whv_existing_wishlist_view.dart';
import 'package:socialv/whv/screens/wishlists/whv_create_new_wishlist_screen.dart';
import 'package:socialv/whv/screens/wishlists/whv_final_wish_wizard_screen.dart';

class WhvSelectWishlistScreen extends StatefulWidget {
  const WhvSelectWishlistScreen({super.key});

  @override
  State<WhvSelectWishlistScreen> createState() =>
      _WhvSelectWishlistScreenState();
}

class _WhvSelectWishlistScreenState extends State<WhvSelectWishlistScreen> {
  int selectedWishlistTypeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          whvLanguage.selectWishlist,
          style: TextStyle(
              color: context.iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
              // fontSize:
              ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (selectedWishlistTypeIndex == 0) {
                // navigate to new wishlist screen
                WhvCreateNewWishlistScreen().launch(context);
                addToWishlistStore.isCreatingNewWishlist = true;
                addToWishlistStore.resetAllFields(
                  shouldResetIsCreatingNewWishlist: false,
                  shouldResetUserSelectedImageUrl: false,
                  shouldResetProductUrl: false,
                );
              } else {
                // navigate to comfirm screen.
                addToWishlistStore.isCreatingNewWishlist = false;

                WhvFinalWishWizardScreen().launch(context);
              }
              // if (!addToWishlistStore.userSelectedImageUrl.isEmptyOrNull) {
              //   addtoWishlistFinalBottomSheet(context);
              // } else {
              //   toast(whvLanguage.pleaseSelectImage, print: true);
              // }
            },
            child: Container(
              height: 8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Center(
                child: Text(
                  language.next,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: context.cardColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            // 50.height,
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      whvLanguage.addORMoveWish,
                      style: TextStyle(
                          color: context.cardColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    10.width,
                    SvgPicture.asset(
                      ic_wish_heart,
                      color: context.cardColor,
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 239, 239),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: WhvExistingWishlistView(
                  selectedWishlistIndex: (index) {
                    setState(() {
                      selectedWishlistTypeIndex = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
