import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/utils/whv_images.dart';

class WhvAddWishCustomeFloatingBtn extends StatefulWidget {
  final Function()? onTap, onTapAddWish;
  final bool isMenuOpen;
  const WhvAddWishCustomeFloatingBtn({
    super.key,
    this.isMenuOpen = false,
    this.onTapAddWish,
    this.onTap,
  });

  @override
  State<WhvAddWishCustomeFloatingBtn> createState() =>
      _WhvAddWishCustomeFloatingBtnState();
}

class _WhvAddWishCustomeFloatingBtnState
    extends State<WhvAddWishCustomeFloatingBtn> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300), // Animation duration
        height: 45,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: context.primaryColor,
        ),
        padding: EdgeInsets.only(left: 6, right: 8),
        child: IntrinsicWidth(
          child: widget.isMenuOpen
              ? Center(
                  child: Icon(CupertinoIcons.multiply_circle_fill),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    5.width,
                    SvgPicture.asset(
                      ic_heart_add,
                      height: 30,
                      width: 30,
                    ).onTap(widget.onTapAddWish),
                    3.width,
                    InkWell(
                      onTap: widget.onTapAddWish,
                      child: AnimatedContainer(
                        duration:
                            Duration(milliseconds: 300), // Animation duration
                        width: whvTrendingProductDetailWebViewStore
                                .isExpendFloatingButoon
                            ? null
                            : 0,
                        child: Text(
                          whvLanguage.addWish,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.cardColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    7.width,
                    Container(
                      height: 50,
                      width: 1,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                    ),
                    5.width,
                    GestureDetector(
                        onTap: widget.onTap,
                        // () {
                        //   whvTrendingProductDetailWebView
                        //       .changeStateOfFloatingButtonMenuExpend(state: true);
                        // },
                        child: Image.asset(
                          ic_arrow_ios_up,
                          height: 24,
                          width: 24,
                        )),
                  ],
                ),
        ),
      );
    });
  }
}
