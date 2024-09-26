import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/shop/components/cached_image_widget.dart';
import 'package:socialv/whv/models/wishlists/whv_scrape_model.dart';

class WishWizardImagesListview extends StatelessWidget {
  const WishWizardImagesListview({
    super.key,
    required this.data,
  });

  final WhvScrapeDataModel? data;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return webviewStore.isExtractingData ||
              webviewStore.isHeadlessWebviewLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 40.height,
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 30, vertical: 10),
                //   child: Text(
                //     whvLanguage.greatNowSelectImageForThisItem,
                //     textAlign: TextAlign.center,
                //     style: GoogleFonts.leagueSpartan(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: context.iconColor,
                //     ),
                //   ),
                // ),
                // 10.height,
                Expanded(
                  child: GridView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    // controller: widget.scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: data?.imageUrlsList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return data?.imageUrlsList?[index] != null
                          ? Observer(builder: (_) {
                              return GestureDetector(
                                onTap: () {
                                  addToWishlistStore.userSelectedImageUrl =
                                      data?.imageUrlsList?[index] ?? '';
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: addToWishlistStore
                                                      .userSelectedImageUrl ==
                                                  data?.imageUrlsList?[index]
                                              ? context.primaryColor
                                              : Colors.transparent)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedImageWidget(
                                      url: data?.imageUrlsList?[index] ?? '',
                                      height: 30,
                                    ),
                                  ),
                                ),
                              );
                            })
                          : SizedBox();
                    },
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     if (!addToWishlistStore
                //         .userSelectedImageUrl.isEmptyOrNull) {
                //       addtoWishlistFinalBottomSheet(context);
                //     } else {
                //       toast(whvLanguage.pleaseSelectImage, print: true);
                //     }
                //   },
                //   child: Container(
                //     height: 35,
                //     width: 100,
                //     margin: EdgeInsets.symmetric(vertical: 15),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: context.primaryColor),
                //     child: Center(
                //       child: Text(
                //         language.next,
                //         style: GoogleFonts.leagueSpartan(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            );
    });
  }
}
