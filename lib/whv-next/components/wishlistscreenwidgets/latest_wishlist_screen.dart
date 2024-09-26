import 'package:flutter/cupertino.dart';
import 'package:socialv/components/CustomMultiImageLayout/multi_image_layout.dart';

class LatestWishlistScreen extends StatelessWidget {
  const LatestWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No Latest Wishlist Data',style: TextStyle(
        fontSize: 25,
      ),)),
    );
  }
}
