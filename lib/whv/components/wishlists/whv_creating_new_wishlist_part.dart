// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:socialv/main.dart';
// import 'package:socialv/whv/components/wishlists/whv_title_widget.dart';
// import 'package:socialv/whv/components/wishlists/whv_wishlist_privacy_wheel_list.dart';
// import 'package:socialv/whv/screens/calendar/whv_calendar_screen.dart';

// import '../../constants/whv_new_wishlist_constants.dart';

// class WhvCreatingNewWishlistPart extends StatelessWidget {
//   const WhvCreatingNewWishlistPart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 26,
//           child: TextField(
//             textAlignVertical: TextAlignVertical.center,
//             controller: addToWishlistStore.wishlistName,
//             keyboardType: TextInputType.text,
//             textAlign: TextAlign.start,
//             onTapOutside: (event) {
//               FocusScope.of(context).unfocus();
//             },
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.only(left: 10),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: context.iconColor.withOpacity(0.7),
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   color: context.iconColor.withOpacity(0.7),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         15.height,
//         TitleWidget(
//           title: whvLanguage.wishlistPrivacy,
//           child: GestureDetector(
//             onTap: () {
//               _wishlistsPrivacyBottomSheet(context);
//             },
//             child: Container(
//               // height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: context.iconColor),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   top: 6,
//                   bottom: 6,
//                   right: 10,
//                 ),
//                 // TODO: Changed
//                 child: Observer(builder: (_) {
//                   return Text(
//                     addToWishlistStore.wishlistPrivacy,
//                     // != null
//                     //     ? addToWishlistStore.wishlistPrivacy ==
//                     //             WhvNewWishlistConstants.whvShare
//                     //         ? WhvNewWishlistConstants.whvFriends
//                     //         : WhvNewWishlistConstants.whvPrivate
//                     //     : whvLanguage.selectWishlistPrivacy,
//                     style: GoogleFonts.leagueSpartan(
//                       fontSize: 13,
//                       fontWeight: FontWeight.normal,
//                       color: context.iconColor,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ),
//         15.height,
//         TitleWidget(
//           title: whvLanguage.dueDate,
//           child: GestureDetector(
//             onTap: () async {
//               var date = await WhvCalendarScreen().launch(context);

//               if (date != null) addToWishlistStore.setSelectedDate(date);
//             },
//             child: Container(
//               // height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: context.iconColor),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   top: 6,
//                   bottom: 6,
//                   right: 10,
//                 ),
//                 child: Observer(builder: (_) {
//                   return Text(
//                     addToWishlistStore.whvDueDate == null
//                         ? whvLanguage.selectDueDate
//                         : addToWishlistStore.whvDueDate ?? '',
//                     style: GoogleFonts.leagueSpartan(
//                       fontSize: 13,
//                       fontWeight: FontWeight.normal,
//                       color: context.iconColor,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   _wishlistsPrivacyBottomSheet(BuildContext context) async {
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
//                   WhvWishlistPrivacyWheel(),
//                   35.height,
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
