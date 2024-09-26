import 'dart:convert';

import 'trending_product.dart';

class WhvTrendingProductsModel {
  List<TrendingProduct>? trendingProducts;

  WhvTrendingProductsModel({this.trendingProducts});

  factory WhvTrendingProductsModel.fromMap(Map<String, dynamic> data) {
    return WhvTrendingProductsModel(
      trendingProducts: (data['trending-products'] as List<dynamic>?)
          ?.map((e) => TrendingProduct.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'trending-products': trendingProducts?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WhvTrendingProductsModel].
  factory WhvTrendingProductsModel.fromJson(String data) {
    return WhvTrendingProductsModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WhvTrendingProductsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WhvTrendingProductsModel copyWith({
    List<TrendingProduct>? trendingProducts,
  }) {
    return WhvTrendingProductsModel(
      trendingProducts: trendingProducts ?? this.trendingProducts,
    );
  }
}
