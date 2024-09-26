// ignore_for_file: public_member_api_docs, sort_constructors_first
class WhvTopSiteModel {
  final String id;
  final String title;
  final String url;
  final String? icon;
  final int color;
  WhvTopSiteModel({
    required this.id,
    required this.title,
    required this.url,
    required this.color,
    this.icon,
  });
}
