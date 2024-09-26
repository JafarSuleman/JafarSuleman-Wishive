// To parse this JSON data, do
//
//     final whvWishModel = whvWishModelFromJson(jsonString);

import 'dart:convert';

WhvWishModel whvWishModelFromJson(String str) =>
    WhvWishModel.fromJson(json.decode(str));

String whvWishModelToJson(WhvWishModel data) => json.encode(data.toJson());

class WhvWishModel {
  String id;
  String userId;
  String wishId;
  String wishlistId;
  String productId;
  String productTitle;
  String variationId;
  //String formdata;
  DateTime dateCreated;
  String quantityDesired;
  String quantityGranted;
  String quantityRemaining;
  dynamic availability;
  String price;
  String salePrice;
  String maxPrice;
  bool onsale;
  String stockStatus;
  bool inStock;
  String order;
  String wishImage;
  String wishComment;
  String numberOfViews;

  WhvWishModel({
    required this.id,
    required this.userId,
    required this.wishId,
    required this.wishlistId,
    required this.productId,
    required this.productTitle,
    required this.variationId,
    //required this.formdata,
    required this.dateCreated,
    required this.quantityDesired,
    required this.quantityGranted,
    required this.quantityRemaining,
    required this.availability,
    required this.price,
    required this.salePrice,
    required this.maxPrice,
    required this.onsale,
    required this.stockStatus,
    required this.inStock,
    required this.order,
    required this.wishImage,
    required this.wishComment,
    required this.numberOfViews,
  });

  factory WhvWishModel.fromJson(Map<String, dynamic> json) => WhvWishModel(
        id: json["id"] ?? "",
        userId: json["user_id"] ?? "",
        wishId: json["wish_id"] ?? "",
        wishlistId: json["wishlist_id"] ?? "",
        productId: json["product_id"] ?? "",
        productTitle: json["product_title"] ?? "",
        variationId: json["variation_id"] ?? "",
        //formdata: json["formdata"] ?? "",
        dateCreated: DateTime.tryParse(json["date_created"]) ?? DateTime.now(),
        quantityDesired: json["quantity_desired"] ?? "0",
        quantityGranted: json["quantity_granted"] ?? "0",
        quantityRemaining: json["quantity_remaining"] ?? "0",
        availability: json["availability"] ?? "0",
        price: json["price"] ?? "0",
        salePrice: json["sale_price"] ?? "0",
        maxPrice: json["max_price"] ?? "0",
        onsale: int.parse(json["onsale"]??'0') == 1,
        stockStatus: json["stock_status"] ?? "",
        inStock: int.parse(json["in_stock"]) == 1,
        order: json["order"] ?? "",
        wishImage: json["imgvar_url"] ?? "",
        wishComment: json["wish_comment"] ?? "",
        numberOfViews: json["number_of_views"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "wish_id": wishId,
        "wishlist_id": wishlistId,
        "product_id": productId,
        "product_title": productTitle,
        "variation_id": variationId,
        //"formdata": formdata,
        "date_created": dateCreated.toIso8601String(),
        "quantity_desired": quantityDesired,
        "quantity_granted": quantityGranted,
        "quantity_remaining": quantityRemaining,
        "availability": availability,
        "price": price,
        "sale_price": salePrice,
        "max_price": maxPrice,
        "onsale": onsale,
        "stock_status": stockStatus,
        "in_stock": inStock,
        "order": order,
        "wish_image": wishImage,
        "wish_comment": wishComment,
        "number_of_views": numberOfViews,
      };
}
