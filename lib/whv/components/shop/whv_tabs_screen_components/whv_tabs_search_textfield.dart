import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

class WhvTabsSearchTextField extends StatelessWidget {
  WhvTabsSearchTextField({
    super.key,
  });

  final TextEditingController _searchTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          controller: _searchTextFieldController,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: whvLanguage.searchTabs,
            fillColor: context.dividerColor,
            filled: true,
            prefixIcon: InkWell(
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: context.iconColor,
                size: 18,
              ),
              onTap: () {
                tabsStore
                    .searchTab(_searchTextFieldController.text.toLowerCase());
              },
            ),
            contentPadding: EdgeInsets.only(top: 2),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          onChanged: (value) {
            tabsStore.searchTab(value.toLowerCase());
          },
          onSubmitted: (value) {
            tabsStore.searchTab(value.toLowerCase());
          },
        ),
      ),
    );
  }
}
