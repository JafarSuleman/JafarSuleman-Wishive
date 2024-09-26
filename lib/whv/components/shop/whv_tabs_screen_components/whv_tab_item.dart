import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/models/whv_tab_model.dart';

import '../../whv_no_data_lottie_widget.dart';

class WhvTabItem extends StatefulWidget {
  const WhvTabItem({
    super.key,
    required this.tab,
  });

  final WhvTabModel tab;

  @override
  State<WhvTabItem> createState() => _WhvTabItemState();
}

class _WhvTabItemState extends State<WhvTabItem> {
  // opens a tab
  _openTab(BuildContext context) {
    Navigator.pop(context);
    if (tabsStore.currentOpenedTab?.id != widget.tab.id) {
      webviewStore.updateUrl(widget.tab.url);
      webviewStore.toggleHasSearched(false);
      webviewStore.toggleIsProductDetailsPage(false);

      webviewStore.updateSearchTextFieldValue(widget.tab.url);

      tabsStore.updateCurrentOpenedTab(widget.tab);
      if (widget.tab.url.isEmptyOrNull) {
        webviewStore.toggleShowWebView(false);
      } else {
        webviewStore.loadUrl(
          newUrl: widget.tab.url,
        );
      }
    }
  }

  // delete a tab
  _deleteTab() {
    // if the deleting tab is the current opened tab then reset the current opened tab.
    if (tabsStore.currentOpenedTab?.id == widget.tab.id) {
      tabsStore.updateCurrentOpenedTab(WhvTabModel(
        id: -1,
        title: "",
        url: "",
        preview: null,
      ));

      webviewStore.resetValues();
    }

    // if the remaining tabs in list is only one tab then navigate the user to
    // the defualt home screen.
    if (tabsStore.tabs.length == 1) {
      webviewStore.resetValues();
      context.pop();
    }
    tabsStore.deleteTab(widget.tab.id);
  }

  @override
  Widget build(BuildContext context) {
    // if the url in the tab item is empty or null then it means that its an empty tab.
    var isDummyTab = widget.tab.url.isEmptyOrNull;
    return Dismissible(
      key: ValueKey(widget.tab.id),
      onDismissed: (direction) {
        _deleteTab();
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.dividerColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 5,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    isDummyTab ? whvLanguage.newTab : widget.tab.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: _deleteTab,
                    child: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isDummyTab
                  ? InkWell(
                      onTap: () => _openTab(context),
                      child: dummyTabWidget(),
                    )
                  : widget.tab.preview != null
                      ? InkWell(
                          onTap: () => _openTab(context),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              widget.tab.preview!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : AnyLinkPreview(
                          link: widget.tab.url,
                          displayDirection: UIDirection.uiDirectionVertical,
                          showMultimedia: true,

                          bodyMaxLines: 5,
                          bodyTextOverflow: TextOverflow.ellipsis,
                          titleStyle: boldTextStyle(),
                          bodyStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          errorBody: '',
                          errorTitle: '',
                          errorWidget: Container(
                            color: Colors.grey[300],
                            child: Text('Oops!'),
                          ),
                          errorImage: "https://google.com/",
                          cache: Duration(days: 7),
                          backgroundColor: context.cardColor.withOpacity(0.7),
                          borderRadius: 12,
                          removeElevation: true,

                          // boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                          onTap: () => _openTab(context),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dummyTabWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: WhvNoDataLottieWidget(
        repeat: false,
      ),
    );
  }
}
