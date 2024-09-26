import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';
import '../../../whv-next/screens/wishlists/whv_wishlists_screen_widget.dart';
import '../../models/whv_dashboard_data_model.dart';

class WhvDashboardScreen extends StatefulWidget {
  const WhvDashboardScreen({
    super.key,
    required this.scrollController,
    required this.tabController,
    required this.onTabChanged,
  });
  final ScrollController scrollController;
  final TabController tabController;
  final Function(int) onTabChanged;

  @override
  State<WhvDashboardScreen> createState() => _WhvDashboardScreenState();
}

class _WhvDashboardScreenState extends State<WhvDashboardScreen> {
  WhvDashboardDataModel? dashboardData;

  bool isError = false;
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    _getDashboardData();

    LiveStream().on(WhvConstants.WhvOnDashboardData, (p0) {
      appStore.setLoading(true);
      dashboardData = null;

      setState(() {});
      _getDashboardData(showLoader: false);
    });
  }

  _getDashboardData({bool showLoader = true}) async {
    setState(() {
      isError = false;
      isLoading = true;
    });
    return await whvGetDashboardData(userId: appStore.loginUserId.toInt())
        .then((value) {
      setState(() {
        dashboardData = value;
        isLoading = false;
      });
    }).catchError((e) {
      isError = true;
      setState(() {
        isLoading = false;
      });
      toast(e.toString(), print: true);
    });
  }

  @override
  dispose() {
    LiveStream().dispose(WhvConstants.WhvOnDashboardData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return SizedBox(
          height: context.height() * 0.8,
          child: LoadingWidget(isBlurBackground: false).paddingSymmetric());

    if (isError || dashboardData == null)
      return SizedBox(
        height: context.height() * 0.8,
        child: NoDataWidget(
          imageWidget: NoDataLottieWidget(),
          title: isError ? language.somethingWentWrong : language.noDataFound,
          onRetry: () {
            _getDashboardData();
          },
          retryText: '   ${language.clickToRefresh}   ',
        ).center(),
      );
    return WishlistScreen();

    //   Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16),
    //   child: Column(
    //     children: [
    //       20.height,
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: Container(
    //               height: 120,
    //               margin: EdgeInsets.only(right: 5),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: context.primaryColor,
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               margin: EdgeInsets.only(left: 5),
    //               height: 120,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: context.primaryColor,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       _sectionTitle(
    //         context: context,
    //         title: whvLanguage.upcoming,
    //         onSeeAllPressed: () {
    //           WhvUpcomingWishlistScreen().launch(context);
    //         },
    //       ),
    //       dashboardData != null && dashboardData?.upcomingWishlists != []
    //           ? WhvUpcomingWishes(
    //               upcomingWishes: dashboardData?.upcomingWishlists ?? [],
    //             )
    //           : Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 20),
    //               child: Text("No Upcoming Wishlists Available now..."),
    //             ),
    //       _sectionTitle(
    //         context: context,
    //         title: whvLanguage.myWishlists,
    //         onSeeAllPressed: () {
    //           WhvWishlistScreen().launch(context);
    //         },
    //       ),
    //       dashboardData != null && dashboardData?.myWishlists != []
    //           ? Align(
    //               alignment: Alignment.centerLeft,
    //               child: WhvMyWishlists(
    //                 myWishes: dashboardData?.myWishlists ?? [],
    //               ),
    //             )
    //           : Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 20),
    //               child: Text("No Wishlists Available now..."),
    //             ),
    //       _sectionTitle(
    //         context: context,
    //         title: language.latestActivities,
    //         onSeeAllPressed: () {
    //           widget.tabController.animateTo(2);
    //           widget.onTabChanged(2);
    //         },
    //       ),
    //       WhvLatestActivities(
    //         latestActivities: dashboardData?.latestActivities ?? [],
    //       ),
    //     ],
    //   ),
    // );
  }

  Row _sectionTitle({
    required BuildContext context,
    required String title,
    required VoidCallback onSeeAllPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.leagueSpartan(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.iconColor,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text(
            whvLanguage.seeAll.toUpperCase(),
            style: GoogleFonts.leagueSpartan(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
