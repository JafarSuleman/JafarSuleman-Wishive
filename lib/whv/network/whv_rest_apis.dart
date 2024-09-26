import 'dart:developer';

import 'package:socialv/main.dart';
import 'package:socialv/whv/constants/whv_api_endpoints.dart';
import 'package:socialv/network/network_utils.dart';
import 'package:socialv/whv/models/media/whv_avatar_model.dart';
import 'package:socialv/whv/models/whv_trending_products_model/whv_trending_products_model.dart';
import 'package:socialv/whv/models/whv_user_agents.dart';
import 'package:socialv/whv/models/wishlists/whv_product_import_response.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_data_model.dart';
import 'package:socialv/whv/models/wishlists/whv_wishlist_product_model.dart';
import 'package:socialv/whv/models/wishlists/whv_wishlist_model.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_model.dart';
import 'package:sprintf/sprintf.dart';

import '../models/whv_dashboard_data_model.dart';
import '../models/wishlists/whv_upcoming_wishlist_model.dart';

// Create a wishlist for a user
Future<WhvWishlistModel> whvCreateWishList(
    {required int userId,
    required String title,
    required String status}) async {
  Map request = {"user_id": userId, "title": title, "status": status};

  return WhvWishlistModel.fromJson(
    await handleResponse(await buildHttpResponse(
        '${WhvAPIEndPoint.whvCreateWishlist}',
        method: HttpMethod.POST,
        request: request)),
  );
}

// Get all the wishlists for a user
Future<List<WhvWishlistModel>> whvGetWishLists(
    {required String userId, int page = 1}) async {
  Map request = {};

  String whvGetWishlistEndPoint = "${WhvAPIEndPoint.whvGetWishlist}?id=$userId";

  var response = await handleResponse(await buildHttpResponse(
      '$whvGetWishlistEndPoint&page=$page&per_page=20',
      method: HttpMethod.GET,
      request: request));

  var loadedData =
      response['my-wishlists']['my-wishlists-data'] as List<dynamic>;

  List<WhvWishlistModel> listOfWishlists =
      loadedData.map((e) => WhvWishlistModel.fromJson(e)).toList();

  return listOfWishlists;
}

// Get all upcoming wishlists for a user
Future<List<WhvUpcomingWishlistModel>> whvGetUpcomingWishLists(
    {required String userId, int page = 1}) async {
  Map request = {};

  var data = await handleResponse(
    await buildHttpResponse(
      '${WhvAPIEndPoint.whvGetUpcomingWishlist}?id=$userId&page=$page&per_page=20',
      method: HttpMethod.GET,
      request: request,
    ),
  );

  var loadedData =
      data['upcoming-wishlists']['upcoming-wishlists-data'] as List<dynamic>;

  List<WhvUpcomingWishlistModel> listOfWishlists = [];

  loadedData.forEach((e) {
    listOfWishlists.add(WhvUpcomingWishlistModel.fromJson(e));
  });

  return listOfWishlists;
}

// Get all the wishes associated with an upcoming wishlist
Future<List<WhvWishModel>> whvGetUpcomingWishes(
    {required String wishlistId, int page = 1}) async {
  var data = await handleResponse(
    await buildHttpResponse(
      '${WhvAPIEndPoint.whvGetUpcomingWishes}?id=$wishlistId&page=$page&per_page=20',
      method: HttpMethod.GET,
    ),
  );

  var loadedData = data['data'] as List<dynamic>;

  List<WhvWishModel> listOfWishes = [];
  loadedData.forEach((e) {
    listOfWishes.add(WhvWishModel.fromJson(e));
  });

  return listOfWishes;
}

// Update a wishlist based on its share key
Future<WhvWishlistModel> whvUpdateWishList(
    {required int userId,
    required String title,
    required String shareKey}) async {
  Map request = {"user_id": userId, "title": title};

  String whvUpdateWishlistEndPoint =
      sprintf('${WhvAPIEndPoint.whvUpdateWishlist}', [shareKey]);

  return WhvWishlistModel.fromJson(
    await handleResponse(await buildHttpResponse('$whvUpdateWishlistEndPoint',
        method: HttpMethod.POST, request: request)),
  );
}

// Delete a wishlist based on its share key
Future<String> whvDeleteWishlist({required String shareKey}) async {
  Map request = {};

  String whvDeleteWishlistEndPoint =
      sprintf('${WhvAPIEndPoint.whvDeleteWishlist}', [shareKey]);

  return Future.value(await handleResponse(await buildHttpResponse(
      '$whvDeleteWishlistEndPoint',
      method: HttpMethod.GET,
      request: request)));
}

// Update Wish Views
Future<bool> whvUpdateWishViews({required String wishlistId}) async {
  var data = await handleResponse(
    await buildHttpResponse(
      '${WhvAPIEndPoint.whvUpdateWishViews}?id=$wishlistId',
      method: HttpMethod.PUT,
    ),
  );

  return data['result'] == 1;
}

// Add a wish to a specific wishlist given the latter's share key
Future<List<WhvWishModel>> whvAddWish(
    {required int productId,
    int variationId = 0,
    required String shareKey}) async {
  Map request = {
    "product_id": productId,
    "variation_id": variationId,
  };

  String whvCreateWishEndPoint =
      sprintf('${WhvAPIEndPoint.whvCreateWish}', [shareKey]);

  Iterable it = await handleResponse(await buildHttpResponse(
      '$whvCreateWishEndPoint',
      method: HttpMethod.POST,
      request: request));

  List<WhvWishModel> listOfWishes =
      it.map((e) => WhvWishModel.fromJson(e)).toList();

  return listOfWishes;
}

// Get all the wishes associated with a wishlist
Future<List<WhvWishModel>> whvGetWishes({
  required String shareKey,
  required String wishlistId,
  int page = 1,
}) async {
  String whvGetWishesEndPoint = '${WhvAPIEndPoint.whvGetWishes}?id=$wishlistId&user_id=${appStore.loginUserId}';

  var response = await handleResponse(await buildHttpResponse(
      '$whvGetWishesEndPoint&page=$page&per_page=10&order_by=date_created',
      method: HttpMethod.GET));

  var loadedData = response['my-wishes']['my-wishes-data'] as List;

  List<WhvWishModel> listOfWishes =
      loadedData.map((e) => WhvWishModel.fromJson(e)).toList();

  return listOfWishes;
}

// Delete a wish based on its wish id
Future<List<WhvWishModel>> whvDeleteWish({required String wishId}) async {
  Map request = {};

  String whvDeleteWishEndPoint =
      sprintf('${WhvAPIEndPoint.whvDeleteWish}', [wishId]);

  return Future.value(await handleResponse(await buildHttpResponse(
      '$whvDeleteWishEndPoint',
      method: HttpMethod.GET,
      request: request)));
}

// Get all the wishes associated with a wishlist from Orchestrator API
Future<List<WhvWishDataModel>> whvGetTheWishes(
    {required int wishListId, int page = 1}) async {
  String whvGetTheWishesEndPoint =
      sprintf('${WhvAPIEndPoint.whvGetTheWishes}', [wishListId]);

  Iterable it = await handleResponse(await buildHttpResponse(
      '$whvGetTheWishesEndPoint?page=$page&per_page=20',
      method: HttpMethod.GET));

  List<WhvWishDataModel> listOfTheWishes =
      it.map((e) => WhvWishDataModel.fromJson(e)).toList();

  return listOfTheWishes;
}

// Create a wishlist for a user from shop.
Future<WhvProductImportResponse> whvAddProductToWishlist(
    WhvWishlistProductModel addProductToWishlistModel) async {
  Map request = addProductToWishlistModel.toJson();
  var response = await handleResponse(await buildHttpResponse(
    '${WhvAPIEndPoint.whvAddToWishlistProduct}',
    method: HttpMethod.POST,
    request: request,
  ));

  return WhvProductImportResponse.fromJson(response);
}

// Create a wishlist for a user
Future<WhvProductImportResponse> whvCreateNewWishlist(
    {required Map requestBody}) async {
  var response = await handleResponse(await buildHttpResponse(
    '${WhvAPIEndPoint.whvCreateNewWishlist}',
    method: HttpMethod.POST,
    request: requestBody,
  ));

  return WhvProductImportResponse.fromJson(response);
}

// Get Dashboard Data
Future<WhvDashboardDataModel?> whvGetDashboardData(
    {required int userId}) async {
  var data = await handleResponse(
      await buildHttpResponse('${WhvAPIEndPoint.getDashboardData}?id=$userId'));

  if (data['status'] != null) {
    return null;
  } else {
    return WhvDashboardDataModel.fromJson(data);
  }
}

// Add the user avatar to the database (table: users)
Future<WhvAvatarModel> whvAddUserAvatar({required String userId}) async {
  String whvAvatarEndpoint =
      sprintf('${WhvAPIEndPoint.whvAddAvatarToDB}', [userId]);

  var response = await handleResponse(
      await buildHttpResponse('$whvAvatarEndpoint', method: HttpMethod.PUT));

  return WhvAvatarModel.fromJson(response);
}

// Remove the user avatar to the database (table: users)
Future<WhvAvatarModel> whvDelUserAvatar({required String userId}) async {
  String whvAvatarEndpoint =
      sprintf('${WhvAPIEndPoint.whvDelAvatarFromDB}', [userId]);

  var response = await handleResponse(
      await buildHttpResponse('$whvAvatarEndpoint', method: HttpMethod.PUT));

  return WhvAvatarModel.fromJson(response);
}

// Get Product Keywords
Future<Map<String, dynamic>> whvGetProductKeywords() async {
  var response = await handleResponse(
      await buildHttpResponse(WhvAPIEndPoint.whvGetProductKeywords));

  return response;
}

// Get User Agents
Future<WhvUserAgents> whvGetUserAgents() async {
  var response = await handleResponse(
      await buildHttpResponse(WhvAPIEndPoint.whvGetUserAgents));
  return WhvUserAgents.fromJson(response['user-agents']);
}

// get trending product.

Future<WhvTrendingProductsModel> whvGetTheTrendingProducts(
    {required String sortBy,
    required String orderBy,
    int page = 1,
    int perPage = 10}) async {
  var response = await handleResponse(await buildHttpResponse(
    '${WhvAPIEndPoint.whvGetTrendingProducts}?sortby=$sortBy&orderby=$orderBy&page=$page&per_page=$perPage',
    method: HttpMethod.GET,
  ));

  var data = WhvTrendingProductsModel.fromMap(response);

  return data;
}
