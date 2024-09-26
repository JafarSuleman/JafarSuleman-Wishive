import 'package:flutter/material.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/components/shoppable_live/whv_live_shoppable_channels.dart';
import 'package:socialv/whv/components/shoppable_live/whv_live_shoppable_webview.dart';

class WhvLiveShoppableScreen extends StatefulWidget {
  const WhvLiveShoppableScreen({
    super.key,
    required this.controller,
  });
  final ScrollController controller;

  @override
  State<WhvLiveShoppableScreen> createState() => _WhvLiveShoppableScreenState();
}

class _WhvLiveShoppableScreenState extends State<WhvLiveShoppableScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  initState() {
    liveShoppableStore
        .updateCurrentUrl(liveShoppableStore.channels.first['url'].toString());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WhvLiveShoppableChannels(),
        Expanded(
          child: WhvLiveShoppableWebView(
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}
