import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/utils/cached_network_image.dart';

class ExistingWishlistImagContainer extends StatelessWidget {
  const ExistingWishlistImagContainer({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: context.iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            // border: Border(
            //   right: BorderSide(
            //     color: context.iconColor.withOpacity(
            //         0.3), // Choose your border color here
            //     width:
            //         1.0, // Choose your border width here
            //   ),
            // ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: imageUrl.validate().isEmpty
                ? placeHolderWidget(fit: BoxFit.cover)
                : Image.network(
              imageUrl,
              fit: BoxFit.fill,
              height: 90,
            ),
          ),
        ),
        Container(
          width: 1,
          decoration: BoxDecoration(
            color: context.iconColor.withOpacity(0.2),
          ),
        )
      ],
    );
  }
}
