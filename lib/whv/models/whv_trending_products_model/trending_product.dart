import 'dart:convert';

class TrendingProduct {
  String? id;
  String? userId;
  String? dateCreated;
  String? dateCreatedGmt;
  String? productTitle;
  String? sku;
  String? price;
  String? regularPrice;
  String? productUrl;
  String? productDomain;
  String? affiliateTag;
  String? productImageUrl;
  String? averageRating;
  String? reviewCount;

  TrendingProduct({
    this.id,
    this.userId,
    this.dateCreated,
    this.dateCreatedGmt,
    this.productTitle,
    this.sku,
    this.price,
    this.regularPrice,
    this.productUrl,
    this.productDomain,
    this.affiliateTag,
    this.productImageUrl,
    this.averageRating,
    this.reviewCount,
  });

  factory TrendingProduct.fromMap(Map<String, dynamic> data) {
    return TrendingProduct(
      id: data['ID'] as String?,
      userId: data['user_id'] as String?,
      dateCreated: data['date_created'] as String?,
      dateCreatedGmt: data['date_created_gmt'] as String?,
      productTitle: data['product_title'] as String?,
      sku: data['sku'] as String?,
      price: data['price'] as String?,
      regularPrice: data['regular_price'] as String?,
      productUrl: data['product_url'] as String?,
      productDomain: data['product_domain'] as String?,
      affiliateTag: data['affiliate_tag'] as String?,
      productImageUrl: data['product_image_url'] as String?,
      averageRating: data['average_rating'] as String?,
      reviewCount: data['review_count'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'ID': id,
        'user_id': userId,
        'date_created': dateCreated,
        'date_created_gmt': dateCreatedGmt,
        'product_title': productTitle,
        'sku': sku,
        'price': price,
        'regular_price': regularPrice,
        'product_url': productUrl,
        'product_domain': productDomain,
        'affiliate_tag': affiliateTag,
        'product_image_url': productImageUrl,
        'review_count': reviewCount,
        'average_rating': averageRating,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TrendingProduct].
  factory TrendingProduct.fromJson(String data) {
    return TrendingProduct.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TrendingProduct] to a JSON string.
  String toJson() => json.encode(toMap());

  TrendingProduct copyWith({
    String? id,
    String? userId,
    String? dateCreated,
    String? dateCreatedGmt,
    String? productTitle,
    String? sku,
    String? price,
    String? regularPrice,
    String? productUrl,
    String? productDomain,
    String? affiliateTag,
    String? productImageUrl,
    String? averageRating,
    String? reviewCount,
  }) {
    return TrendingProduct(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
      productTitle: productTitle ?? this.productTitle,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      productUrl: productUrl ?? this.productUrl,
      productDomain: productDomain ?? this.productDomain,
      affiliateTag: affiliateTag ?? this.affiliateTag,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}
