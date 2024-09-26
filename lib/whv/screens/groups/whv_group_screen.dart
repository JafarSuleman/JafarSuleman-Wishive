import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/components/no_data_lottie_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/models/groups/group_model.dart';
import 'package:socialv/network/rest_apis.dart';
import 'package:socialv/screens/groups/components/initial_no_group_component.dart';
import 'package:socialv/screens/groups/screens/create_group_screen.dart';

import 'package:socialv/utils/app_constants.dart';
import 'package:socialv/whv/components/groups/whv_groups_list.dart';
import 'package:socialv/whv/screens/search/whv_search_fragment.dart';

class WhvGroupScreen extends StatefulWidget {
  final int? userId;

  const WhvGroupScreen({this.userId});

  @override
  State<WhvGroupScreen> createState() => _WhvGroupScreenState();
}

class _WhvGroupScreenState extends State<WhvGroupScreen> {
  List<GroupModel> groupList = [];
  late Future<List<GroupModel>> future;

  int mPage = 1;
  bool mIsLastPage = false;

  bool isChange = false;
  bool isError = false;

  @override
  void initState() {
    future = getGroups();
    super.initState();
  }

  Future<List<GroupModel>> getGroups() async {
    appStore.setLoading(true);

    await getGroupList(
            userId: widget.userId,
            groupType: GroupRequestType.myGroup,
            page: mPage)
        .then((value) {
      if (mPage == 1) groupList.clear();
      mIsLastPage = value.length != PER_PAGE;
      groupList.addAll(value);
      setState(() {});

      appStore.setLoading(false);
    }).catchError((e) {
      isError = true;
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });

    return groupList;
  }

  Future<void> onRefresh() async {
    isError = false;
    mPage = 1;
    future = getGroups();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    if (appStore.isLoading) appStore.setLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        appStore.setLoading(false);
        finish(context, isChange);
        return Future.value(true);
      },
      child: RefreshIndicator(
        onRefresh: () async {
          onRefresh();
        },
        color: appColorPrimary,
        child: Scaffold(
          appBar: AppBar(
            title: Text(language.groups, style: boldTextStyle(size: 20)),
            elevation: 0,
            centerTitle: true,
            actions: [
              if (widget.userId == null)
                IconButton(
                  onPressed: () {
                    CreateGroupScreen().launch(context).then((value) {
                      if (value) {
                        isChange = value;
                        mPage = 1;
                        future = getGroups();
                      }
                    });
                  },
                  icon: Image.asset(
                    ic_plus,
                    color: appColorPrimary,
                    height: 22,
                    width: 22,
                    fit: BoxFit.cover,
                  ),
                ),
              IconButton(
                onPressed: () {
                  WhvSearchFragment(
                    isFromGroupsPage: true,
                  ).launch(context);
                },
                icon: Image.asset(
                  ic_search,
                  color: context.iconColor,
                  height: 22,
                  width: 22,
                  fit: BoxFit.fill,
                ).paddingRight(10),
              ),
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: context.iconColor),
              onPressed: () {
                finish(context, isChange);
              },
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              FutureBuilder<List<GroupModel>>(
                future: future,
                builder: (ctx, snap) {
                  if (snap.hasError) {
                    return NoDataWidget(
                      imageWidget: NoDataLottieWidget(),
                      title: isError
                          ? language.somethingWentWrong
                          : language.noDataFound,
                      onRetry: () {
                        onRefresh();
                      },
                      retryText: '   ${language.clickToRefresh}   ',
                    ).center();
                  }

                  if (snap.hasData) {
                    if (snap.data.validate().isEmpty) {
                      return InitialNoGroupComponent(callback: onRefresh)
                          .center();
                    } else {
                      return WhvGroupsList(
                          groupList: groupList,
                          resetPages: (bool value) {
                            isChange = true;
                            mPage = 1;
                            future = getGroups();
                          },
                          onNextPage: () {
                            if (!mIsLastPage) {
                              mPage++;
                              future = getGroups();
                            }
                          });
                    }
                  }
                  return Offstage();
                },
              ),
              Observer(
                builder: (_) {
                  if (appStore.isLoading) {
                    return Positioned(
                      bottom: mPage != 1 ? 10 : null,
                      child: LoadingWidget(
                          isBlurBackground: mPage == 1 ? true : false),
                    );
                  } else {
                    return Offstage();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
