import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/whv/language/whv_language_de.dart';
import 'package:socialv/whv/language/whv_language_es.dart';
import 'package:socialv/whv/language/whv_language_ar.dart';
import 'package:socialv/whv/language/whv_language_en.dart';
import 'package:socialv/whv/language/whv_language_fr.dart';
import 'package:socialv/whv/language/whv_language_hi.dart';
import 'package:socialv/whv/language/whv_language_pt.dart';
import 'package:socialv/whv/language/whv_languages.dart';

class WhvAppLocalizations extends LocalizationsDelegate<WhvBaseLanguage> {
  const WhvAppLocalizations();

  @override
  Future<WhvBaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return WhvLanguageEn();
      // case 'ar':
      //   return WhvLanguageAr();
      // case 'hi':
      //   return WhvLanguageHi();
      // case 'fr':
      //   return WhvLanguageFr();
      // case 'es':
      //   return WhvLanguageEs();
      // case 'de':
      //   return WhvLanguageDe();
      // case 'pt':
      //   return WhvLanguagePt();
      default:
        return WhvLanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<WhvBaseLanguage> old) => false;
}
