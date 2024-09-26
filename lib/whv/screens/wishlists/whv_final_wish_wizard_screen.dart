// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/shop/components/cached_image_widget.dart';
import 'package:socialv/utils/images.dart';
import 'package:socialv/whv/components/whv_poor_internet_connection_dialog.dart';

import 'package:socialv/whv/components/wishlists/whv_wishlist_quantity_container.dart';

import 'package:socialv/whv/constants/whv_new_wishlist_constants.dart';

import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/models/wishlists/whv_wishlist_product_model.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import 'package:socialv/whv/screens/wishlists/whv_add_item_to_wishlist_success_bottom_sheet_body.dart';
import "dart:developer" as dev;

import 'package:socialv/whv/screens/wishlists/whv_image_selection_screen.dart';

class WhvFinalWishWizardScreen extends StatefulWidget {
  const WhvFinalWishWizardScreen({super.key});

  @override
  State<WhvFinalWishWizardScreen> createState() =>
      _WhvFinalWishWizardScreenState();
}

class _WhvFinalWishWizardScreenState extends State<WhvFinalWishWizardScreen> {
  _trySubmit() async {
    if (addToWishlistStore.isCreatingNewWishlist == false &&
        addToWishlistStore.wishlistId.isEmptyOrNull) {
      toast(whvLanguage.pleaseSelectAWishlist, print: true);
      return;
    }
    // Validation When Creating a new wishlist
    if (addToWishlistStore.isCreatingNewWishlist == true) {
      if (addToWishlistStore.wishlistName.text.isEmpty) {
        // show wishlist name validation while creating new wishlist.
        toast(whvLanguage.pleaseEnterWishlistName);
        return;
      } else if (addToWishlistStore.wishlistPrivacy.isEmptyOrNull) {
        //    show privacy selection toast for newly created wishlists only
        toast(
          whvLanguage.pleaseSelectPrivacyForWishlist,
        );
        return;
      } else if (addToWishlistStore.whvDueDate == null &&
          addToWishlistStore.isScheduleWishlist) {
        toast(
          whvLanguage.wishlistDueDateValidationMesg,
        );
        return;
      }
    }

    if (addToWishlistStore.quantityCount.toInt() < 1) {
      toast(whvLanguage.qtyValidationMesg, print: true);
      return;
    } else if (addToWishlistStore.wishComment.text.isEmpty) {
      toast(whvLanguage.commentIsRequired, print: true);
      return;
    }

    if (await isNetworkAvailable()) {
      log('Adding item to Wishlist');
      _addToWishlistApiCall();
    } else {
      toast(errorInternetNotAvailable);
    }
  }

  _addToWishlistApiCall() async {
    var addProductToWishlistModel = WhvWishlistProductModel(
      prodpgUrl: addToWishlistStore.prodpgURL ?? WhvConstants.WhvNONE,
      prodpgHtml: webviewStore.hexHeadlessHtml,
      userId: appStore.loginUserId,
      imgvarUrl: addToWishlistStore.userSelectedImageUrl,
      quantity: addToWishlistStore.quantityCount.toString(),
      wishComment: addToWishlistStore.wishComment.text.trim(),
      wishlistComment: addToWishlistStore.wishlistComment.text.trim(),
      wishlistId: addToWishlistStore.wishlistId ?? WhvConstants.WhvNONE,
      wishlistName: addToWishlistStore.isCreatingNewWishlist
          ? addToWishlistStore.wishlistName.text
          : addToWishlistStore.exitsWishlistName ?? WhvConstants.WhvEmptyStr,
      wishlistPrivacy: addToWishlistStore.wishlistPrivacy.toLowerCase(),
      wishlistDueDate: addToWishlistStore.whvDueDate ?? WhvConstants.WhvNONE,
    );

    // dev.log('add to wishlist body ${addProductToWishlistModel.toJson()}');

    if (!addToWishlistStore.isLoading) {
      // We check the if we have the hex for the headless html if we do then we
      // call the api for product import otherwise we check if have the headless Html
      // if we do then we try to parse the headless html to hex again otherwise we show
      // an  error dialog to the user and say try again.
      if (webviewStore.hexHeadlessHtml.isNotEmpty) {
        tryImportProduct(addProductToWishlistModel);
      } else {
        if (webviewStore.headlessWebviewHTML.isNotEmpty) {
          await webviewStore.parseAndSetHexHeadlessHtml();
        } else {
          showPoorInternetConnectionDialog();
          return;
        }
        tryImportProduct(addProductToWishlistModel);
      }
      openWishlistSuccessBottomSheet(context);
    }
  }

  tryImportProduct(WhvWishlistProductModel addProductToWishlistModel) {
    whvAddProductToWishlist(addProductToWishlistModel).then((response) {
      if (response.status.toLowerCase() ==
          WhvConstants.WhvSuccess.toLowerCase()) {
        toast("${response.title} ${whvLanguage.wishAddedSuccessMessage}");
      } else {
        _showProductImportErrorDialog(
          productpageUrl: addProductToWishlistModel.prodpgUrl,
          imageUrl: addProductToWishlistModel.imgvarUrl,
          title: "Product title",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          whvLanguage.wishWizard,
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
              _trySubmit();
            },
            child: Observer(builder: (_) {
              return Container(
                height: 8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: addToWishlistStore.wishComment.text.isEmpty
                        ? context.primaryColor.withOpacity(0.2)
                        : context.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Center(
                  child: Text(
                    language.done,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: addToWishlistStore.wishComment.text.isEmpty
                            ? context.primaryColor
                            : context.cardColor),
                  ),
                ),
              );
            }),
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
            Container(
              height: 25,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            25.height,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // WhvWishlistPrivacyWidget(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (addToWishlistStore.productTitle ?? ''),
                              style: TextStyle(
                                color: context.iconColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            5.height,
                            _productImage(
                              imageUrl: addToWishlistStore.userSelectedImageUrl,
                              width: context.width(),
                              height: context.width(),
                            ),
                            15.height,
                            WhvQuantityContainer(),
                            20.height,
                          ],
                        ),
                        25.height,
                        TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: addToWishlistStore.wishComment,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            hintText: whvLanguage.commentHintText,
                            hintStyle: TextStyle(
                                fontSize: 12, color: Colors.grey.shade400),
                            fillColor: context.cardColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15, top: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _productImage({
    required String imageUrl,
    double width = 90,
    double height = 90,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: imageUrl.isEmptyOrNull
            ? Border.all(color: navigatorKey.currentState!.context.iconColor)
            : null,
      ),
      child: imageUrl.isEmpty
          ? SvgPicture.asset(
              ic_heart_list,
              color: navigatorKey.currentState!.context.primaryColor,
              height: 30,
            ).paddingAll(10)
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedImageWidget(
                    url: imageUrl,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () async {
                      // log('iscreate new wishlist ${addToWishlistStore.isCreatingNewWishlist}');
                      await WhvImageSelectionScreen(
                        htmlContent: webviewStore.htmlContent,
                        isForEditImage: true,
                      ).launch(context);
                      setState(() {});
                      // if (addToWishlistStore.isCreatingNewWishlist) {
                      //   finish(context);
                      //   finish(context);
                      //   finish(context);
                      //   addToWishlistStore.resetAllFields();
                      //   // finish(context);
                      // } else {
                      //   print("Updating");
                      //   // finish(context);
                      //   // finish(context);
                      //   // addToWishlistStore.resetAllFields();
                      // }
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: context.primaryColor, shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        ic_wish_edit,
                        height: 20,
                        color: context.cardColor,
                      ).paddingAll(5),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  openWishlistSuccessBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: FractionallySizedBox(
            heightFactor: 0.8,
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: WhvAddItemToWishlistSuccessBottomSheetBody(
                    isOnProductPage: true,
                  ),
                ).expand(),
              ],
            ),
          ),
        );
      },
    );
  }

  _showProductImportErrorDialog({
    required String productpageUrl,
    required String imageUrl,
    required String title,
  }) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: radius(defaultAppButtonRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _productImage(
                imageUrl: imageUrl,
                height: 160,
                width: 160,
              ),
              20.height,
              Text(
                '${whvLanguage.productImportFailureMessage1} "$title" ${whvLanguage.productImportFailureMessage2} ${whvLanguage.checkYourInternetConnection}',
                textAlign: TextAlign.center,
                style: boldTextStyle(),
              ),
              10.height,
              Text(
                whvLanguage.noticeForClickingTryAgain,
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        whvLanguage.close,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);

                        webviewStore.loadUrl(newUrl: productpageUrl);
                      },
                      child: Text(
                        whvLanguage.tryAgain,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
