// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:socialv/main.dart';
// import 'package:socialv/whv/components/wishlists/whv_wishlist_privacy_wheel_list.dart';
// import 'package:socialv/whv/screens/calendar/whv_calendar_screen.dart';

// class WhvWishlistPrivacyWidget extends StatelessWidget {
//   const WhvWishlistPrivacyWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             _wishlistsPrivacyBottomSheet(context);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 color: context.primaryColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20)),
//             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Observer(builder: (_) {
//                   return Icon(
//                     addToWishlistStore.wishlistPrivacy == whvLanguage.friends
//                         ? Icons.people
//                         : Icons.lock,
//                     color: context.primaryColor,
//                     size: 20,
//                   );
//                 }),
//                 8.width,
//                 Observer(builder: (_) {
//                   return Text(
//                     addToWishlistStore.wishlistPrivacy != null
//                         ? "${addToWishlistStore.wishlistPrivacy}"
//                         : whvLanguage.selectWishlistPrivacy,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: context.primaryColor),
//                   );
//                 }),
//                 8.width,
//                 Icon(
//                   Icons.arrow_drop_down,
//                   color: context.primaryColor,
//                   size: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         10.width,
//         GestureDetector(
//           onTap: () async {
//             var date = await WhvCalendarScreen().launch(context);

//             if (date != null) addToWishlistStore.setSelectedDate(date);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 color: context.primaryColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(20)),
//             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.calendar_month,
//                   color: context.primaryColor,
//                   size: 20,
//                 ),
//                 8.width,
//                 Observer(builder: (_) {
//                   return addToWishlistStore.whvDueDate == null
//                       ? Row(
//                           children: [
//                             Container(
//                               color: context.primaryColor,
//                               height: 1,
//                               width: 10,
//                             ),
//                             5.width,
//                             Container(
//                               color: context.primaryColor,
//                               height: 1,
//                               width: 10,
//                             ),
//                           ],
//                         )
//                       : Text(
//                           addToWishlistStore.whvDueDate ?? '',
//                           style: GoogleFonts.leagueSpartan(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: context.primaryColor,
//                           ),
//                         );
//                 }),
//                 8.width,
//                 Icon(
//                   Icons.arrow_drop_down,
//                   color: context.primaryColor,
//                   size: 20,
//                 ),
//               ],
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
