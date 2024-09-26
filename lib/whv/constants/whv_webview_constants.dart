import 'package:socialv/whv/utils/whv_images.dart';

class WhvWebviewConstants {
  static const gooleSearchURL = "https://www.google.com/search?q=";

  static const amazon = "Amazon";
  static const amazonUrl = "https://www.amazon.com/live";
  static const walmart = "Walmart";
  static const walmartUrl = "https://www.walmartshoplive.com/";

  static const target = "Target";
  static const targetUrl = "https://www.target.com/live";

  static const channels = [
    {
      "title": amazon,
      "icon": amazon_icon,
      "url": amazonUrl,
    },
    {
      "title": walmart,
      "icon": walmart_icon,
      "url": walmartUrl,
    },
    {
      "title": target,
      "icon": target_icon,
      "url": target,
    }
  ];

  static const amazonHeader = "header";
  static const amazonNavFooter = "nav-ftr";

  static const amazonHeaderTagNames = [amazonHeader];
  static const amazonFooterElementIds = [amazonNavFooter];

  // This class Names are used to remove headers etc
  static const amazonClassNames = [
    "logo-module__pageHeader_1r2_sHv3bvJlA3oKCSs-j2",
    "sticky-search-header-module__left_1jQ9jdkt5eyZ-A7n6vYLLK", // For the Amazon Live Logo
    "sticky-search-header-module__right_1hJlkLxVUeXnwEYlb4M-7v", // FOR Search Texfield
  ];

  static const walmartClassNames = [
    "nav",
    "padding--right padding--small w-inline-block w--current",
  ];
  static const walmartTagNames = ["footer"];

  static const targetElementIds = ["@web/component-header"];
  static const targetClassNames = [
    "styles__GlobalHeaderStyled-sc-v5rto6-0 jbhzwo",
  ];
  static const targetOtherElementClassNames = [
    "l-container-fixed h-display-flex h-flex-justify-center h-padding-v-jumbo h-padding-h-default ",
    "l-container h-bg-grayDarkest",
    "styles__Container-sc-spydln-0 iiavpO",
    "styles__PrimaryLinksMobileContainer-sc-vbvkc1-4 bXhPqm",
    "styles__IllustrationWrapper-sc-vbvkc1-6 eTFvoi",
  ];

  static const headlessWebviewNetworkErrorKey = "ERR_NETWORK_CHANGED";
}
