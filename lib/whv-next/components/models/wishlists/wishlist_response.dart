

import 'package:socialv/whv-next/components/models/wishlists/whv_latest_wishlists_model.dart';
import 'package:socialv/whv-next/components/models/wishlists/whv_my_wislists_model.dart';
import 'package:socialv/whv-next/components/models/wishlists/whv_upcoming_wishlists_model.dart';

class WishlistResponse {
  final UpcomingWishlists? upcomingWishlists;
  final LatestWishlists? latestWishlists;
  final MyWishlists? myWishlists;

  WishlistResponse({
    this.upcomingWishlists,
    this.latestWishlists,
    this.myWishlists,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    print('Parsed JSON: $json');
    return WishlistResponse(
      upcomingWishlists: UpcomingWishlists.fromJson(json['upcoming-wishlists']),
      latestWishlists: LatestWishlists.fromJson(json['latest-wishlists']),
      myWishlists: MyWishlists.fromJson(json['my-wishlists']),
    );
  }
}
