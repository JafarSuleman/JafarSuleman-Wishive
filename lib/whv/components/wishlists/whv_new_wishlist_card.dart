// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/images.dart';

class WhvNewWishlistCard extends StatelessWidget {
  const WhvNewWishlistCard({super.key, this.isSelected = false});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.cardColor,
        border: isSelected
            ? Border.all(
                color: context.primaryColor,
              )
            : null,
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          ic_heart_list,
          color: context.primaryColor,
          height: 40,
        ),
        title: Text(
          whvLanguage.newWishlist,
          style: TextStyle(
              color: context.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          whvLanguage.newWishlistDescription,
          style: TextStyle(
              color: context.primaryColor.withOpacity(0.6),
              fontSize: 11,
              fontWeight: FontWeight.bold),
        ).paddingTop(5),
      ).paddingSymmetric(vertical: 10),
    );
  }
}
