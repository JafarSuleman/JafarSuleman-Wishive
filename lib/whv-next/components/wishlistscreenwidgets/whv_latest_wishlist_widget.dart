// import 'package:nb_utils/nb_utils.dart';
//
// import '../../../components/CustomMultiImageLayout/multi_image_layout.dart';
// import '../../../configs.dart';
// import '../../../whv/screens/delta/flutter_flow_theme.dart';
// import '../models/wishlists/wishlist_data.dart';
// import 'latest_wishlist_screen.dart';
//
// Widget customLatestListTile(BuildContext context, List<WishlistData> latestWishlists) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       Padding(
//         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
//               child: Text(
//                 'Latest',
//                 style: FlutterFlowTheme.of(context).titleMedium.override(
//                   fontFamily: 'Readex Pro',
//                   color: Colors.black.withOpacity(0.7),
//                   fontSize: 16,
//                   letterSpacing: 0,
//                 ),
//               ),
//             ),
//             latestWishlists.length>=3?Icon(
//               Icons.arrow_forward,
//               color: Colors.grey.withOpacity(0.6),
//               size: 24,
//             ):Container(),
//           ],
//         ),
//       ),
//       latestWishlists.isEmpty?latestAddFriendWidget2(context):Container(
//         height: 160,
//         child: ListView.builder(
//           padding: EdgeInsets.zero,
//           scrollDirection: Axis.horizontal,
//           itemCount: (latestWishlists.length > 2) ? 4 : latestWishlists.length,
//           itemBuilder: (context, index) {
//             if (latestWishlists.length == 1) {
//               return Row(
//                 children: [
//                   latestWidget(context, latestWishlists[index]),
//                   latestAddFriendWidget(context),
//                 ],
//               );
//             } else if (index < 3) {
//               return latestWidget(context, latestWishlists[index]);
//             } else if (index == 3 && latestWishlists.length > 2) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: seeAllButton(context),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     ],
//   );
// }
// Align latestWidget(BuildContext context, WishlistData wishlist) {
//   return Align(
//     alignment: AlignmentDirectional(0, 0),
//     child: Padding(
//       padding: EdgeInsetsDirectional.fromSTEB(10, 4, 0, 4),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           width: 140,
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
//               Container(
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFE4DFDF).withOpacity(0.5),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(0),
//                     bottomRight: Radius.circular(0),
//                     topLeft: Radius.circular(0),
//                     topRight: Radius.circular(15),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 2,right: 2),
//                       child: Container(
//                         width: 32,
//                         height: 32,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.network(
//                           'https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxmZW1hbGUlMjBwcm9maWxlfGVufDB8fHx8MTcyMTUyMjc2MHww&ixlib=rb-4.0.3&q=80&w=400',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 5,),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           wishlist.displayName ?? '',
//                           style: FlutterFlowTheme.of(context).bodySmall.override(
//                             fontFamily: 'Readex Pro',
//                             fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             letterSpacing: 0,
//                             color: Colors.black.withOpacity(0.7),
//                           ),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width:40,
//                               child: Text(
//                                 wishlist.wishlistName ?? '',
//                                 style: FlutterFlowTheme.of(context).bodySmall.override(
//                                   fontFamily: 'Readex Pro',
//                                   fontSize: 7,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 0,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 4.0),
//                               child: SizedBox(
//                                 height: 10,
//                                 width: 1,
//                                 child: VerticalDivider(
//                                   thickness: 1.5,
//                                   color: Color(0xCCAC9D9D),
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               wishlist.dateCreated ?? '',
//                               style: FlutterFlowTheme.of(context).bodySmall.override(
//                                 fontFamily: 'Readex Pro',
//                                 color: Color(0xBE57636C),
//                                 fontSize: 7,
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: 0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
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
//                     padding: const EdgeInsets.all(15),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.contain,
//                           image: wishlist.wishlistImage==null?Image.asset(APP_ICON, height: 50, width: 52, fit: BoxFit.cover, color: Colors.black).image
//                               :Image.network(
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
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
// Align latestAddFriendWidget(BuildContext context) {
//   return Align(
//     alignment: AlignmentDirectional(0, 0),
//     child: Padding(
//       padding: EdgeInsetsDirectional.fromSTEB(10, 4, 0, 0),
//       child: Material(
//         color: Colors.transparent,
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Container(
//             width: 140,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(
//                 color: FlutterFlowTheme.of(context).alternate,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(0),
//                       bottomRight: Radius.circular(0),
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8),
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: Image.network(
//                             '',
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
//                       child: Image.asset(
//                         'assets/icons/Add Wish.png',
//                         fit: BoxFit.fill,
//                       ),
//                       // child: Image.network(
//                       //   'https://m.media-amazon.com/images/I/61GD5fmd0XL._AC_SX679_.jpg',
//                       //   width: 300,
//                       //   height: 200,
//                       //   fit: BoxFit.contain,
//                       // ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 5),
//                   child: InkWell(
//                     onTap: (){
//                       LatestWishlistScreen().launch(context);
//                     },
//                     child: Container(
//                       width: 90,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: Color(0xFF5160C0).withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Align(
//                         alignment: AlignmentDirectional(0, 0),
//                         child: Text(
//                           'Add Friends',
//                           style: FlutterFlowTheme.of(context)
//                               .bodyMedium
//                               .override(
//                             fontFamily: 'Readex Pro',
//                             color: Color(0xFFF2FAFF),
//                             fontSize: 12,
//                             letterSpacing: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
// Widget latestAddFriendWidget2(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(5),
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
//                 // child: Image.network(
//                 //   'https://m.media-amazon.com/images/I/61GD5fmd0XL._AC_SX679_.jpg',
//                 //   width: 300,
//                 //   height: 200,
//                 //   fit: BoxFit.contain,
//                 // ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 40,top: 50),
//             child: InkWell(
//               onTap: (){
//                 LatestWishlistScreen().launch(context);
//               },
//               child: Container(
//                 width: 90,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: Color(0xFF5160C0).withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Align(
//                   alignment: AlignmentDirectional(0, 0),
//                   child: Text(
//                     'Add Friends',
//                     style: FlutterFlowTheme.of(context)
//                         .bodyMedium
//                         .override(
//                       fontFamily: 'Readex Pro',
//                       color: Color(0xFFF2FAFF),
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
// Column seeAllButton(BuildContext context) {
//   return Column(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       InkWell(
//         onTap: (){
//           LatestWishlistScreen().launch(context);
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
//         style: FlutterFlowTheme
//             .of(context)
//             .bodyMedium
//             .override(
//           fontFamily: 'Readex Pro',
//           fontSize: 12,
//           color: Colors.grey.withOpacity(0.6),
//           letterSpacing: 0,
//         ),
//       ),
//     ],
//   );
// }
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/CustomMultiImageLayout/multi_image_layout.dart';
import '../../../configs.dart';
import '../../../whv/screens/delta/flutter_flow_theme.dart';
import '../models/wishlists/wishlist_data.dart';
import 'latest_wishlist_screen.dart';

// Main Widget
Widget customLatestListTile(BuildContext context, List<WishlistData> latestWishlists) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      _buildHeader(context, latestWishlists),
      _buildLatestList(context, latestWishlists),
    ],
  );
}

// Header Section
Widget _buildHeader(BuildContext context, List<WishlistData> latestWishlists) {
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
            'Latest',
            style: FlutterFlowTheme.of(context).titleMedium.override(
              fontFamily: 'Readex Pro',
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ),
        if (latestWishlists.length >= 3)
          Icon(
            Icons.arrow_forward,
            color: Colors.grey.withOpacity(0.6),
            size: 24,
          ),
      ],
    ),
  );
}

// Latest List Section
Widget _buildLatestList(BuildContext context, List<WishlistData> latestWishlists) {
  if (latestWishlists.isEmpty) {
    return _latestAddFriendWidget2(context);
  } else {
    return Container(
      height: 160,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: (latestWishlists.length > 2) ? 4 : latestWishlists.length,
        itemBuilder: (context, index) {
          if (latestWishlists.length == 1) {
            return Row(
              children: [
                _latestWidget(context, latestWishlists[index]),
                _latestAddFriendWidget(context),
              ],
            );
          } else if (index < 3) {
            return _latestWidget(context, latestWishlists[index]);
          } else if (index == 3 && latestWishlists.length > 2) {
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

// Latest Widget
Widget _latestWidget(BuildContext context, WishlistData wishlist) {
  return Align(
    alignment: AlignmentDirectional(0, 0),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 4, 0, 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildWishlistHeader(context, wishlist),
              _buildWishlistImage(wishlist),
            ],
          ),
        ),
      ),
    ),
  );
}

// Wishlist Header
Widget _buildWishlistHeader(BuildContext context, WishlistData wishlist) {
  return Container(
    height: 45,
    decoration: BoxDecoration(
      color: Color(0xFFE4DFDF).withOpacity(0.5),
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxmZW1hbGUlMjBwcm9maWxlfGVufDB8fHx8MTcyMTUyMjc2MHww&ixlib=rb-4.0.3&q=80&w=400',
            ),
          ),
        ),
        SizedBox(width: 5),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wishlist.displayName ?? '',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Readex Pro',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  child: Text(
                    wishlist.wishlistName ?? '',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SizedBox(
                    height: 10,
                    width: 1,
                    child: VerticalDivider(
                      thickness: 1.5,
                      color: Color(0xCCAC9D9D),
                    ),
                  ),
                ),
                Text(
                  wishlist.dateCreated ?? '',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Readex Pro',
                    color: Color(0xBE57636C),
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

// Wishlist Image
Widget _buildWishlistImage(WishlistData wishlist) {
  return Flexible(
    fit: FlexFit.loose,
    child: ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: wishlist.wishlistImage == null
                  ? Image.asset(APP_ICON, height: 50, width: 52, fit: BoxFit.cover, color: Colors.black).image
                  : NetworkImage(wishlist.wishlistImage!),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          alignment: AlignmentDirectional(0, 0),
        ),
      ),
    ),
  );
}

// Add Friend Widget
Widget _latestAddFriendWidget(BuildContext context) {
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
            width: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(''),
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 5),
                  child: InkWell(
                    onTap: () {
                      LatestWishlistScreen().launch(context);
                    },
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF5160C0).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Add Friends',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFF2FAFF),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// Add Friend Alternate Widget
Widget _latestAddFriendWidget2(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      width: 360,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(''),
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
            padding: const EdgeInsets.only(right: 40, top: 50),
            child: InkWell(
              onTap: () {
                LatestWishlistScreen().launch(context);
              },
              child: Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF5160C0).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'Add Friends',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFF2FAFF),
                      fontSize: 12,
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
          LatestWishlistScreen().launch(context);
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.withOpacity(0.6),
            ),
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
        ),
      ),
    ],
  );
}
