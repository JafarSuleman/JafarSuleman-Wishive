import 'dart:io';
import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:socialv/whv/network/whv_rest_apis.dart';

import '../models/whv_user_agents.dart';

part 'whv_app_store.g.dart';

class WhvAppStore = _WhvAppStoreBase with _$WhvAppStore;

abstract class _WhvAppStoreBase with Store {
  @observable
  bool isTrendingSubTabViewScrolled = false;

  List<dynamic> productKeywords = [];

  String userAgent = "";

  String userDesktopAgent = "";

  WhvUserAgents? userAgents;

  @action
  toggleTrendingSubTabViewScrolled(bool newValue) {
    isTrendingSubTabViewScrolled = newValue;
  }

  @action
  getAndSetProductKeywords() async {
    var data = await whvGetProductKeywords();

    productKeywords = List.from(data['keywords']);
  }

  @action
  getAndSetUserAgents() async {
    var data = await whvGetUserAgents();
    userAgents = data;
    var platform = Platform.operatingSystem;

    switch (platform) {
      case "ios":
        int randomIndex = Random().nextInt(data.userAgentsAppleIos.length);
        userAgent = data.userAgentsAppleIos[randomIndex];

        int randomIndexForDesktopAgents =
            Random().nextInt(data.userAgentsAppleDesktop.length);
        userDesktopAgent =
            data.userAgentsAppleDesktop[randomIndexForDesktopAgents];
        break;
      case "android":
        int randomIndex = Random().nextInt(data.userAgentsAndroidOs.length);
        userAgent = data.userAgentsAndroidOs[randomIndex];

        int randomIndexForDesktopAgents =
            Random().nextInt(data.userAgentsAndroidDesktop.length);
        userDesktopAgent =
            data.userAgentsAndroidDesktop[randomIndexForDesktopAgents];
        break;
      case "macos":
        int randomIndex = Random().nextInt(data.userAgentsAppleDesktop.length);
        userAgent = data.userAgentsAppleDesktop[randomIndex];

        userDesktopAgent = data.userAgentsAppleDesktop[randomIndex];

        break;
      case "windows":
        int randomIndex =
            Random().nextInt(data.userAgentsAndroidDesktop.length);
        userAgent = data.userAgentsAndroidDesktop[randomIndex];

        userDesktopAgent = data.userAgentsAndroidDesktop[randomIndex];
        break;

      default:
        int randomIndex = Random().nextInt(data.userAgentsAndroidOs.length);
        userAgent = data.userAgentsAndroidOs[randomIndex];
    }

    print("userDesktopAgent: $userDesktopAgent");
  }
}
