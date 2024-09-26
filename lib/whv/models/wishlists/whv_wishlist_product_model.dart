// To parse this JSON data, do
//
//     final whvWishlistProductModel = whvWishlistProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/constants/whv_new_wishlist_constants.dart';

WhvWishlistProductModel whvWishlistProductModelFromJson(String str) =>
    WhvWishlistProductModel.fromJson(json.decode(str));

String whvWishlistProductModelToJson(WhvWishlistProductModel data) =>
    json.encode(data.toJson());

class WhvWishlistProductModel {
  String userId;
  String prodpgUrl;
  String prodpgHtml;
  String wishlistId;
  String wishlistName;
  String wishlistPrivacy;
  String wishlistDueDate;
  String imgvarUrl;
  String quantity;
  String wishComment;
  String wishlistComment;

  WhvWishlistProductModel({
    required this.userId,
    required this.prodpgUrl,
    required this.prodpgHtml,
    required this.wishlistId,
    required this.wishlistName,
    required this.wishlistPrivacy,
    required this.wishlistDueDate,
    required this.imgvarUrl,
    required this.quantity,
    required this.wishComment,
    required this.wishlistComment,
  });

  WhvWishlistProductModel copyWith({
    String? userId,
    String? prodpgUrl,
    String? prodpgHtml,
    String? wishlistId,
    String? wishlistName,
    String? wishlistPrivacy,
    String? wishlistDueDate,
    String? imgvarUrl,
    String? quantity,
    String? wishComment,
    String? wishlistComment,
  }) =>
      WhvWishlistProductModel(
        userId: userId ?? this.userId,
        prodpgUrl: prodpgUrl ?? this.prodpgUrl,
        prodpgHtml: prodpgHtml ?? this.prodpgHtml,
        wishlistId: wishlistId ?? this.wishlistId,
        wishlistName: wishlistName ?? this.wishlistName,
        wishlistPrivacy: wishlistPrivacy ?? this.wishlistPrivacy,
        wishlistDueDate: wishlistDueDate ?? this.wishlistDueDate,
        imgvarUrl: imgvarUrl ?? this.imgvarUrl,
        quantity: quantity ?? this.quantity,
        wishComment: wishComment ?? this.wishComment,
        wishlistComment: wishlistComment ?? this.wishlistComment,
      );

  factory WhvWishlistProductModel.fromJson(Map<String, dynamic> json) =>
      WhvWishlistProductModel(
        userId: json["userId"],
        prodpgUrl: json["prodpgURL"],
        prodpgHtml: json["prodpgHTML"],
        wishlistId: json["wishlistId"],
        wishlistName: json["wishlistName"],
        wishlistPrivacy: json["wishlistPrivacy"],
        wishlistDueDate: json["dueDate"],
        imgvarUrl: json["imgVarURL"],
        quantity: json["quantity"],
        wishComment: json["wishComment"],
        wishlistComment: json["wishlistComment"],
      );

  Map<String, dynamic> toJson() {
    if (!addToWishlistStore.isCreatingNewWishlist) {
      this.wishlistName = WhvConstants.WhvNONE;
      this.wishlistPrivacy = WhvConstants.WhvNONE;
      this.wishlistDueDate = WhvConstants.WhvNONE;
    }

    // if (wishlistPrivacy.isEmptyOrNull) {
    //   if (wishlistPrivacy.isEmptyOrNull ||
    //       wishlistPrivacy?.toLowerCase() ==
    //           WhvNewWishlistConstants.whvFriends.toLowerCase()) {
    //     this.wishlistPrivacy = WhvNewWishlistConstants.whvShare.toLowerCase();
    //   } else {
    //     this.wishlistPrivacy = WhvNewWishlistConstants.whvPrivate.toLowerCase();
    //   }
    // }
    return {
      "userId": userId,
      "prodpgURL": prodpgUrl,
      "prodpgHTML": prodpgHtml,
      "wishlistId": wishlistId,
      "wishlistName": wishlistName,
      "wishlistPrivacy": wishlistPrivacy,
      "dueDate": wishlistDueDate,
      "imgVarURL": imgvarUrl,
      "quantity": quantity,
      "wishComment": wishComment,
      "wishlistComment": wishlistComment,
    };
  }
}
