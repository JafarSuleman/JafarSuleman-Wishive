// ignore_for_file: public_member_api_docs, sort_constructors_first
// model class is used to scrape data from webview.
class WhvScrapeDataModel {
  String? productTitle;
  String? productPrice;
  String? availability;
  List<String>? imageUrlsList;
  WhvScrapeDataModel({
    this.productTitle,
    this.productPrice,
    this.availability,
    this.imageUrlsList,
  });

  WhvScrapeDataModel copyWith({
    String? productTitle,
    String? productPrice,
    String? availability,
    List<String>? imageUrlsList,
  }) {
    return WhvScrapeDataModel(
      productTitle: productTitle ?? this.productTitle,
      productPrice: productPrice ?? this.productPrice,
      availability: availability ?? this.availability,
      imageUrlsList: imageUrlsList ?? this.imageUrlsList,
    );
  }
}
