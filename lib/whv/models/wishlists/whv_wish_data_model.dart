
class WhvWishDataModel {

  String? itemId;
  String? wishlistId;
  String? productId;
  String? variationId;
  String? author;
  String? dateAdded;
  String? quantity;
  String? price;
  String? inStock;
  String? order;
  String? imageVariationURL;
  String? comment;

  WhvWishDataModel({this.itemId, this.wishlistId, this.productId, this.variationId,
                    this.author, this.dateAdded, this.quantity, this.price,
                    this.inStock, this.order, this.imageVariationURL, this.comment});

  factory WhvWishDataModel.fromJson(Map<String, dynamic> json) {
    return WhvWishDataModel(
        itemId: json["ID"],
        wishlistId: json["wishlist_id"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        author: json["author"],
        dateAdded: json["date"],
        quantity: json["quantity"],
        price: json["price"],
        inStock: json["in_stock"],
        order: json["order"],
        imageVariationURL: json["whv_imgvar_url"],
        comment: json["whv_ftf"]
    );
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["ID"] = this.itemId;
    data["wishlist_id"] = this.wishlistId;
    data["product_id"] = this.productId;
    data["variation_id"] = this.variationId;
    data["author"] = this.author;
    data["date"] = this.dateAdded;
    data["quantity"] = this.quantity;
    data["price"] = this.price;
    data["in_stock"] = this.inStock;
    data["order"] = this.order;
    data["whv_imgvar_url"] = this.imageVariationURL;
    data["whv_ftf"] = this.comment;

    return data;
  }

}
