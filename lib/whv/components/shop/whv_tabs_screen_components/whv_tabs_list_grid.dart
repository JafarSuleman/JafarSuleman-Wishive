import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';

import 'whv_tab_item.dart';

class WhvTabsListGrid extends StatefulWidget {
  const WhvTabsListGrid({
    super.key,
  });

  @override
  State<WhvTabsListGrid> createState() => _WhvTabsListGridState();
}

class _WhvTabsListGridState extends State<WhvTabsListGrid> {
  @override
  initState() {
    super.initState();
    tabsStore.getTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return tabsStore.isLoading
          ? SizedBox()
          : tabsStore.filteredTabs.isEmpty
              ? NoDataLottieWidget()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.6,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: tabsStore.filteredTabs.length,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) => WhvTabItem(
                    tab: tabsStore.filteredTabs[index],
                  ),
                );
    });
  }
}
