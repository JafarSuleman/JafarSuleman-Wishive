class WishlistMeta {
  final int numberOfItems;

  WishlistMeta({
    required this.numberOfItems,
  });

  factory WishlistMeta.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      print('WishlistMeta: No data found');
      return WishlistMeta(numberOfItems: 0);
    }
    print('WishlistMeta JSON: $json');
    return WishlistMeta(

      numberOfItems: json['number-of-items'],
    );
  }
}
