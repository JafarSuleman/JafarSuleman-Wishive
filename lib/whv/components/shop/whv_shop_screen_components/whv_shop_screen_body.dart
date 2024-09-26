import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/main.dart';
import 'package:socialv/whv/components/shop/whv_shop_screen_components/whv_shop_webview.dart';
import 'package:socialv/whv/screens/shop_webview/whv_tabs_screen.dart';

import 'package:socialv/whv/utils/whv_images.dart';

import '../whv_qr_scanner_dialog.dart';
import 'whv_default_home_page/whv_default_home_page.dart';
import 'whv_search_textfield.dart';
import 'whv_top_sites_and_library_screen/whv_top_sites_and_library_screen.dart';

class WhvShopScreenBody extends StatefulWidget {
  const WhvShopScreenBody({
    super.key,
    required this.url,
    required this.controller,
  });

  final String? url;
  final ScrollController controller;

  @override
  State<WhvShopScreenBody> createState() => _WhvShopScreenBodyState();
}

class _WhvShopScreenBodyState extends State<WhvShopScreenBody> {
  @override
  didChangeDependencies() {
    if (widget.url != null) {
    } else {
      webviewStore.initializeSearchTextController();
    }

    super.didChangeDependencies();
  }

  // whenever the qr scanner gets some data this method is called.
  _onQrCodeScanned(String? scannedText) {
    if (scannedText != null && scannedText != "") {
      var _url = Uri.parse(scannedText);

      // we check if the url is an absolute url or not. if it is then we load url
      // otherwise we don't... Means we load complete urls not any type of text.
      if (_url.isAbsolute) {
        webviewStore.loadUrl(newUrl: scannedText);
        webviewStore.updateSearchTextFieldValue(scannedText);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (context) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: webviewStore.isWebviewScrolled ? 30 : 0,
            child: 30.height,
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: WhvSearchTextField(),
              ),
              _qrScannerAndTabsButtonsRow(context),
            ],
          ),
        ),
        Expanded(
          child: Observer(builder: (context) {
            return webviewStore.showWebView
                ? WhvShopWebView(
                    controller: widget.controller,
                  )
                : Observer(builder: (context) {
                    return webviewStore.isSearching
                        ? WhvTopSitesAndLibraryScreen()
                        : WhvDefaultHomePage();
                  });
          }),
        ),
      ],
    );
  }

  Row _qrScannerAndTabsButtonsRow(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            webviewStore.toggleIsSearching(false);

            await showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: WhvQRScannerDialog(
                  onQrCodeScanned: _onQrCodeScanned,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: context.iconColor,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            webviewStore.toggleIsSearching(false);

            WhvTabsScreen().launch(context);
          },
          child: SvgPicture.asset(
            multitple_tabs,
            colorFilter: ColorFilter.mode(
              context.iconColor,
              BlendMode.srcIn,
            ),
            height: 30,
          ),
        ),
      ],
    );
  }
}
