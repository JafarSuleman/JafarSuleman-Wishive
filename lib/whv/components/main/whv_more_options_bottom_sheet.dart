import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/common_models.dart';
import 'package:socialv/network/rest_apis.dart';
import 'package:socialv/utils/app_constants.dart';

class WhvMoreOptionsBotomSheet extends StatefulWidget {
  final VoidCallback? callback;

  WhvMoreOptionsBotomSheet({this.callback});

  @override
  State<WhvMoreOptionsBotomSheet> createState() =>
      _WhvMoreOptionsBotomSheetState();
}

class _WhvMoreOptionsBotomSheetState extends State<WhvMoreOptionsBotomSheet> {
  List<DrawerModel> options = getDrawerOptions();

  int selectedIndex = -1;
  bool isLoading = false;
  bool backToHome = true;

  @override
  void initState() {
    super.initState();
    if (appStore.isLoading) {
      isLoading = true;
      appStore.setLoading(false);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    if (isLoading && backToHome) widget.callback?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(options.length, (index) {
                        DrawerModel e = options.validate()[index];
                        return SettingItemWidget(
                          decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? context.primaryColor.withAlpha(30)
                                  : context.cardColor),
                          title: e.title.validate(),
                          titleTextStyle: boldTextStyle(size: 14),
                          leading: Image.asset(e.image.validate(),
                              height: 22,
                              width: 22,
                              fit: BoxFit.fill,
                              color: appColorPrimary),
                          trailing: e.isNew
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: appGreenColor.withAlpha(30),
                                      borderRadius: radius()),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  child: Text(language.lblNew,
                                      style: boldTextStyle(
                                          color: appGreenColor, size: 12)),
                                )
                              : Offstage(),
                          onTap: () async {
                            selectedIndex = index;
                            setState(() {});

                            if (e.attachedScreen != null) {
                              backToHome = false;
                              finish(context);
                              e.attachedScreen.launch(context);
                            } else {
                              finish(context);
                            }
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ).expand(),
              Column(
                children: [
                  VersionInfoWidget(prefixText: 'v'),
                  16.height,
                  TextButton(
                    onPressed: () {
                      showConfirmDialogCustom(
                        context,
                        primaryColor: appColorPrimary,
                        title: language.logoutConfirmation,
                        onAccept: (s) {
                          logout(context);
                        },
                      );
                    },
                    child: Text(language.logout,
                        style: boldTextStyle(color: context.primaryColor)),
                  ),
                  20.height,
                ],
              ),
            ],
          ),
          LoadingWidget().center().visible(appStore.isLoading)
        ],
      ),
    );
  }
}
