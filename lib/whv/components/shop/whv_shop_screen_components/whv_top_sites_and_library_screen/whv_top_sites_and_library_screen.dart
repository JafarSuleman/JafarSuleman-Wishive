import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import 'package:socialv/whv/models/whv_top_site_model.dart';

import 'package:socialv/whv/utils/whv_images.dart';

import '../whv_history_and_bookmarks_bottom_sheet/whv_history_and_bookmarks_bottom_sheet.dart';
import 'whv_top_site_item.dart';

class WhvTopSitesAndLibraryScreen extends StatelessWidget {
  const WhvTopSitesAndLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<WhvTopSiteModel> topSites = [
      WhvTopSiteModel(
        id: "",
        title: "Amazon US",
        color: 4278752636,
        url: "https://www.amazon.com/",
      ),
      WhvTopSiteModel(
        id: "",
        title: "Amazon Canada",
        color: 4290483952,
        url: "https://www.amazon.ca/",
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: ic_grid,
            title: whvLanguage.topSites,
          ),
          GridView.count(
            crossAxisCount: 4,
            padding: EdgeInsets.symmetric(vertical: 10),
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              topSites.length,
              (index) => WhvTopSiteItem(
                topSite: topSites[index],
              ),
            ),
          ),
          _sectionTitle(
            icon: ic_library,
            title: whvLanguage.yourLibrary,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _librarySectionItem(
                context: context,
                index: 0,
                icon: FontAwesomeIcons.star,
                title: whvLanguage.bookmarks,
              ),
              _librarySectionItem(
                context: context,
                index: 1,
                icon: Icons.history,
                color: Colors.amber,
                title: whvLanguage.history,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _librarySectionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
    Color? color,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          builder: (context) => WhvHistoryAndBookmarksBottomSheet(
            index: index, // 0 is for bookmarks and 1 is for history
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 45,
            ),
          ),
          SizedBox(height: 3),
          Text(
            title,
            style: primaryTextStyle(
              size: 12,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Row _sectionTitle({
    required String title,
    required String icon,
  }) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 18,
          width: 18,
        ),
        SizedBox(width: 7),
        Text(
          title,
          style: boldTextStyle(),
        ),
      ],
    );
  }
}
