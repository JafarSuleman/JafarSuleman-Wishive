import 'package:flutter/material.dart';
import 'package:socialv/whv/utils/whv_images.dart';

class WhvDefaultHomePage extends StatelessWidget {
  const WhvDefaultHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      default_homepage,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
    );
    // return Stack(
    //   children: [
    //     Transform.rotate(
    //       angle: 50 * pi / 180,
    //       child: Transform(
    //         alignment: Alignment.center,
    //         transform: Matrix4.rotationY(pi),
    //         child: SvgPicture.asset(
    //           ic_default_homepage_arrow,
    //           height: double.infinity,
    //           width: double.infinity,
    //         ),
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment.center,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: 20,
    //           vertical: 20,
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Transform(
    //               alignment: Alignment.center,
    //               transform: Matrix4.rotationY(pi),
    //               child: SvgPicture.asset(
    //                 ic_default_homepage_search,
    //                 height: 80,
    //                 width: 80,
    //               ),
    //             ),
    //             SizedBox(height: 30),
    //             Text(
    //               language.browseYourFavoriteStores,
    //               textAlign: TextAlign.center,
    //               style: GoogleFonts.passionOne(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 40,
    //                 color: context.primaryColor,
    //               ),
    //             ),
    //             SizedBox(height: 30),
    //             Text(
    //               language.addWishes,
    //               style: GoogleFonts.passionOne(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 40,
    //                 color: context.primaryColor,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
