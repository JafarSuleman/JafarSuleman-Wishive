// To parse this JSON data, do
//
//     final whvUserAgents = whvUserAgentsFromJson(jsonString);

import 'dart:convert';

WhvUserAgents whvUserAgentsFromJson(String str) =>
    WhvUserAgents.fromJson(json.decode(str));

String whvUserAgentsToJson(WhvUserAgents data) => json.encode(data.toJson());

class WhvUserAgents {
  List<String> userAgentsAppleIos;
  List<String> userAgentsAppleDesktop;
  List<String> userAgentsAndroidOs;
  List<String> userAgentsAndroidDesktop;

  WhvUserAgents({
    required this.userAgentsAppleIos,
    required this.userAgentsAppleDesktop,
    required this.userAgentsAndroidOs,
    required this.userAgentsAndroidDesktop,
  });

  factory WhvUserAgents.fromJson(Map<String, dynamic> json) => WhvUserAgents(
        userAgentsAppleIos:
            List<String>.from(json["user-agents-apple-ios"].map((x) => x)),
        userAgentsAppleDesktop:
            List<String>.from(json["user-agents-apple-desktop"].map((x) => x)),
        userAgentsAndroidOs:
            List<String>.from(json["user-agents-android-os"].map((x) => x)),
        userAgentsAndroidDesktop: List<String>.from(
            json["user-agents-android-desktop"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user-agents-apple-ios":
            List<dynamic>.from(userAgentsAppleIos.map((x) => x)),
        "user-agents-apple-desktop":
            List<dynamic>.from(userAgentsAppleDesktop.map((x) => x)),
        "user-agents-android-os":
            List<dynamic>.from(userAgentsAndroidOs.map((x) => x)),
        "user-agents-android-desktop":
            List<dynamic>.from(userAgentsAndroidDesktop.map((x) => x)),
      };
}
