import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/post/components/reaction_button_widget.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/utils/cached_network_image.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_model.dart';
import 'package:socialv/whv/screens/wishlists/whv_wish_details_screen.dart';
import 'package:socialv/whv/screens/wishlists/whv_wishes_list_horizontal_screen.dart';

import '../../../components/like_button_widget.dart';
import '../../screens/main/whv_main_screen.dart';

class WhvWishItemVerticalView extends StatefulWidget {
  const WhvWishItemVerticalView({
    super.key,
    required this.wishModel,
    required this.onWishPressed,
  });

  final WhvWishModel wishModel;
  final void Function() onWishPressed;

  @override
  State<WhvWishItemVerticalView> createState() => _WhvWishItemVerticalViewState();
}

class _WhvWishItemVerticalViewState extends State<WhvWishItemVerticalView> {
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus = FocusNode();
  GiphyGif? gif;
  bool isShowCommentSection = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onWishPressed.call();
      },
      child: Container(
        height: context.width()+(isShowCommentSection ? 50:0),
        child: Column(
          children: [
            Container(
              height: 290,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(defaultAppButtonRadius),
                        bottomLeft: Radius.circular(defaultAppButtonRadius),
                      ),
                    ),
                    child: cachedImage(widget.wishModel.wishImage, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 7),
                      child: Text(
                        widget.wishModel.productTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: primaryTextStyle(
                          color: context.cardColor,
                          weight: FontWeight.w500,
                          size: 14
                        ) ,
                      ),
                    )
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: InkWell(
                      onTap: (){},
                      borderRadius: BorderRadius.circular(10),
                      radius: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                        child: Row(
                          children: [
                            Image.asset(ic_gift, height: 25, width: 25,),
                            5.width,
                            Text(
                              whvLanguage.grantGift,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: boldTextStyle(
                                  color: context.cardColor,
                                  size: 16
                              ) ,
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
            10.height,
            Container(
              height: 40,
              color: context.cardColor,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  if (appStore.isReactionEnable == 1)
                    if (reactions.validate().isNotEmpty)
                      ReactionButton(
                        isComments: false,
                        isReacted: false,
                        // currentUserReaction: post.curUserReaction,
                        onReacted: (id) {
                          // isReacted = true;
                          // postReaction(addReaction: true, reactionID: id);
                        },
                        onReactionRemoved: () {
                          // isReacted = false;
                          // postReaction(addReaction: false);
                        },
                      )
                    else
                      Offstage()
                  else
                    LikeButtonWidget(
                      key: ValueKey(false),
                      onPostLike: () {
                        // postLike();
                      },
                      isPostLiked: false,
                    ),
                  IconButton(
                    onPressed: () {
                      setState((){
                        isShowCommentSection = !isShowCommentSection;
                      });
                    },
                    icon: Image.asset(
                      ic_chat,
                      height: 22,
                      width: 22,
                      fit: BoxFit.cover,
                      color: context.iconColor,
                    ),
                  ),
                  Image.asset(
                    ic_send,
                    height: 22,
                    width: 22,
                    fit: BoxFit.cover,
                    color: context.iconColor,
                  ).onTap(() {
                    String saveUrl ='';// "$DOMAIN_URL/${widget.postId.validate()}";
                    Share.share(saveUrl);
                  }, splashColor: Colors.transparent, highlightColor: Colors.transparent),
                  const Spacer(),
                  TextButton(
                    onPressed: () async{
                      // SinglePostScreen(postId: widget.post.activityId.validate()).launch(context).then((value) {
                      //   if (value ?? false) widget.callback?.call();
                      // });
                      ///
                      // bottomSheetContext = context;
                      // await openGeneralBottomSheet(
                      //   context: context,
                      //   widgetToShow: CommentScreen(
                      //     postId: widget.post.activityId.validate(),
                      //     openInBottomSheet: true,
                      //   ),
                      // );
                     ///
                      // widget.commentCallback?.call();
                    },
                    child: Text('${appStore.displayPostCommentsCount == 1 ? (widget.wishModel.wishComment.isNotEmpty ? '1 ' : '0 ')+language.comments :''  }', style: secondaryTextStyle()),
                  ),
                ],
              ),
            ),
            /// Add Comment Row Section
            if(isShowCommentSection)
              ...[
                5.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      cachedImage(appStore.loginAvatarUrl, height: 36, width: 36, fit: BoxFit.cover).cornerRadiusWithClipRRect(100),
                      10.width,
                      AppTextField(
                        focus: commentFocus,
                        controller: commentController,
                        textFieldType: TextFieldType.MULTILINE,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: language.writeAComment,
                          hintStyle: secondaryTextStyle(size: 16),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onTap: () {
                          /// Clear recently posted comment id
                          // commentParentId = -1;
                        },
                      ).expand(),
                      if (appStore.showGif)
                        IconButton(
                          onPressed: () {
                            selectGif(context: context).then((value) {
                              if (value != null) {
                                gif = value;
                                setState(() {});
                                log('Gif Url: ${gif!.images!.original!.url.validate()}');
                              }
                            });
                          },
                          icon: cachedImage(ic_gif, color: appStore.isDarkMode ? bodyDark : bodyWhite, width: 30, height: 24, fit: BoxFit.contain),
                        ),
                      InkWell(
                        onTap: () {
                          if (commentController.text.isNotEmpty || gif != null) {
                            hideKeyboard(context);
                            String content = commentController.text.trim().replaceAll("\n", "</br>").replaceAll(' ', '&nbsp;');
                            commentController.clear();
                            isShowCommentSection = false;
                            setState(() {});
                            // postComment(content, parentId: null);
                          } else {
                            toast(language.writeComment);
                          }
                        },
                        child: cachedImage(ic_send, color: appStore.isDarkMode ? bodyDark : bodyWhite, width: 24, height: 24, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ],
            Divider(
              thickness: 1,
              color: Color(0xFFDFDFE1),
            ),
          ],
        ),
      ),
    );
  }

  // void postComment(String commentContent, {int? parentId}) async {
  //   ifNotTester(() async {
  //     CommonMessageResponse commonMessageResponse =  await savePostComment(
  //       postId: widget.post.activityId.validate(),
  //       content: commentContent,
  //       parentId: parentId,
  //       gifId: gif != null ? gif!.id.validate() : "",
  //       gifUrl: gif != null ? gif!.images!.original!.url.validate() : "",
  //     ).catchError((e) {
  //       toast(e.toString());
  //       return e;
  //     });
  //     if(commonMessageResponse.commentId!=null){
  //       int count = widget.post.commentCount.validate();
  //       widget.post.commentCount = count+1;
  //     }
  //     gif = null;
  //     setState(() {});
  //   });
  // }
}
