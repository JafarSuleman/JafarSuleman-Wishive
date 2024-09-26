import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({
    super.key,
    required this.title,
    this.child,
  });
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: context.iconColor,
          ),
        ),
        child ?? SizedBox(),
      ],
    );
  }
}
