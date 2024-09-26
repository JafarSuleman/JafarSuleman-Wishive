import 'wishlist_data.dart';
import 'wishlist_meta.dart';

class MyWishlists {
  final List<WishlistData>? data;
  final WishlistMeta? meta;

  MyWishlists({
    required this.data,
    required this.meta,
  });

  factory MyWishlists.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MyWishlists(data: [], meta: WishlistMeta(numberOfItems: 0));
    }
    print('MyWishlists data: $json');

    return MyWishlists(
      data: List<WishlistData>.from(json['my-wishlists-data'].map((x) => WishlistData.fromJson(x))),
      meta: WishlistMeta.fromJson(json['my-wishlists-meta']),
    );
  }
}
