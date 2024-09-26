import 'package:flutter/material.dart';

import '../../components/trending/whv_on_wishive_search_textfield.dart';

class WhvOnWishiveScreen extends StatelessWidget {
  const WhvOnWishiveScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WhvOnWishiveSearchTextField(),
      ],
    );
  }
}
