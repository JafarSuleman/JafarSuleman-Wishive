// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/components/wishlists/whv_wish_wisher_selection.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/constants/whv_new_wishlist_constants.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import 'package:socialv/whv/screens/wishlists/whv_final_wish_wizard_screen.dart';

import '../calendar/whv_calendar_screen.dart';

class WhvCreateNewWishlistScreen extends StatefulWidget {
  final bool isFromMyWishlistsScreen;
  const WhvCreateNewWishlistScreen(
      {super.key, this.isFromMyWishlistsScreen = false});

  @override
  State<WhvCreateNewWishlistScreen> createState() =>
      _WhvCreateNewWishlistScreenState();
}

class _WhvCreateNewWishlistScreenState
    extends State<WhvCreateNewWishlistScreen> {
  bool validate() {
    // if (addToWishlistStore.whvDueDate == null) {
    //   toast(whvLanguage.selectDueDate);
    //   return false;
    // } else

    if (addToWishlistStore.wishlistName.text.isEmpty) {
      toast(whvLanguage.pleaseEnterWishlistName);
      return false;
    }
    // else if (addToWishlistStore.wishlistPrivacy == null) {
    //   toast(whvLanguage.pleaseSelectPrivacyForWishlist);
    //   return false;
    // }
    return true;
  }

  tryCreateNewWishlist() async {
    try {
      Map body = {};
      body['userId'] = appStore.loginUserId;
      body['wishlistName'] = addToWishlistStore.wishlistName.text.trim();
      body['dueDate'] = addToWishlistStore.whvDueDate ?? WhvConstants.WhvNONE;
      body['wishlistComment'] = addToWishlistStore.wishlistComment.text.trim();
      body['wishlistPrivacy'] =
          addToWishlistStore.wishlistPrivacy.toLowerCase();
      appStore.setLoading(true);
      await whvCreateNewWishlist(requestBody: body).then((response) async {
        appStore.setLoading(false);
        if (response.status.toLowerCase() ==
            WhvConstants.WhvSuccess.toLowerCase()) {
          finish(context);
          toast(
              "${response.title} ${whvLanguage.wishlistCreateSuccessMessage}");
        } else {
          appStore.setLoading(false);
          toast("${response.title} ${response.message}");
        }
      });
    } catch (e) {
      print('create new wishlist exception $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValidated =
        addToWishlistStore.wishlistName.text.trim().isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          whvLanguage.newWishlist,
          style: TextStyle(
              color: context.iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
              // fontSize:
              ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              // WhvMyWishlistBody().createState().initState();
              FocusScope.of(context).unfocus();
              if (validate()) {
                if (addToWishlistStore.isScheduleWishlist) {
                  WhvCalendarScreen(
                          isFromMyWishlistsScreen:
                              widget.isFromMyWishlistsScreen)
                      .launch(context);
                } else {
                  if (widget.isFromMyWishlistsScreen) {
                    if (await isNetworkAvailable()) {
                      tryCreateNewWishlist();
                    } else {
                      toast(errorInternetNotAvailable);
                    }
                  } else {
                    WhvFinalWishWizardScreen().launch(context);
                  }
                }
              }
            },
            child: Observer(builder: (_) {
              return Container(
                height: 8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: !isFormValidated
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
                        color: !isFormValidated
                            ? context.primaryColor
                            : context.cardColor),
                  ),
                ),
              );
            }),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: 50.height),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            25.height,
                            SizedBox(
                              height: 35,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                controller: addToWishlistStore.wishlistName,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (val) {
                                  // addToWishlistStore.setOnChangeWishlistName(val);
                                  // setState(() {
                                  //   validateWishlistName = val;
                                  // });
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      whvLanguage.enterANameForThisWishList,
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xFFB4B8C0)),
                                  fillColor: context.cardColor,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 15, top: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color(0xFFCFCFCF), width: 0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color(
                                          0xFFCFCFCF,
                                        ),
                                        width: 0.5),
                                  ),
                                ),
                              ),
                            ),
                            25.height,
                            TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: addToWishlistStore.wishlistComment,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              maxLines: 4,
                              minLines: 4,
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (val) {
                                // addToWishlistStore.setOnChangeWishlistName(val);
                                // setState(() {
                                //   validateWishlistName = val;
                                // });
                              },
                              decoration: InputDecoration(
                                hintText: whvLanguage
                                    .postACommentAboutThisWishlistOptional,
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xFFB4B8C0)),
                                fillColor: context.cardColor,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Color(0xFFCFCFCF), width: 0.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Color(
                                        0xFFCFCFCF,
                                      ),
                                      width: 0.5),
                                ),
                              ),
                            ),
                            25.height,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  addToWishlistStore.isScheduleWishlist =
                                      !addToWishlistStore.isScheduleWishlist;
                                });
                              },
                              child: Container(
                                height: 35,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color(0xFFCFCFCF), width: 0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      whvLanguage.scheduleEvent,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xFF5F6678)),
                                    ),
                                    Switch(
                                        value: addToWishlistStore
                                            .isScheduleWishlist,
                                        activeColor: context.iconColor,
                                        inactiveTrackColor: context.accentColor,
                                        inactiveThumbColor:
                                            context.dividerColor,
                                        thumbColor: MaterialStatePropertyAll<
                                            Color>(addToWishlistStore
                                                .isScheduleWishlist
                                            ? context.scaffoldBackgroundColor
                                            : context.dividerColor),
                                        trackOutlineWidth:
                                            const MaterialStatePropertyAll<
                                                double>(15),
                                        trackOutlineColor:
                                            MaterialStatePropertyAll<Color>(
                                                addToWishlistStore
                                                        .isScheduleWishlist
                                                    ? context.iconColor
                                                    : Colors.grey),
                                        onChanged: (value) {
                                          setState(() {
                                            addToWishlistStore
                                                .isScheduleWishlist = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ),
                            30.height,
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                whvLanguage.whoIsInTheLoop,
                                style: boldTextStyle(
                                  size: 14,
                                  color: context.iconColor,
                                ),
                              ),
                            ),
                            8.height,
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                whvLanguage
                                    .selectWhoCanViewAndWishesForThisWishlist,
                                style: secondaryTextStyle(
                                  size: 12,
                                  color: context.iconColor,
                                ),
                              ),
                            ),
                            20.height,
                            Observer(builder: (_) {
                              return WisherSelection(
                                onTap: () {
                                  setState(() {
                                    addToWishlistStore.wishlistPrivacy =
                                        WhvConstants.WhvShare;
                                  });
                                },
                                isSelected:
                                    addToWishlistStore.wishlistPrivacy ==
                                        WhvConstants.WhvShare,
                                leadingWidget: SvgPicture.asset(
                                  ic_friends,
                                  width: 15,
                                  height: 20,
                                  color: textPrimaryColorGlobal,
                                ),
                                title: whvLanguage.friends,
                                description: whvLanguage
                                    .wishlistCanBeViewedByAllMyFriends,
                              );
                            }),
                            10.height,
                            Observer(builder: (_) {
                              return WisherSelection(
                                onTap: () {
                                  setState(() {
                                    addToWishlistStore.wishlistPrivacy =
                                        WhvConstants.WhvPrivate;
                                  });
                                },
                                isSelected:
                                    addToWishlistStore.wishlistPrivacy ==
                                        WhvConstants.WhvPrivate,
                                leadingWidget: SvgPicture.asset(
                                  ic_wish_lock,
                                  width: 15,
                                  height: 20,
                                  color: textPrimaryColorGlobal,
                                ),
                                title: whvLanguage.private,
                                description:
                                    whvLanguage.wishlistCanBeViewedByOnlyMe,
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Observer(
            builder: (_) {
              if (appStore.isLoading) {
                return Positioned(
                  child: LoadingWidget(
                    isBlurBackground: true,
                  ),
                );
              } else {
                return Offstage();
              }
            },
          ),
        ],
      ),
    );
  }
}
