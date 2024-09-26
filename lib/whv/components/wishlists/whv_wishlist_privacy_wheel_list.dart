// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:socialv/main.dart';
// import 'package:socialv/whv/constants/whv_constants.dart';

// import '../../constants/whv_new_wishlist_constants.dart';

// class WhvWishlistPrivacyWheel extends StatefulWidget {
//   const WhvWishlistPrivacyWheel({Key? key}) : super(key: key);

//   @override
//   State<WhvWishlistPrivacyWheel> createState() =>
//       _WhvWishlistPrivacyWheelState();
// }

// class _WhvWishlistPrivacyWheelState extends State<WhvWishlistPrivacyWheel> {
//   List<String> wishlistPrivacylist = [whvLanguage.friends, whvLanguage.private];
//   int _selectedItemIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   language.cancel,
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.leagueSpartan(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: context.iconColor,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   addToWishlistStore.wishlistPrivacy =
//                       wishlistPrivacylist[_selectedItemIndex];
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   language.done,
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.leagueSpartan(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: context.iconColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 200,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           width: double.infinity,
//           // color: Colors.amber.shade200,
//           child: ListWheelScrollView(
//             itemExtent: 25,
//             // controller: _scrollController,
//             diameterRatio: 1.8,
//             onSelectedItemChanged: (int index) {
//               // update the UI on selected item changes
//               //  WhvWishlistModel wishListModel =
//               //             wishlistPrivacylist[index];
//               setState(() {
//                 _selectedItemIndex = index;
//               });
//             },
//             // children of the list
//             children: wishlistPrivacylist
//                 .map(
//                   (e) => Container(
//                     padding: const EdgeInsets.symmetric(vertical: 3),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color:
//                           wishlistPrivacylist.indexOf(e) == _selectedItemIndex
//                               ? context.dividerColor.withOpacity(0.3)
//                               : Colors.transparent,

//                       // color: context.dividerColor.withOpacity(0.3),
//                     ),
//                     child: Text(
//                       e.toLowerCase() == WhvConstants.WhvShare
//                           ? WhvConstants.WhvFriends
//                           : e,
//                       style: TextStyle(fontSize: 14, color: context.iconColor),
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
