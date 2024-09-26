import 'wishlist_data.dart';
import 'wishlist_meta.dart';

class LatestWishlists {
  final List<WishlistData>? data;
  final WishlistMeta? meta;

  LatestWishlists({
    required this.data,
    required this.meta,
  });

  factory LatestWishlists.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LatestWishlists(data: [], meta: WishlistMeta(numberOfItems: 0));
    }
    print('LatestWishlists data: $json');
    return LatestWishlists(
      data: List<WishlistData>.from(json['latest-wishlists-data'].map((x) => WishlistData.fromJson(x))),
      meta: WishlistMeta.fromJson(json['my-wishlists-meta']),
    );
  }
}
