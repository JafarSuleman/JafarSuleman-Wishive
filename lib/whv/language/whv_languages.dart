import 'package:flutter/material.dart';

abstract class WhvBaseLanguage {
  static WhvBaseLanguage? of(BuildContext context) =>
      Localizations.of<WhvBaseLanguage>(context, WhvBaseLanguage);

  String get wishlists;

  String get granted;

  String get searchOrEnterWebsite;

  String get searchTabs;

  String get tabs;

  String get closeAllTabs;

  String get okay;

  String get thisIsYourEmail;

  String get newTab;

  String get clearHistory;

  String get clearBookmarks;

  String get history;

  String get bookmarks;

  String get topSites;

  String get yourLibrary;

  String get viewHistoryAndBookmarks;

  String get bookmarkThisPage;

  String get close;

  String get addWishes;

  String get browseYourFavoriteStores;

  String get activity;

  String get saved;

  String get reserved;

  String get wellDone;

  String get oops;

  String get gotIt;

  String get addedToWishlistMessage;

  String get notOnProductPageMessage;

  String get search;

  String get almostThereFewDetails;

  String get greatNowSelectImageForThisItem;

  String get newWishlistName;

  String get addToWishlist;

  String get selectWishlist;

  String get commentHintText;

  String get back;

  String get quantity;

  String get wishlistPrivacy;

  String get selectWishlistPrivacy;

  String get dueDate;

  String get selectDueDate;

  String get friends;

  String get share;

  String get private;

  String get createNewWishlist;

  String get wishlistDueDateValidationMesg;

  String get pleaseSelectPrivacyForWishlist;

  String get pleaseEnterWishlistName;

  String get qtyValidationMesg;

  String get pleaseSelectAWishlist;

  String get pleaseSelectImage;

  String get commentIsRequired;

  String get wishes;

  String get newWishlistCreated;

  String get onWishive;

  String get liveMarketplace;

  String get searchHere;

  String get trending;

  String get setCalendar;
  String get setDate;
  String get calendar;

  String get upcoming;

  String get seeAll;

  String get myWishlists;
  String get upcomingWishlists;
  String get done;
  String get move;
  String get each;
  String get commentAboutThisWish;
  String get inStock;
  String get outOfStock;
  String get items;
  String get qty;
  String get views;
  String get noSpeechMessage;
  String get tryAgain;
  String get wishIsBeingAddedMessage;
  String get wishAddedSuccessMessage;
  String get wishlistCreateSuccessMessage;
  String get productImportFailureMessage1;
  String get productImportFailureMessage2;
  String get noticeForClickingTryAgain;
  String get checkYourInternetConnection;
  String get poorNetworkForHeadlessWebviewErrorMessage;
  String get productTitle;
  String get wishWizard;
  String get next;
  String get selectAnImage;
  String get addORMoveWish;
  String get newWishlist;
  String get newWishlistDescription;
  String get nameForThisWishlist;
  String get wishlistName;
  String get addWish;
  String get latest;
  String get customerRating;
  String get priceHighToLow;
  String get priceLowToHigh;
  String get enterANameForThisWishList;
  String get postACommentAboutThisWishlistOptional;
  String get scheduleEvent;
  String get whoIsInTheLoop;
  String get selectWhoCanViewAndWishesForThisWishlist;
  String get wishlistCanBeViewedByAllMyFriends;
  String get wishlistCanBeViewedByOnlyMe;
  String get youAreAllSet;
  String get newWishIsBeingAdded;
  String get dashboard;
  String get grantGift;
}
