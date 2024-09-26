import 'package:intl/intl.dart'; // Add this import for date formatting

class WishlistData {
  final String? userId;
  final String? displayName;
  final String? avatarThumb;
  final String? avatarFull;
  final String? wishlistId;
  final String? wishlistName;
  final String? privacy;
  final String? comment;
  final String? wishId;
  final String? productId;
  final String? productTitle;
  final String? totalNumberOfWishes;
  final String? totalNumberOfWishesGranted;
  final String? totalNumberOfWishesRemaining;
  final String? percentageOfWishesGranted;
  final String? wishlistImage;
  final String? dueDate;
  final String? dateCreated;

  WishlistData({
    this.userId,
    this.displayName,
    this.avatarThumb,
    this.avatarFull,
    this.wishlistId,
    this.wishlistName,
    this.privacy,
    this.comment,
    this.wishId,
    this.productId,
    this.productTitle,
    this.totalNumberOfWishes,
    this.totalNumberOfWishesGranted,
    this.totalNumberOfWishesRemaining,
    this.percentageOfWishesGranted,
    this.wishlistImage,
    this.dueDate,
    this.dateCreated,
  });

  factory WishlistData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      print('WishlistData: No data found');
      return WishlistData();
    }
    return WishlistData(
      userId: json['user_id'],
      displayName: json['display_name'],
      avatarThumb: json['avatar_thumb'],
      avatarFull: json['avatar_full'],
      wishlistId: json['wishlist_id'],
      wishlistName: json['wishlist_name'],
      privacy: json['privacy'],
      comment: json['comment'],
      wishId: json['wish_id'],
      productId: json['product_id'],
      productTitle: json['product_title'],
      totalNumberOfWishes: json['total_number_of_wishes'],
      totalNumberOfWishesGranted: json['total_number_of_wishes_granted'],
      totalNumberOfWishesRemaining: json['total_number_of_wishes_remaining'],
      percentageOfWishesGranted: json['percentage_of_wishes_granted'],
      wishlistImage: json['wishlist_image'],
      dueDate: json['due_date'],
      dateCreated: formatDate(json['date_created']),
    );
  }

  static String? formatDate(String? dateTime) {
    if (dateTime == null) return null;
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy-MM-dd').format(parsedDate); // Format to only date
    } catch (e) {
      print('Error formatting date: $e');
      return dateTime;
    }
  }
}
