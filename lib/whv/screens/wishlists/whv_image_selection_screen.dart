// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/wishlists/whv_wish_wizard_image_listview.dart';
import 'package:socialv/whv/models/wishlists/whv_scrape_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_select_wishlist_screen.dart';

class WhvImageSelectionScreen extends StatefulWidget {
  // final ScrollController scrollController;
  final String htmlContent;
  final bool isForEditImage;
  const WhvImageSelectionScreen(
      {Key? key,
      // required this.scrollController,
      required this.htmlContent,
        this.isForEditImage =false,
      })
      : super(key: key);
  @override
  State<WhvImageSelectionScreen> createState() =>
      _WhvImageSelectionScreenState();
}

class _WhvImageSelectionScreenState extends State<WhvImageSelectionScreen> {
  WhvScrapeDataModel? data;
  @override
  void initState() {
    super.initState();

    init();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    await runHeadlessWebview();
    extracteData();
  }

  runHeadlessWebview() async {
    await webviewStore.runHeadlessWebviewHTML();
  }

  extracteData() async {
    data = await webviewStore.extractData(widget.htmlContent);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          whvLanguage.wishWizard,
          style: TextStyle(
              color: context.iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
              // fontSize:
              ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (!addToWishlistStore.userSelectedImageUrl.isEmptyOrNull) {
                // addtoWishlistFinalBottomSheet(context);

                if(widget.isForEditImage){
                  finish(context,);
                }else{
                  WhvSelectWishlistScreen().launch(context).then((value) {
                    addToWishlistStore.resetAllFields(
                      shouldResetUserSelectedImageUrl: false,
                    );
                  });
                }
              } else {
                toast(whvLanguage.pleaseSelectImage, print: true);
              }
            },
            child: Observer(builder: (_) {
              return Container(
                height: 8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: addToWishlistStore.userSelectedImageUrl.isEmptyOrNull
                        ? context.primaryColor.withOpacity(0.2)
                        : context.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Center(
                  child: Text(
                    language.next,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: addToWishlistStore
                                .userSelectedImageUrl.isEmptyOrNull
                            ? context.primaryColor
                            : context.cardColor),
                  ),
                ),
              );
            }),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            // 50.height,
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  whvLanguage.selectAnImage,
                  style: TextStyle(
                      color: context.cardColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: WishWizardImagesListview(data: data)
                        .paddingSymmetric(horizontal: 35)
                        .paddingTop(30))),
          ],
        ),
      ),
    );
  }
}
