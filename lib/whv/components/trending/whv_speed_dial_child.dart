import 'package:flutter/material.dart';

class WhvSpeedDialChild extends StatelessWidget {
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Function()? onTap;
  final bool mini;

  WhvSpeedDialChild(
      {required this.label,
      required this.icon,
      required this.backgroundColor,
      this.onTap,
      this.mini = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 8),
        FloatingActionButton(
          onPressed: onTap,
          child: icon,
          mini: mini,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}
