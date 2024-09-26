import 'package:socialv/whv/constants/whv_constants.dart';

class WhvTrendingFilterModel {
  String title;
  String sortBy;
  String orderBy;
  WhvTrendingFilterModel({
    required this.title,
    this.sortBy = WhvConstants.price,
    this.orderBy = WhvConstants.desc,
  });
}
