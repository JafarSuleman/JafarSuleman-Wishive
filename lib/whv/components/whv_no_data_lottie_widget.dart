import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_constants.dart';

class WhvNoDataLottieWidget extends StatelessWidget {
  const WhvNoDataLottieWidget({
    this.repeat = true,
    Key? key,
  }) : super(key: key);

  final bool repeat;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      no_data,
      repeat: repeat,
      height: 130,
    );
  }
}

class WhvEmptyPostLottieWidget extends StatelessWidget {
  const WhvEmptyPostLottieWidget({this.repeat = true, Key? key})
      : super(key: key);

  final bool repeat;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(add_post, height: 100, repeat: repeat);
  }
}
