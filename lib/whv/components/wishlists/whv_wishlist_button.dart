import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhvWishlistButton extends StatelessWidget {
  const WhvWishlistButton({
    super.key,
    this.height = 35,
    this.width = 100,
    this.onTap,
    this.color,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  final double? height, width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        height: this.height,
        width: this.width,
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
        child: Center(
          child: Text(
            this.text,
            style: GoogleFonts.leagueSpartan(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
