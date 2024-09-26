// To parse this JSON data, do
//
//     final whvUpcomingWishlistModel = whvUpcomingWishlistModelFromJson(jsonString);

import 'dart:convert';

WhvUpcomingWishlistModel whvUpcomingWishlistModelFromJson(String str) =>
    WhvUpcomingWishlistModel.fromJson(json.decode(str));

String whvUpcomingWishlistModelToJson(WhvUpcomingWishlistModel data) =>
    json.encode(data.toJson());

class WhvUpcomingWishlistModel {
  String? userId;
  String? name;
  String? avatarThumb;
  String? avatarFull;
  String? wishlistId;
  String? wishlistTitle;
  String? privacy;
  String? type;
  String? shareKey;
  String? wishId;
  String? productId;
  int? totalNumberOfWishes;
  int? totalNumberOfWishesGranted;
  int? totalNumberOfWishesRemaining;
  double? percentageOfWishesGranted;
  String? wishlistImage;
  DateTime? dateCreated;
  DateTime? dueDate;

  WhvUpcomingWishlistModel({
    this.userId,
    this.name,
    this.avatarThumb,
    this.avatarFull,
    this.wishlistId,
    this.wishlistTitle,
    this.privacy,
    this.type,
    this.shareKey,
    this.wishId,
    this.productId,
    this.totalNumberOfWishes,
    this.totalNumberOfWishesGranted,
    this.totalNumberOfWishesRemaining,
    this.percentageOfWishesGranted,
    this.wishlistImage,
    this.dateCreated,
    this.dueDate,
  });

  factory WhvUpcomingWishlistModel.fromJson(Map<String, dynamic> json) =>
      WhvUpcomingWishlistModel(
        userId: json["user_id"],
        name: json["name"],
        avatarThumb: json["avatar_thumb"],
        avatarFull: json["avatar_full"],
        wishlistId: json["wishlist_id"],
        wishlistTitle: json["wishlist_title"],
        privacy: json["privacy"],
        type: json["type"],
        shareKey: json["share_key"],
        wishId: json["wish_id"],
        productId: json["product_id"],
        totalNumberOfWishes: int.parse(json["total_number_of_wishes"]),
        totalNumberOfWishesGranted:
            int.parse(json["total_number_of_wishes_granted"]),
        totalNumberOfWishesRemaining:
            int.parse(json["total_number_of_wishes_remaining"]),
        percentageOfWishesGranted:
            double.tryParse(json["percentage_of_wishes_granted"]),
        wishlistImage: json["wishlist_image"],
        dateCreated: DateTime.parse(json["date_created"]),
        dueDate: DateTime.parse(json["due_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "avatar_thumb": avatarThumb,
        "avatar_full": avatarFull,
        "wishlist_id": wishlistId,
        "wishlist_title": wishlistTitle,
        "privacy": privacy,
        "type": type,
        "share_key": shareKey,
        "wish_id": wishId,
        "product_id": productId,
        "total_number_of_wishes": totalNumberOfWishes,
        "total_number_of_wishes_granted": totalNumberOfWishesGranted,
        "total_number_of_wishes_remaining": totalNumberOfWishesRemaining,
        "percentage_of_wishes_granted": percentageOfWishesGranted,
        "wishlist_image": wishlistImage,
        "date_created": dateCreated?.toIso8601String(),
        "due_date": dueDate?.toIso8601String(),
      };
}
