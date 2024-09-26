import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

class WhvClearHistoryOrBookmarkButton extends StatelessWidget {
  const WhvClearHistoryOrBookmarkButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      shape: Border(
        top: BorderSide(
          color: context.dividerColor.withOpacity(0.1),
        ),
        bottom: BorderSide(
          color: context.dividerColor.withOpacity(0.1),
        ),
      ),
      color: context.cardColor,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            Icons.history,
            color: context.iconColor,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: primaryTextStyle(weight: FontWeight.w600, size: 14),
          ),
        ],
      ),
    );
  }
}
