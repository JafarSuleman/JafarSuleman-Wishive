// import 'package:flutter/material.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';
// import '../../../whv/screens/delta/flutter_flow_theme.dart';
// import '../../components/models/wishlists/whv_wishlists_screen_model.dart';
// import '../../components/widgets/whv_latest_wishlist_widget.dart';
// import '../../components/widgets/whv_mywishlist_widget.dart';
// import '../../components/widgets/whv_upcoming_widget.dart';
//
// class WishlistsScreenWidget extends StatefulWidget {
//   const WishlistsScreenWidget({super.key});
//
//   @override
//   State<WishlistsScreenWidget> createState() => _WishlistsScreenWidgetState();
// }
//
// class _WishlistsScreenWidgetState extends State<WishlistsScreenWidget> {
//   List<String> yourList = [
//      'hi',
//     // 'hi',
//     //  'hi',
//     // 'hi',
//     //  'hi'
//   ] ;
//   late WishlistsScreenModel _model;
//
//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => WishlistsScreenModel());
//   }
//
//   @override
//   void dispose() {
//     _model.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Stack(
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: wishlistHeading(context,'Upcoming'),
//               ),
//               yourList.isEmpty? upcomingAddFriends2(context):customUpcomingListTile(context),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: wishlistHeading(context,'Latest'),
//               ),
//               yourList.isEmpty?latestAddFriendWidget2(context):customLatestListTile(context),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
//                         child: Text(
//                           'My Wishlists',
//                           style: FlutterFlowTheme.of(context).titleMedium.override(
//                             fontFamily: 'Readex Pro',
//                             color: Colors.black,
//                             letterSpacing: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                     yourList.length==4?Icon(
//                       Icons.arrow_forward,
//                       color: FlutterFlowTheme.of(context).secondaryText,
//                       size: 24,
//                     ):Container(),
//                   ],
//                 ),
//               ),
//               yourList.isEmpty?myWishlistAddWishWidget2(context):customMyWishlistWidget(context),
//             ]
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Row wishlistHeading(BuildContext context,String text) {
//     return Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                           child: Text(
//                             text,
//                             style: FlutterFlowTheme.of(context).titleMedium.override(
//                               fontFamily: 'Readex Pro',
//                               color: Colors.black,
//                               letterSpacing: 0,
//                             ),
//                           ),
//                         ),
//                         yourList.length==3?Icon(
//                           Icons.arrow_forward,
//                           color: FlutterFlowTheme.of(context).secondaryText,
//                           size: 24,
//                         ):Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//   }
//
//
// }
import 'package:flutter/material.dart';
import '../../components/apiservice/api_service.dart';
import '../../components/models/wishlists/wishlist_response.dart';
import '../../components/widgets/whv_latest_wishlist_widget.dart';
import '../../components/widgets/whv_mywishlist_widget.dart';
import '../../components/widgets/whv_upcoming_widget.dart';
//Updated Code
class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {


  Future<WishlistResponse>? futureWishlists;

  @override
  void initState() {
    super.initState();
    futureWishlists = fetchWishlists();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WishlistResponse>(
      future: futureWishlists,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          final upcomingWishlists = snapshot.data!.upcomingWishlists?.data ??
              [];
          final latestWishlists = snapshot.data!.latestWishlists?.data ?? [];
          final myWishlists = snapshot.data!.myWishlists?.data ?? [];
          print(upcomingWishlists.toString());

          return Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customUpcomingListTile(context, upcomingWishlists),
                  customLatestListTile(context, latestWishlists),
                  customMyWishlistWidget(context, myWishlists),
                  SizedBox(height: 30,)
                ]
            ),
          );


      },
    );
  }

}














