// To parse this JSON data, do
//
//     final whvProductImportResponse = whvProductImportResponseFromJson(jsonString);

import 'dart:convert';

WhvProductImportResponse whvProductImportResponseFromJson(String str) =>
    WhvProductImportResponse.fromJson(json.decode(str));

class WhvProductImportResponse {
  String wishlistId;
  String wishId;
  String title;
  String status;
  String message;

  WhvProductImportResponse({
    required this.wishlistId,
    required this.wishId,
    required this.title,
    required this.status,
    required this.message,
  });

  factory WhvProductImportResponse.fromJson(Map<String, dynamic> json) =>
      WhvProductImportResponse(
        wishlistId:
            json["wishlistId"] != null ? json["wishlistId"].toString() : "",
        wishId: json["wishId"] != null ? json["wishId"].toString() : "",
        title: json["productTitle"] != null ? json["productTitle"].toString() : "",
        status: json["status"] != null ? json["status"].toString() : "Error",
        message: json["message"] != null ? json["message"].toString() : "",
      );
}
