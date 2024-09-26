import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';

import '../../../screens/wishlists/whv_wishlists_screen_widget.dart';

class WishlistsScreenModel extends FlutterFlowModel<WishlistScreen> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
