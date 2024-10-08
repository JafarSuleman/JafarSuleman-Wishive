import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialv/whv/utils/whv_images.dart';

///
///  create by zmtzawqlp on 2019/5/27
///
num degToRad(num deg) => deg * (math.pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / math.pi);

double mapValueFromRangeToRange(double value, double fromLow, double fromHigh,
    double toLow, double toHigh) {
  return toLow + ((value - fromLow) / (fromHigh - fromLow) * (toHigh - toLow));
}

double clamp(double value, double low, double high) {
  return math.min(math.max(value, low), high);
}

Widget defaultWidgetBuilder(bool isLiked, double size) {
  return SvgPicture.asset(
    ic_heart_add,
    height: 30,
  );
}
