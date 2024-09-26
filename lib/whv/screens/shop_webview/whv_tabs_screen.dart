import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/shop/whv_tabs_screen_components/whv_tabs_list_grid.dart';
import 'package:socialv/whv/components/shop/whv_tabs_screen_components/whv_tabs_search_textfield.dart';
import 'package:socialv/whv/models/whv_tab_model.dart';

class WhvTabsScreen extends StatelessWidget {
  const WhvTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            // bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: WhvTabsSearchTextField()),
                  PopupMenuButton(
                    onSelected: (value) async {
                      // when the user clears all the tabs list we navigate
                      // the user to the shop default home screen.

                      await tabsStore.clearTabs();
                      tabsStore.removeCurrentOpenedTab();
                      webviewStore.resetValues();

                      context.pop();
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text(whvLanguage.closeAllTabs),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(child: WhvTabsListGrid()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: context.cardColor,
          boxShadow: [
            BoxShadow(
              color: context.dividerColor.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);

                webviewStore.resetValues();

                if (webviewStore.webViewController != null) {
                  webviewStore.webViewController?.stopLoading();
                }

                tabsStore.addTab(
                  WhvTabModel(
                    id: -1,
                    title: "",
                    url: "",
                    preview: null,
                  ),
                );
              },
              icon: Icon(
                Icons.add,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(language.done),
            ),
          ],
        ),
      ),
    );
  }
}
