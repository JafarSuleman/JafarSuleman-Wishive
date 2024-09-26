import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class WisherSelection extends StatelessWidget {
  final Widget leadingWidget;
  final String title;
  final String description;
  final void Function()onTap;
  final bool isSelected;
  const WisherSelection({super.key, required this.onTap,  required this.isSelected,  required this.leadingWidget, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap.call(),
      child: Container(
        width: context.width(),
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? context.primaryColor: Colors.transparent,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leadingWidget,
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: boldTextStyle(
                      size: 12
                    ),
                  ),
                  2.height,
                  Flexible(
                    child: Text(
                      description,
                      style: secondaryTextStyle(
                        size: 10
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
