// To parse this JSON data, do
//
//     final whvWishlistModel = whvWishlistModelFromJson(jsonString);

import 'dart:convert';

WhvWishlistModel whvWishlistModelFromJson(String str) =>
    WhvWishlistModel.fromJson(json.decode(str));

String whvWishlistModelToJson(WhvWishlistModel data) =>
    json.encode(data.toJson());

class WhvWishlistModel {
  String? userId;
  String? name;
  String? avatarThumb;
  String? avatarFull;
  String? wishlistId;
  String? wishlistTitle;
  String? privacy;
  String? type;
  String? shareKey;
  String? wishlistImage;
  String? wishId;
  String? productId;
  int? totalNumberOfWishes;
  int? totalNumberOfWishesGranted;
  int? totalNumberOfWishesRemaining;
  double? percentageOfWishesGranted;
  DateTime? dateCreated;
  DateTime? dueDate;

  WhvWishlistModel({
    this.userId,
    this.name,
    this.avatarThumb,
    this.avatarFull,
    this.wishlistId,
    this.wishlistTitle,
    this.privacy,
    this.type,
    this.shareKey,
    this.wishlistImage,
    this.wishId,
    this.productId,
    this.totalNumberOfWishes,
    this.totalNumberOfWishesGranted,
    this.totalNumberOfWishesRemaining,
    this.percentageOfWishesGranted,
    this.dateCreated,
    this.dueDate,
  });

  factory WhvWishlistModel.fromJson(Map<String, dynamic> json) =>
      WhvWishlistModel(
        userId: json["user_id"],
        name: json["name"],
        avatarThumb: json["avatar_thumb"],
        avatarFull: json["avatar_full"],
        wishlistId: json["wishlist_id"],
        wishlistTitle: json["wishlist_name"],
        privacy: json["privacy"],
        type: json["type"],
        shareKey: json["share_key"],
        wishlistImage: json["wishlist_image"],
        wishId: json["wish_id"],
        productId: json["product_id"],
        totalNumberOfWishes: int.parse(json["total_number_of_wishes"] ?? '0'),
        totalNumberOfWishesGranted:
            int.parse(json["total_number_of_wishes_granted"] ?? '0'),
        totalNumberOfWishesRemaining:
            int.parse(json["total_number_of_wishes_remaining"] ?? '0'),
        percentageOfWishesGranted:
            double.tryParse(json["percentage_of_wishes_granted"] ?? '0'),
        dateCreated: DateTime.parse(json["date_created"]),
        dueDate: DateTime.parse(json["due_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "avatar_thumb": avatarThumb,
        "avatar_full": avatarFull,
        "wishlist_id": wishlistId,
        "wishlist_name": wishlistTitle,
        "privacy": privacy,
        "type": type,
        "share_key": shareKey,
        "wishlist_image": wishlistImage,
        "wish_id": wishId,
        "product_id": productId,
        "total_number_of_wishes": totalNumberOfWishes,
        "total_number_of_wishes_granted": totalNumberOfWishesGranted,
        "total_number_of_wishes_remaining": totalNumberOfWishesRemaining,
        "percentage_of_wishes_granted": percentageOfWishesGranted,
        "date_created": dateCreated?.toIso8601String(),
        "due_date": dueDate?.toIso8601String(),
      };
}
