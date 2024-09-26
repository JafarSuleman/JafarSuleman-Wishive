import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

class WhvQuantityContainer extends StatelessWidget {
  const WhvQuantityContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      // decoration: BoxDecoration(
      //   color: context.cardColor,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Observer(builder: (_) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                addToWishlistStore.decrementQuantity();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: Icon(
                  CupertinoIcons.minus,
                  size: 20,
                ),
              ),
            ).paddingSymmetric(horizontal: 10),
            Observer(builder: (_) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: context.cardColor,
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                  child: Text(
                    addToWishlistStore.quantityCount.toString(),
                    style: TextStyle(
                        color: context.iconColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(horizontal: 10),
                ),
              );
            }),
            InkWell(
                onTap: () {
                  addToWishlistStore.incrementQuantity();
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    size: 20,
                  ),
                )).paddingSymmetric(horizontal: 10),
          ],
        );
      }),
    );
  }
}
