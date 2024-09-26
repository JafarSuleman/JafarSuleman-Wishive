// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:socialv/main.dart';
// import 'package:socialv/screens/shop/components/cached_image_widget.dart';

// import 'package:socialv/whv/components/wishlists/whv_creating_new_wishlist_part.dart';
// import 'package:socialv/whv/components/wishlists/whv_title_widget.dart';
// import 'package:socialv/whv/components/wishlists/whv_wishlist_button.dart';
// import 'package:socialv/whv/components/wishlists/whv_wishlist_wheel.dart';
// import 'package:socialv/whv/constants/whv_constants.dart';
// import 'package:socialv/whv/models/wishlists/whv_wishlist_product_model.dart';
// import 'package:socialv/whv/network/whv_rest_apis.dart';
// import 'package:socialv/whv/screens/wishlists/whv_add_item_to_wishlist_success_bottom_sheet_body.dart';

// import '../../components/whv_poor_internet_connection_dialog.dart';
// import '../../constants/whv_new_wishlist_constants.dart';

// class WhvAddItemToWishlistFinalBottomSheetBody extends StatefulWidget {
//   const WhvAddItemToWishlistFinalBottomSheetBody({super.key});

//   @override
//   State<WhvAddItemToWishlistFinalBottomSheetBody> createState() =>
//       _WhvAddItemToWishlistFinalBottomSheetBodyState();
// }

// class _WhvAddItemToWishlistFinalBottomSheetBodyState
//     extends State<WhvAddItemToWishlistFinalBottomSheetBody> {
//   _trySubmit() async {
//     if (addToWishlistStore.isCreatingNewWishlist == false &&
//         addToWishlistStore.wishlistId.isEmptyOrNull) {
//       toast(whvLanguage.pleaseSelectAWishlist, print: true);
//       return;
//     }
//     // Validation When Creating a new wishlist
//     if (addToWishlistStore.isCreatingNewWishlist == true) {
//       if (addToWishlistStore.wishlistName.text.isEmpty) {
//         // show wishlist name validation while creating new wishlist.
//         toast(whvLanguage.pleaseEnterWishlistName);
//         return;
//       } else if (addToWishlistStore.wishlistPrivacy.isEmptyOrNull) {
//         //    show privacy selection toast for newly created wishlists only
//         toast(
//           whvLanguage.pleaseSelectPrivacyForWishlist,
//         );
//         return;
//       } else if (addToWishlistStore.whvDueDate == null) {
//         toast(
//           whvLanguage.wishlistDueDateValidationMesg,
//         );
//         return;
//       }
//     }

//     if (addToWishlistStore.quantity.text.toInt() < 1) {
//       toast(whvLanguage.qtyValidationMesg, print: true);
//       return;
//     } else if (addToWishlistStore.comment.text.isEmpty) {
//       toast(whvLanguage.commentIsRequired, print: true);
//       return;
//     }

//     if (await isNetworkAvailable()) {
//       _addToWishlistApiCall();
//     } else {
//       toast(errorInternetNotAvailable);
//     }
//   }

//   _addToWishlistApiCall() async {
//     var addProductToWishlistModel = WhvWishlistProductModel(
//       prodpgUrl:
//           addToWishlistStore.prodpgURL ?? WhvNewWishlistConstants.whvNONE,
//       prodpgHtml: webviewStore.hexHeadlessHtml,
//       userId: appStore.loginUserId,
//       imgvarUrl: addToWishlistStore.userSelectedImageUrl,
//       quantity: addToWishlistStore.quantity.text,
//       comment: addToWishlistStore.comment.text,
//       wishlistId:
//           addToWishlistStore.wishlistId ?? WhvNewWishlistConstants.whvNONE,
//       wishlistName: addToWishlistStore.isCreatingNewWishlist
//           ? addToWishlistStore.wishlistName.text
//           : WhvNewWishlistConstants.whvNONE,
//       wishlistPrivacy: addToWishlistStore.isCreatingNewWishlist
//           ? addToWishlistStore.wishlistPrivacy?.toLowerCase()
//           : WhvNewWishlistConstants.whvNONE,
//       wishlistDueDate:
//           addToWishlistStore.whvDueDate ?? WhvNewWishlistConstants.whvNONE,
//     );

//     if (!addToWishlistStore.isLoading) {
//       // We check the if we have the hex for the headless html if we do then we
//       // call the api for product import otherwise we check if have the headless Html
//       // if we do then we try to parse the headless html to hex again otherwise we show
//       // an  error dialog to the user and say try again.
//       if (webviewStore.hexHeadlessHtml.isNotEmpty) {
//         tryImportProduct(addProductToWishlistModel);
//       } else {
//         if (webviewStore.headlessWebviewHTML.isNotEmpty) {
//           await webviewStore.parseAndSetHexHeadlessHtml();
//         } else {
//           showPoorInternetConnectionDialog();
//           return;
//         }

//         tryImportProduct(addProductToWishlistModel);
//       }
//       Navigator.popUntil(context, (route) => route.isFirst);
//       openWishlistSuccessBottomSheet(context);
//     }
//   }

//   tryImportProduct(WhvWishlistProductModel addProductToWishlistModel) {
//     whvAddProductToWishlist(addProductToWishlistModel).then((response) {
//       if (response.status.toLowerCase() ==
//           WhvConstants.WhvSuccess.toLowerCase()) {
//         toast("${response.title} ${whvLanguage.wishAddedSuccessMessage}");
//       } else {
//         _showProductImportErrorDialog(
//           productpageUrl: addProductToWishlistModel.prodpgUrl,
//           imageUrl: addProductToWishlistModel.imgvarUrl,
//           title: whvLanguage.productTitle,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 45,
//             height: 5,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16), color: Colors.white),
//           ),
//           8.height,
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: context.cardColor,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: Observer(
//               builder: (_) {
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 10),
//                       child: Text(
//                         whvLanguage.almostThereFewDetails,
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.leagueSpartan(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: context.iconColor,
//                         ),
//                       ),
//                     ),
//                     TitleWidget(
//                       title: addToWishlistStore.isCreatingNewWishlist
//                           ? whvLanguage.newWishlistName //'New Wishlist Name'
//                           : whvLanguage.addToWishlist, //'Add to wishlist',
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 addToWishlistStore.isCreatingNewWishlist
//                                     ? WhvCreatingNewWishlistPart()
//                                     : GestureDetector(
//                                         onTap: () async {
//                                           if (await isNetworkAvailable()) {
//                                             _wishlistsBottomSheet(context);
//                                           } else {
//                                             toast(errorInternetNotAvailable);
//                                           }
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             border: Border.all(
//                                                 color: context.iconColor),
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 10,
//                                               top: 6,
//                                               bottom: 6,
//                                               right: 10,
//                                             ),
//                                             child: Observer(builder: (context) {
//                                               return Text(
//                                                 addToWishlistStore
//                                                             .exitsWishlistName !=
//                                                         null
//                                                     ? addToWishlistStore
//                                                             .exitsWishlistName ??
//                                                         ''
//                                                     : whvLanguage
//                                                         .selectWishlist, //"Select wishlist",
//                                                 style:
//                                                     GoogleFonts.leagueSpartan(
//                                                   fontSize: 13,
//                                                   fontWeight: FontWeight.normal,
//                                                   color: context.iconColor,
//                                                 ),
//                                               );
//                                             }),
//                                           ),
//                                         ),
//                                       ),
//                                 15.height,
//                                 WhvQtyTextField(),
//                               ],
//                             ),
//                           ),
//                           40.width,
//                           _productImage(
//                               imageUrl:
//                                   addToWishlistStore.userSelectedImageUrl),
//                         ],
//                       ),
//                     ),
//                     40.height,
//                     TitleWidget(
//                       title: language.comment,
//                       child: TextField(
//                         textAlignVertical: TextAlignVertical.center,
//                         controller: addToWishlistStore.comment,
//                         maxLines: 9,
//                         decoration: InputDecoration(
//                           hintText: whvLanguage.commentHintText,
//                           hintStyle: GoogleFonts.poppins(
//                             fontSize: 10,
//                             color: context.iconColor.withOpacity(0.6),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 2.0, horizontal: 8),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: context.iconColor.withOpacity(0.7),
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: context.iconColor.withOpacity(0.7),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     15.height,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         WhvWishlistButton(
//                           text: whvLanguage.back,
//                           color: context.iconColor.withOpacity(0.6),
//                           onTap: () => Navigator.pop(context),
//                         ),
//                         WhvWishlistButton(
//                           onTap: () => _trySubmit(),
//                           text: language.submit,
//                           color: context.primaryColor,
//                         ),
//                       ],
//                     ),
//                     35.height,
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _productImage({
//     required String imageUrl,
//     double width = 130,
//     double height = 130,
//   }) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: navigatorKey.currentState!.context.iconColor),
//       ),
//       child: Center(
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: CachedImageWidget(
//             url: imageUrl,
//             height: height,
//             width: width,
//           ),
//         ),
//       ),
//     );
//   }

//   _wishlistsBottomSheet(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 45,
//               height: 5,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16), color: Colors.white),
//             ),
//             8.height,
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: context.cardColor,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16)),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Column(
//                 children: [
//                   WhvWishlistWheelList(),
//                   35.height,
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   openWishlistSuccessBottomSheet(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return FractionallySizedBox(
//           heightFactor: 0.6,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 45,
//                 height: 5,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white),
//               ),
//               8.height,
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: context.cardColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16)),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: WhvAddItemToWishlistSuccessBottomSheetBody(
//                   isOnProductPage: true,
//                 ),
//               ).expand(),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   _showProductImportErrorDialog({
//     required String productpageUrl,
//     required String imageUrl,
//     required String title,
//   }) async {
//     await showDialog(
//       context: navigatorKey.currentState!.context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: radius(defaultAppButtonRadius),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 15,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _productImage(
//                 imageUrl: imageUrl,
//                 height: 160,
//                 width: 160,
//               ),
//               20.height,
//               Text(
//                 '${whvLanguage.productImportFailureMessage1} "$title" ${whvLanguage.productImportFailureMessage2} ${whvLanguage.checkYourInternetConnection}',
//                 textAlign: TextAlign.center,
//                 style: boldTextStyle(),
//               ),
//               10.height,
//               Text(
//                 whvLanguage.noticeForClickingTryAgain,
//                 textAlign: TextAlign.center,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context.pop();
//                       },
//                       child: Text(
//                         whvLanguage.close,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.popUntil(context, (route) => route.isFirst);

//                         webviewStore.loadUrl(newUrl: productpageUrl);
//                       },
//                       child: Text(
//                         whvLanguage.tryAgain,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
