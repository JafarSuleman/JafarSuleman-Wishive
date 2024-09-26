import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late double _progressValue;
  @override
  void initState() {
    super.initState();
    _progressValue = 0.4;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.primaryColor.withOpacity(0.7),
            ),
          ),
          child: LinearProgressIndicator(
            minHeight: 9,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: context.cardColor,
            valueColor: new AlwaysStoppedAnimation<Color>(
                context.primaryColor.withOpacity(0.4)),
            value: _progressValue,
          ),
        ),
        5.width,
        Text(
          '${(_progressValue * 100).round()}%',
          style: TextStyle(
              color: context.iconColor.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
