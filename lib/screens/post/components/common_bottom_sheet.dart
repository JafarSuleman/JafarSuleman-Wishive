import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
BuildContext ?bottomSheetContext;
Future openGeneralBottomSheet({required BuildContext context, required Widget widgetToShow,})async{
  await showModalBottomSheet(
    elevation: 0,
    context: bottomSheetContext!,
    useRootNavigator: true,
    isScrollControlled: true,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (cntxt) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 5,
              //clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
            ),
            8.height,
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: cntxt.cardColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: widgetToShow,
            ).expand(),
          ],
        ),
      );
    },
  );

}