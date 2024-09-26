import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:nb_utils/nb_utils.dart';

import 'package:socialv/main.dart';

class WhvOnWishiveSearchTextField extends StatefulWidget {
  const WhvOnWishiveSearchTextField({
    super.key,
  });

  @override
  State<WhvOnWishiveSearchTextField> createState() =>
      _WhvOnWishiveSearchTextFieldState();
}

class _WhvOnWishiveSearchTextFieldState
    extends State<WhvOnWishiveSearchTextField> {
  final _searchTextFieldFocusNode = FocusNode();

  final TextEditingController searchController = TextEditingController();

  @override
  dispose() {
    _searchTextFieldFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: context.dividerColor.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          InkWell(
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: context.iconColor,
                size: 18,
              ),
              onTap: () {}),
          Expanded(
            child: TextField(
              controller: searchController,
              focusNode: _searchTextFieldFocusNode,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: whvLanguage.searchHere,
                hintStyle: secondaryTextStyle(size: 11),
                contentPadding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 10,
                  bottom: 10,
                ),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              onSubmitted: (value) async {},
              onChanged: (value) {},
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
