import 'wishlist_data.dart';
import 'wishlist_meta.dart';

class UpcomingWishlists {
  final List<WishlistData>? data;
  final WishlistMeta? meta;

  UpcomingWishlists({
    required this.data,
    required this.meta,
  });

  factory UpcomingWishlists.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UpcomingWishlists(data: [], meta: WishlistMeta(numberOfItems: 0));
    }
    print('UpcomingWishlists data: $json');
    return UpcomingWishlists(
      data: List<WishlistData>.from(json['upcoming-wishlists-data'].map((x) => WishlistData.fromJson(x))),
      meta: WishlistMeta.fromJson(json['upcoming-wishlists-meta']),
    );
  }
}
