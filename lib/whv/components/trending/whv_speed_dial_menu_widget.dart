import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/whv/components/trending/whv_add_wish_custome_floating_btn.dart';
import 'package:socialv/whv/components/trending/whv_speed_dial_child.dart';

import 'package:socialv/whv/utils/whv_images.dart';

class WhvSpeedDialMenuWidget extends StatefulWidget {
  final Function()? onTapAddWish;
  const WhvSpeedDialMenuWidget({Key? key, this.onTapAddWish}) : super(key: key);
  @override
  _WhvSpeedDialMenuWidgetState createState() => _WhvSpeedDialMenuWidgetState();
}

class _WhvSpeedDialMenuWidgetState extends State<WhvSpeedDialMenuWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSpeedDial() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isOpen)
          Scaffold(
            body: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 218, 216, 216).withOpacity(0.5),
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_isOpen) ...[
                FadeTransition(
                  opacity: _animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      WhvSpeedDialChild(
                        backgroundColor: Colors.green,
                        label: 'Add to Wish',
                        icon: Icon(Icons.add),
                        mini: true,
                      ),
                      SizedBox(height: 16),
                      WhvSpeedDialChild(
                        backgroundColor: Colors.green,
                        label: 'Add to Wish',
                        icon: Icon(Icons.add),
                        mini: true,
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 16),
              _isOpen
                  ? WhvSpeedDialChild(
                      backgroundColor: context.primaryColor,
                      label: 'Add Wish',
                      icon: SvgPicture.asset(ic_heart_add),
                      onTap: _toggleSpeedDial,
                    )
                  : WhvAddWishCustomeFloatingBtn(
                      onTapAddWish: widget.onTapAddWish,
                      onTap: () {
                        _toggleSpeedDial();
                      },
                    ),
            ],
          ).paddingOnly(left: 20, right: 20, bottom: 24),
        ),
      ],
    );
  }
}
