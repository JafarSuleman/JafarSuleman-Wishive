// To parse this JSON data, do
//
//     final whvDashboardDataModel = whvDashboardDataModelFromJson(jsonString);

import 'dart:convert';

WhvDashboardDataModel whvDashboardDataModelFromJson(String str) =>
    WhvDashboardDataModel.fromJson(json.decode(str));

class WhvDashboardDataModel {
  List<WhvUpcomingWishlist> upcomingWishlists;
  List<WhvWishlist> myWishlists;
  List<WhvLatestActivity> latestActivities;

  WhvDashboardDataModel({
    required this.upcomingWishlists,
    required this.myWishlists,
    required this.latestActivities,
  });

  factory WhvDashboardDataModel.fromJson(Map<String, dynamic> json) =>
      WhvDashboardDataModel(
        upcomingWishlists: List<WhvUpcomingWishlist>.from(
            json["upcoming-wishlists"]["upcoming-wishlists-data"]
                .map((x) => WhvUpcomingWishlist.fromJson(x))),
        myWishlists: List<WhvWishlist>.from(json["my-wishlists"]
                ["my-wishlists-data"]
            .map((x) => WhvWishlist.fromJson(x))),
        latestActivities: List<WhvLatestActivity>.from(json["latest-activities"]
                ["latest-activities-data"]
            .map((x) => WhvLatestActivity.fromJson(x))),
      );
}

class WhvLatestActivity {
  String name;
  String userId;
  String avatarThumb;
  String avatarFull;
  String component;
  String type;
  String action;
  String content;
  String primaryLink;
  String itemId;
  String secondaryItemId;
  DateTime dateCreated;

  WhvLatestActivity({
    required this.name,
    required this.userId,
    required this.avatarThumb,
    required this.avatarFull,
    required this.component,
    required this.type,
    required this.action,
    required this.content,
    required this.primaryLink,
    required this.itemId,
    required this.secondaryItemId,
    required this.dateCreated,
  });

  factory WhvLatestActivity.fromJson(Map<String, dynamic> json) =>
      WhvLatestActivity(
        name: json["name"],
        userId: json["user_id"],
        avatarThumb: json["avatar_thumb"],
        avatarFull: json["avatar_full"],
        component: json["component"],
        type: json["type"],
        action: json["action"],
        content: json["content"],
        primaryLink: json["primary_link"],
        itemId: json["item_id"],
        secondaryItemId: json["secondary_item_id"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_id": userId,
        "avatar_thumb": avatarThumb,
        "avatar_full": avatarFull,
        "component": component,
        "type": type,
        "action": action,
        "content": content,
        "primary_link": primaryLink,
        "item_id": itemId,
        "secondary_item_id": secondaryItemId,
        "date_created": dateCreated.toIso8601String(),
      };
}

class WhvUpcomingWishlist {
  String userId;
  String name;
  String avatarThumb;
  String avatarFull;
  String wishlistId;
  String wishlistTitle;
  String privacy;
  String type;
  String shareKey;
  DateTime dateCreated;
  DateTime dueDate;

  WhvUpcomingWishlist({
    required this.userId,
    required this.name,
    required this.avatarThumb,
    required this.avatarFull,
    required this.wishlistId,
    required this.wishlistTitle,
    required this.privacy,
    required this.type,
    required this.shareKey,
    required this.dateCreated,
    required this.dueDate,
  });

  factory WhvUpcomingWishlist.fromJson(Map<String, dynamic> json) =>
      WhvUpcomingWishlist(
        userId: json["user_id"],
        name: json["name"],
        avatarThumb: json["avatar_thumb"],
        avatarFull: json["avatar_full"],
        wishlistId: json["wishlist_id"],
        wishlistTitle: json["wishlist_title"],
        privacy: json["privacy"],
        type: json["type"],
        shareKey: json["share_key"],
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
        "date_created": dateCreated.toIso8601String(),
        "due_date": dueDate.toIso8601String(),
      };
}

class WhvWishlist {
  String userId;
  String name;
  String avatarThumb;
  String avatarFull;
  String wishlistId;
  String wishlistTitle;
  String privacy;
  String type;
  String shareKey;
  String wishlistImage;
  String wishId;
  String productId;
  DateTime dateCreated;
  DateTime dueDate;

  WhvWishlist({
    required this.userId,
    required this.name,
    required this.avatarThumb,
    required this.avatarFull,
    required this.wishlistId,
    required this.wishlistTitle,
    required this.privacy,
    required this.type,
    required this.shareKey,
    required this.wishlistImage,
    required this.wishId,
    required this.productId,
    required this.dateCreated,
    required this.dueDate,
  });

  factory WhvWishlist.fromJson(Map<String, dynamic> json) => WhvWishlist(
        userId: json["user_id"],
        name: json["name"],
        avatarThumb: json["avatar_thumb"],
        avatarFull: json["avatar_full"],
        wishlistId: json["wishlist_id"],
        wishlistTitle: json["wishlist_title"],
        privacy: json["privacy"],
        type: json["type"],
        shareKey: json["share_key"],
        wishlistImage: json["wishlist_image"],
        wishId: json["wish_id"],
        productId: json["product_id"],
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
        "wishlist_image": wishlistImage,
        "wish_id": wishId,
        "product_id": productId,
        "date_created": dateCreated.toIso8601String(),
        "due_date": dueDate.toIso8601String(),
      };
}
