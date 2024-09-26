import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/utils/colors.dart';

class WhvEditWishlistScreen extends StatelessWidget {
  WhvEditWishlistScreen({super.key});

  // Initial Selected Value
  String dropdown1value = 'Item 1';
  String dropdown2value = 'Item 1';

  // List of items in our dropdown menu
  var items1 = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var items2 = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.iconColor),
          onPressed: () {
            finish(context);
          },
        ),
        titleSpacing: 0,
        title: Text("Edit Wishlist", style: boldTextStyle(size: 22)),
        elevation: 0,
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.primaryColor.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    whvLanguage.done,
                    style: boldTextStyle(
                      size: 12,
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: radiusOnly(
            topLeft: defaultRadius,
            topRight: defaultRadius,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.list,
                    color: context.cardColor,
                    size: 50,
                  ),
                  Text(
                      // DateFormat('yyyy-MM-dd')
                      //     .format("2024-11-30")
                      //     .toString()
                      //     .validate()
                      //     .capitalizeFirstLetter(),
                      "2024-11-30",
                      style: primaryTextStyle(
                        size: 14,
                        color: context.cardColor,
                      )),
                  30.height,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people,
                        color: context.cardColor,
                      ),
                      10.width,
                      Text(
                        "Autumn Heat",
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: context.cardColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: appLayoutBackground,
                  borderRadius: radiusOnly(
                    topLeft: defaultRadius,
                    topRight: defaultRadius,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        StatefulBuilder(
                          builder: (context, setState) {
                            return _dropDown(
                              context,
                              selectedValue: dropdown1value,
                              items: items1,
                              onChanged: (value) {
                                setState(() {
                                  dropdown1value = value!;
                                });
                              },
                            );
                          },
                        ),
                        10.width,
                        StatefulBuilder(
                          builder: (context, setState) {
                            return _dropDown(
                              context,
                              selectedValue: dropdown2value,
                              items: items2,
                              onChanged: (value) {
                                setState(() {
                                  dropdown2value = value!;
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    20.height,
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        fillColor: context.cardColor,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton2<String> _dropDown(
    BuildContext context, {
    required List<String> items,
    required Function(String?) onChanged,
    required String selectedValue,
  }) {
    return DropdownButton2<String>(
      underline: SizedBox(),
      customButton: Container(
        width: 120,
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(0.14),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Icon(
              Icons.people,
              size: 16,
              color: context.primaryColor,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                selectedValue,
                style: boldTextStyle(
                  size: 12,
                  color: context.primaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: context.primaryColor,
            ),
          ],
        ),
      ),
      items: items
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: boldTextStyle(
                    size: 12,
                    color: context.primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: selectedValue,
      onChanged: onChanged,
      buttonStyleData: ButtonStyleData(
        height: 30,
        width: 120,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: context.primaryColor.withOpacity(0.14),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 20,
        iconEnabledColor: context.primaryColor,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );
  }
}
