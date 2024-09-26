import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/utils/whv_images.dart';

class WhvAddItemToWishlistSuccessBottomSheetBody extends StatefulWidget {
  const WhvAddItemToWishlistSuccessBottomSheetBody({
    super.key,
    required this.isOnProductPage,
  });
  final bool isOnProductPage;

  @override
  State<WhvAddItemToWishlistSuccessBottomSheetBody> createState() => _WhvAddItemToWishlistSuccessBottomSheetBodyState();
}

class _WhvAddItemToWishlistSuccessBottomSheetBodyState extends State<WhvAddItemToWishlistSuccessBottomSheetBody>  with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {}); // Update the progress indicator
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: context.width(),
          decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              widget.isOnProductPage ? Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.cardColor,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  ic_heart_check,
                  color: context.primaryColor,
                  height: 45,
                ),
              )
                  : Image.asset(
                ic_prod_page_layout,
                height: 45,
              ),
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [Colors.grey, Colors.white],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: context.cardColor,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 50.height,

              // Image.asset(
              //   isOnProductPage ? ic_clapping_hands : ic_prod_page_layout,
              //   height: 140,
              //   color: isOnProductPage ? context.primaryColor : null,
              // ),
              30.height,
              Text(
                widget.isOnProductPage ? whvLanguage.youAreAllSet : whvLanguage.oops,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: context.iconColor,
                ),
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _bottomSheetBodyText(
                  context,
                  widget.isOnProductPage
                      ? whvLanguage.newWishIsBeingAdded
                      : whvLanguage.notOnProductPageMessage,
                ),
              ),
              50.height,
              appButton(
                  context: context,
                  height: 44,
                  text: widget.isOnProductPage ? language.continueShopping : whvLanguage.gotIt,
                  width: MediaQuery.of(context).size.width * 0.5,
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }),
              40.height,
            ],
          ),
        ),
      ],
    );
  }

  Text _bottomSheetBodyText(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: context.iconColor,
      ),
    );
  }
}
