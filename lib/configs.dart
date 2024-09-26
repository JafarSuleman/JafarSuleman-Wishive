import 'package:country_picker/country_picker.dart';

/// App Name
const APP_NAME = "Wishive";

/// App Icon src
const APP_ICON = "assets/app_icon.png";

/// Splash screen image src
const SPLASH_SCREEN_IMAGE = 'assets/images/splash_image.png';

/// NOTE: Do not add slash (/) or (https://) or (http://) at the end of your domain.
const WEB_SOCKET_DOMAIN = 'app23ndp01nt.wishive.com';

/// NOTE: Do not add slash (/) at the end of your domain.
const DOMAIN_URL = 'https://app23ndp01nt.wishive.com';
const BASE_URL = '$DOMAIN_URL/wp-json/';

/// AppStore Url
const IOS_APP_LINK = '';

/// Terms and Conditions URL
const TERMS_AND_CONDITIONS_URL = '$DOMAIN_URL/terms-condition/';

/// Privacy Policy URL
const PRIVACY_POLICY_URL = '$DOMAIN_URL/privacy-policy-2/';

/// Support URL
const SUPPORT_URL = 'https://support.wishive.com';

/// AdMod Id
// Android
const mAdMobAppId = 'ca-app-pub-7841661223064824~2380242717';
const mAdMobBannerId = 'ca-app-pub-7841661223064824/4825678319';

// iOS
const mAdMobAppIdIOS = 'ca-app-pub-7841661223064824~5656007279';
const mAdMobBannerIdIOS = 'ca-app-pub-7841661223064824/1648850639';

const mTestAdMobBannerId = 'ca-app-pub-3940256099942544/6300978111';

/// Woo Commerce keys

// live
const CONSUMER_KEY = 'ck_f8424f77b84952057d329fc4aa4d5f6ec64fbe0e';
const CONSUMER_SECRET = 'cs_1e61b078ea3cae8036fd5577ec22cd54e1646006';

/// STRIPE PAYMENT DETAIL
const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';
const STRIPE_CURRENCY_CODE = 'INR';

/// RAZORPAY PAYMENT DETAIL
const RAZORPAY_CURRENCY_CODE = 'INR';

/// AGORA
const AGORA_APP_ID = '';

Country defaultCountry() {
  return Country(
    phoneCode: '+1',
    countryCode: 'CA',
    e164Sc: 1,
    geographic: true,
    level: 1,
    name: 'Canada',
    example: '5147589773',
    displayName: 'Canada (CA) [+1]',
    displayNameNoCountryCode: 'Canada (CA)',
    e164Key: '1-CA-0',
    fullExampleWithPlusSign: '+15147589773',
  );
}
