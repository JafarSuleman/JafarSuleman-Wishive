import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:socialv/whv/constants/whv_new_wishlist_constants.dart';

part 'whv_add_to_wishlist_store.g.dart';

class WhvAddToWishlistStore = _WhvAddToWishlistStoreBase
    with _$WhvAddToWishlistStore;

abstract class _WhvAddToWishlistStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isCreatingNewWishlist = false;

  @observable
  bool isScheduleWishlist = true;

  @observable
  String userSelectedImageUrl = '';

  @observable
  String? prodpgURL;

  @observable
  int quantityCount = 1;
  // String? userID;
  // String? imgvarURL;
  @observable
  TextEditingController quantity = TextEditingController(text: "1");

  @observable
  TextEditingController wishComment = TextEditingController();

  @observable
  TextEditingController wishlistComment = TextEditingController();
  @observable
  String? wishlistId;
  @observable
  TextEditingController wishlistName = TextEditingController();
  @observable
  String wishlistPrivacy = WhvConstants.WhvShare;
  // String wishlistPrivacy = WhvNewWishlistConstants.whvFriends;

  @observable
  String? whvDueDate;

  @observable
  String? exitsWishlistName;

  @observable
  String? productTitle;

  @observable
  DateTime selectedDate = DateTime.now();

  @action
  setSelectedWishlistData({
    required String selectedWishlistId,
    required String selectedWishlistName,
  }) {
    wishlistId = selectedWishlistId;
    exitsWishlistName = selectedWishlistName;
  }

  @action
  selectDate(BuildContext context) async {
    int newYear = 1;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate:
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      lastDate: DateTime(selectedDate.year + newYear, 12, 31),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            // Customize the date picker dialog here
            // For example, you can set the background color and text color
            scaffoldBackgroundColor: Colors.black,
            primaryColor: Colors.white,
            colorScheme: ColorScheme.dark(
              onPrimary: Colors.black, // selected text color
              onSurface: Colors.white, // default text color
              primary: Colors.white,
              // circle color
            ),

            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white),
            ),
            // colorScheme:
            //     ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
          ),
          child: child ?? SizedBox(),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setSelectedDate(picked);
    }
  }

  @action
  setSelectedDate(DateTime date) {
    selectedDate = date;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    whvDueDate = formatter.format(selectedDate);
  }

  @action
  setProductUrl(String url) {
    print('selected date');
    prodpgURL = url;
  }

  @action
  setProductTitle(String title) {
    print('selected date');
    productTitle = title;
  }

  setLoader(bool value) {
    isLoading = value;
  }

  setWishlistName(String name) {
    exitsWishlistName = name;
  }

  incrementQuantity() {
    quantityCount += 1;
  }

  decrementQuantity() {
    if (quantityCount > 1) {
      quantityCount -= 1;
    }
  }

  resetAllFields({
    bool shouldResetIsCreatingNewWishlist = true,
    bool shouldResetUserSelectedImageUrl = true,
    bool shouldResetProductUrl = true,
  }) {
    if (shouldResetIsCreatingNewWishlist == true) {
      isCreatingNewWishlist = false;
    }

    if (shouldResetUserSelectedImageUrl == true) {
      userSelectedImageUrl = '';
    }

    if (shouldResetProductUrl) {
      prodpgURL = null;
    }
    quantityCount = 1;
    wishComment.clear();
    wishlistComment.clear();
    wishlistId = null;
    whvDueDate = null;
    wishlistName.clear();
    isScheduleWishlist = true;
    wishlistPrivacy = WhvConstants.WhvShare;
    exitsWishlistName = null;
    selectedDate = DateTime.now();
  }

  // @observable
  // AddProductToWishlistModel addProductToWishlistModel =
  //     AddProductToWishlistModel();
}
