import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

class WhvSectionTitle extends StatelessWidget {
  const WhvSectionTitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: primaryTextStyle(weight: FontWeight.w600),
      ),
    );
  }
}
