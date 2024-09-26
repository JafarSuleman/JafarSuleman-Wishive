import 'package:socialv/configs.dart';

class WhvAPIEndPoint {
  // Wishlist Endpoints
  static String whvCreateWishlist = 'wc/v3/wishlist/create';
  static String whvGetWishlist = 'whv/v1/wishlists';
  static String whvGetUpcomingWishlist = 'whv/v1/upcoming-wishlists';
  static String whvUpdateWishlist = 'wc/v3/wishlist/update/%s';
  static String whvDeleteWishlist = 'wc/v3/wishlist/delete/%s' +
      '?consumer_key=' +
      CONSUMER_KEY +
      '&consumer_secret=' +
      CONSUMER_SECRET;

  // Wishes Endpoints
  static String whvCreateWish = 'wc/v3/wishlist/%s/add_product';
  static String whvGetWishes = 'whv/v1/wishes';
  static String whvGetUpcomingWishes = 'whv/v1/wishes';
  static String whvUpdateWishViews = 'whv/v1/update_number_of_views';
  static String whvDeleteWish = 'wc/v3/wishlist/remove_product/%s';
  static String whvAddToWishlistProduct = 'whv/v1/post-product-import';
  static String whvCreateNewWishlist = 'whv/v1/post-wishlist';

  // Wishes Endpoints from Orchestrator
  static String whvGetTheWishes = 'flutter-import/v1/wishlist?wishid=%s';

  static const getDashboardData = 'whv/v1/dashboard';
  // Add the Avatar URL to the Database
  static String whvAddAvatarToDB = 'whv/v1/avatar?id=%s';

  // Add the Avatar URL to the Database
  static String whvDelAvatarFromDB = 'whv/v1/delavatar?id=%s';

  // Get User Agents URL
  static String whvGetUserAgents = 'whv/v1/user-agents';

  // Get Product Keywords URL
  static String whvGetProductKeywords = 'whv/v1/product-keywords';

  // Get Product Keywords URL
  static String whvGetTrendingProducts = 'whv/v1/trending';
}
