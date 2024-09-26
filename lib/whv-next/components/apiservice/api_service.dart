import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/wishlists/wishlist_response.dart';

Future<WishlistResponse> fetchWishlists() async {
  final response = await http.get(Uri.parse('https://app23ndp01nt.wishive.com/wp-json/whv/v1/wishlists-dashboard?id=5&dashboard_data=true&page=1&per_page=10'),headers: {
    "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcDIzbmRwMDFudC53aXNoaXZlLmNvbSIsImlhdCI6MTcyMTkxMTg3OCwibmJmIjoxNzIxOTExODc4LCJleHAiOjE3MjI1MTY2NzgsImRhdGEiOnsidXNlciI6eyJpZCI6IjMwIn19fQ.FPFvF8U1DEN4m3nylP5RwKJ9ZKhjYC-zgbpxjlLeoxE",
    "Content-Type":"application/json"
  });

  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
    return WishlistResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
