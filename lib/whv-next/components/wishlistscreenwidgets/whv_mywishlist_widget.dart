// import 'package:nb_utils/nb_utils.dart';
//
// import '../../../components/CustomMultiImageLayout/multi_image_layout.dart';
// import '../../../configs.dart';
// import '../../../whv/screens/delta/flutter_flow_theme.dart';
// import '../../../whv/screens/wishlists/whv_wishlist_screen.dart';
// import '../models/wishlists/wishlist_data.dart';
//
// Widget customMyWishlistWidget(BuildContext context, List<WishlistData> myWishlists) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 10),
//     child: Column(
//       children: [
//         Padding(
//           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
//                 child: Text(
//                   'My Wishlist',
//                   style: FlutterFlowTheme.of(context).titleMedium.override(
//                     fontFamily: 'Readex Pro',
//                     color: Colors.black.withOpacity(0.7),
//                     fontSize: 16,
//                     letterSpacing: 0,
//                   ),
//                 ),
//               ),
//               myWishlists.length>=4?Icon(
//                 Icons.arrow_forward,
//                 color: FlutterFlowTheme.of(context).secondaryText,
//                 size: 24,
//               ):Container(),
//             ],
//           ),
//         ),
//         myWishlists.isEmpty?myWishlistAddWishWidget2(context):Container(
//           height: 200,
//           child: ListView.builder(
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.horizontal,
//             itemCount: (myWishlists.length == 2) ? 3 : (myWishlists.length > 3) ? 4 : myWishlists.length,
//             itemBuilder: (context, index) {
//               if (myWishlists.length == 1) {
//                 return Row(
//                   children: [
//                     myWishListWidget(context, myWishlists[index]),
//                     myWishlistAddWishWidget(context, 220),
//                   ],
//                 );
//               } else if (myWishlists.length == 2) {
//                 if (index < 2) {
//                   return myWishListWidget(context, myWishlists[index]);
//                 } else {
//                   return myWishlistAddWishWidget(context, 110);
//                 }
//               } else if (index < 3) {
//                 return myWishListWidget(context, myWishlists[index]);
//               } else if (index == 3 && myWishlists.length > 2) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: seeAllButton(context),
//                 );
//               } else {
//                 return Container();
//               }
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }
// Align myWishListWidget(BuildContext context, WishlistData wishlist) {
//   return Align(
//     alignment: AlignmentDirectional(0, 0),
//     child: Padding(
//       padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           width: 110,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(
//                 color: Colors.grey.withOpacity(0.2)
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Flexible(
//                 fit: FlexFit.loose,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(0),
//                     bottomRight: Radius.circular(0),
//                     topLeft: Radius.circular(8),
//                     topRight: Radius.circular(8),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.contain,
//                           image: wishlist.wishlistImage==""?Image.asset(APP_ICON, height: 50, width: 52, fit: BoxFit.cover, color: Colors.white).image
//                           :Image.network(
//                             wishlist.wishlistImage ?? '',
//                           ).image,
//                         ),
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(0),
//                           bottomRight: Radius.circular(0),
//                           topLeft: Radius.circular(8),
//                           topRight: Radius.circular(8),
//                         ),
//                         shape: BoxShape.rectangle,
//                       ),
//                       alignment: AlignmentDirectional(0, 0),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 40,
//                 width: 110,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFE4DFDF).withOpacity(0.5),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(15),
//                     bottomRight: Radius.circular(15),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width:100,
//                       child: Text(
//                         wishlist.wishlistName ?? '',
//                         style: FlutterFlowTheme.of(context).bodySmall.override(
//                           fontFamily: 'Readex Pro',
//                           fontSize: 12,
//                           color: Colors.black.withOpacity(0.7),
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(
//                       wishlist.dateCreated ?? '',
//                       style: FlutterFlowTheme.of(context).bodyMedium.override(
//                         fontFamily: 'Readex Pro',
//                         color: Color(0xBE57636C),
//                         fontSize: 10,
//                         letterSpacing: 0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
// Column seeAllButton(BuildContext context) {
//   return Column(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       InkWell(
//         onTap: (){
//           WhvWishlistScreen().launch(context);
//         },
//         child: Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Colors.grey.withOpacity(0.6),
//             ),
//           ),
//           child: Icon(
//             Icons.arrow_forward,
//             color: Colors.grey.withOpacity(0.6),
//             size: 22,
//           ),
//         ),
//       ),
//       Text(
//         'See All',
//         style: FlutterFlowTheme.of(context).bodyMedium.override(
//           fontFamily: 'Readex Pro',
//           fontSize: 12,
//           color: Colors.grey.withOpacity(0.6),
//           letterSpacing: 0,
//         ),
//       ),
//     ],
//   );
// }
// Align myWishlistAddWishWidget(BuildContext context,double width) {
//   return Align(
//               alignment: AlignmentDirectional(0, 0),
//               child: Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(10, 4, 0, 0),
//                 child: Material(
//                   color: Colors.transparent,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Container(
//                       width: width,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           color: FlutterFlowTheme.of(context).alternate,
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Flexible(
//                             fit: FlexFit.loose,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(0),
//                                 topLeft: Radius.circular(8),
//                                 topRight: Radius.circular(8),
//                               ),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: Image.network(
//                                       '',
//                                     ).image,
//                                   ),
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(0),
//                                     bottomRight: Radius.circular(0),
//                                     topLeft: Radius.circular(8),
//                                     topRight: Radius.circular(8),
//                                   ),
//                                   shape: BoxShape.rectangle,
//                                 ),
//                                 alignment: AlignmentDirectional(0, 0),
//                                 child: Image.asset(
//                                   'assets/icons/Add Wish.png',
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 10),
//                             child: InkWell(
//                               onTap: (){
//                                 WhvWishlistScreen().launch(context);
//                               },
//                               child: Container(
//                                 width: 80,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.purple.withOpacity(0.5),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0, 0),
//                                   child: Text(
//                                     'Add Wish',
//                                     style: FlutterFlowTheme.of(context)
//                                         .bodyMedium
//                                         .override(
//                                       fontFamily: 'Readex Pro',
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       letterSpacing: 0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
// }
// Widget myWishlistAddWishWidget2(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
//     child: Container(
//       width: 360,
//       height: 160,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: FlutterFlowTheme.of(context).alternate,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Flexible(
//             fit: FlexFit.loose,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(0),
//                 bottomRight: Radius.circular(0),
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: Image.network(
//                       '',
//                     ).image,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(0),
//                     bottomRight: Radius.circular(0),
//                     topLeft: Radius.circular(8),
//                     topRight: Radius.circular(8),
//                   ),
//                   shape: BoxShape.rectangle,
//                 ),
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Image.asset(
//                   'assets/icons/Add Wish.png',
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 60,right: 60),
//             child: InkWell(
//               onTap: (){
//                 WhvWishlistScreen().launch(context);
//               },
//               child: Container(
//                 width: 80,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: Colors.purple.withOpacity(0.5),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Align(
//                   alignment: AlignmentDirectional(0, 0),
//                   child: Text(
//                     'Add Wish',
//                     style: FlutterFlowTheme.of(context)
//                         .bodyMedium
//                         .override(
//                       fontFamily: 'Readex Pro',
//                       color: Colors.white,
//                       fontSize: 12,
//                       letterSpacing: 0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/CustomMultiImageLayout/multi_image_layout.dart';
import '../../../configs.dart';
import '../../../whv/screens/delta/flutter_flow_theme.dart';
import '../../../whv/screens/wishlists/whv_wishlist_screen.dart';
import '../models/wishlists/wishlist_data.dart';

// Main Widget
Widget customMyWishlistWidget(BuildContext context, List<WishlistData> myWishlists) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      children: [
        _buildHeader(context, myWishlists),
        _buildMyWishlistList(context, myWishlists),
      ],
    ),
  );
}

// Header Section
Widget _buildHeader(BuildContext context, List<WishlistData> myWishlists) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
          child: Text(
            'My Wishlist',
            style: FlutterFlowTheme.of(context).titleMedium.override(
              fontFamily: 'Readex Pro',
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ),
        if (myWishlists.length >= 4)
          Icon(
            Icons.arrow_forward,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24,
          ),
      ],
    ),
  );
}

// Wishlist List Section
Widget _buildMyWishlistList(BuildContext context, List<WishlistData> myWishlists) {
  if (myWishlists.isEmpty) {
    return _myWishlistAddWishWidget2(context);
  } else {
    return Container(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: (myWishlists.length == 2) ? 3 : (myWishlists.length > 3) ? 4 : myWishlists.length,
        itemBuilder: (context, index) {
          if (myWishlists.length == 1) {
            return Row(
              children: [
                _myWishListWidget(context, myWishlists[index]),
                _myWishlistAddWishWidget(context, 220),
              ],
            );
          } else if (myWishlists.length == 2) {
            if (index < 2) {
              return _myWishListWidget(context, myWishlists[index]);
            } else {
              return _myWishlistAddWishWidget(context, 110);
            }
          } else if (index < 3) {
            return _myWishListWidget(context, myWishlists[index]);
          } else if (index == 3 && myWishlists.length > 2) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: _seeAllButton(context),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

// Wishlist Item Widget
Widget _myWishListWidget(BuildContext context, WishlistData wishlist) {
  return Align(
    alignment: AlignmentDirectional(0, 0),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildWishlistImage(context, wishlist),
              _buildWishlistFooter(context, wishlist),
            ],
          ),
        ),
      ),
    ),
  );
}

// Wishlist Image
Widget _buildWishlistImage(BuildContext context, WishlistData wishlist) {
  return Flexible(
    fit: FlexFit.loose,
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: wishlist.wishlistImage == ""
                  ? Image.asset(APP_ICON, height: 50, width: 52, fit: BoxFit.cover, color: Colors.white).image
                  : Image.network(wishlist.wishlistImage ?? '').image,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            shape: BoxShape.rectangle,
          ),
          alignment: AlignmentDirectional(0, 0),
        ),
      ),
    ),
  );
}

// Wishlist Footer
Widget _buildWishlistFooter(BuildContext context, WishlistData wishlist) {
  return Container(
    height: 40,
    width: 110,
    decoration: BoxDecoration(
      color: Color(0xFFE4DFDF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: Text(
            wishlist.wishlistName ?? '',
            style: FlutterFlowTheme.of(context).bodySmall.override(
              fontFamily: 'Readex Pro',
              fontSize: 12,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          wishlist.dateCreated ?? '',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Readex Pro',
            color: Color(0xBE57636C),
            fontSize: 10,
            letterSpacing: 0,
          ),
        ),
      ],
    ),
  );
}

// Add Wish Widget
Widget _myWishlistAddWishWidget(BuildContext context, double width) {
  return Align(
    alignment: AlignmentDirectional(0, 0),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 4, 0, 0),
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: FlutterFlowTheme.of(context).alternate),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAddWishImage(),
                _buildAddWishButton(context),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// Add Wish Image
Widget _buildAddWishImage() {
  return Flexible(
    fit: FlexFit.loose,
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network('').image,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          shape: BoxShape.rectangle,
        ),
        alignment: AlignmentDirectional(0, 0),
        child: Image.asset(
          'assets/icons/Add Wish.png',
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

// Add Wish Button
Widget _buildAddWishButton(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 10),
    child: InkWell(
      onTap: () {
        WhvWishlistScreen().launch(context);
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            'Add Wish',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
              fontSize: 12,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    ),
  );
}

// Add Wish Alternate Widget
Widget _myWishlistAddWishWidget2(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
    child: Container(
      width: 360,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network('').image,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Image.asset(
                  'assets/icons/Add Wish.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 60),
            child: InkWell(
              onTap: () {
                WhvWishlistScreen().launch(context);
              },
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'Add Wish',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 0,
                    ),
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

// See All Button
Widget _seeAllButton(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          WhvWishlistScreen().launch(context);
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.withOpacity(0.6)),
          ),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.grey.withOpacity(0.6),
            size: 22,
          ),
        ),
      ),
      Text(
        'See All',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'Readex Pro',
          fontSize: 12,
          color: Colors.grey.withOpacity(0.6),
          letterSpacing: 0,
        ),
      ),
    ],
  );
}
