import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/posts/post_model.dart';
import 'package:socialv/utils/html_widget.dart';
import 'package:socialv/whv/components/wishlists/whv_wish_horizontal_view.dart';
import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/models/wishlists/whv_wish_model.dart';
import '../../../components/CustomMultiImageLayout/multi_image_layout.dart';
import '../../../screens/profile/screens/member_profile_screen.dart';
import '../../../utils/cached_network_image.dart';

class WhvWishesListHorizontalViewScreen extends StatefulWidget {
  const WhvWishesListHorizontalViewScreen({
    required this.wishPost,
    required this.wishModelList,
    required this.navigateToWishId,
  });
  final PostModel wishPost;
  final List<WhvWishModel> wishModelList;
  final int navigateToWishId;

  @override
  State<WhvWishesListHorizontalViewScreen> createState() => _WhvWishesListHorizontalViewScreenState();
}

class _WhvWishesListHorizontalViewScreenState extends State<WhvWishesListHorizontalViewScreen> {
  List<WhvWishModel> wishModelList = [];
  late final PageController _pageController;
  int currentWishIndex = 0;

  @override
  void initState() {
    int index = -1;
    wishModelList.addAll(widget.wishModelList);
    for(int i=0; i<wishModelList.length; i++){
      if('${wishModelList[i].id}' == '${widget.navigateToWishId}'){
        index = i;
        break;
      }
    }
    _pageController = PageController(initialPage: index);
    currentWishIndex = index;
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark,
            statusBarColor: appStore.isDarkMode ? Colors.black : Colors.white,
        ),
    );
    _pageController.dispose();
    appStore.setLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: textPrimaryColorGlobal,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light, statusBarColor: textPrimaryColorGlobal),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: context.cardColor),
            onPressed: () {
              finish(context);
            },
          ),
          titleSpacing: 0,
          title: Text("${(currentWishIndex+1)}/${wishModelList.length}",textAlign: TextAlign.center, style: boldTextStyle(size: 18,color: context.cardColor)),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: context.height()-100,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Text(
                  wishModelList[currentWishIndex].productTitle.validate(),
                  maxLines: 3,
                  style: primaryTextStyle(size: 16,color: context.cardColor),
                ).paddingSymmetric(horizontal: 10,vertical: 10),
                15.height,
                Row(
                  children: [
                    cachedImage(
                      widget.wishPost.userImage.validate(),
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(100),
                    12.width,
                    Text(
                      widget.wishPost.userName.validate(),
                      style: boldTextStyle(color: context.cardColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.wishPost.isUserVerified == 1) Image.asset(ic_tick_filled, width: 18, height: 18, color: blueTickColor).paddingSymmetric(horizontal: 4),
                  ],
                ).paddingSymmetric(horizontal: 16).onTap(() {
                  MemberProfileScreen(memberId: widget.wishPost.userId.validate()).launch(context);
                }, splashColor: Colors.transparent, highlightColor: Colors.transparent),
                16.height,
                if(wishModelList[currentWishIndex].wishComment.validate().isNotEmpty)
                  ReadMoreText(
                    parseHtmlString(wishModelList[currentWishIndex].wishComment.validateAndFilter().nonBreaking),
                    style: primaryTextStyle(color: context.cardColor, size: 12),
                    trimCollapsedText: "...Read more",
                    trimExpandedText: 'See more',
                    trimLines: 1,
                    colorClickableText: textPrimaryColorGlobal,
                    trimMode: TrimMode.Line,
                  ).paddingSymmetric(horizontal: 20),
                10.height,
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index){
                      setState((){
                        currentWishIndex = index;
                      });
                    },
                    children: wishModelList.map((wish)=>
                      SizedBox(
                           width: context.width(),
                           child: WhvWishItemHorizontalView(
                             wishModel: wish,
                             onWishPressed: () {  },
                           ),
                         )
                    ).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
