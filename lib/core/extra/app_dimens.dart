import 'package:get/get.dart';

/**
 * Date: 6 Nov 2022
 * Title: AppDimens class
 * Description: This class will hold all kind of dimension (size)
 * Developer: Md. Rasel Khan
 * Position: Sr. Mobile Application Developer
 * Start Date: Today
 * End Date: Today
 */

class AppDimens {
  ///------------------------------------------------------------
  /// -- @ only use for text size
  /// -- variable name start with t for understand textsizes
  static double tH1 = Get.width > 400 ? 36 : 32;
  static double tH2 = 28;
  static double tH3 = 24;
  static double tH4 = 22;
  static double tH5 = 20;
  static double tLarge = 18;
  static double tNormal = 16;
  static double tSmall = 14;
  static double tExtraSmall = 12;
  static double tTiny = 10;
  static double tExtraTiny = 8;
  static double padding24 = 24;
  static double padding16 = 16;
  static double padding32 = 32;
  static double padding38 = 38;

  ///---------------------------------------------------------
  /// -- @ only use for radius
  /// -- variable name start with r for understand radius
  static double rNormal = 12;
  static double rLarge = 24;
  static double rTiny = 6;
  static double rFull = 100;

  ///---------------------------------------------------------
  /// -- @ only use for container input height
  static double fHeight = 55;
  static double fHeightLarge = 72;
  static double fHeightSmall = 45;
  // static double btnHeightNormal =

  ///---------------------------------------------------------
  /// -- @ status
  static int success = 2;
  static int success2 = 3;
  static int pending = 1;
  static int rejected = 4;
  static int failed = 5;

  ///---------------------------------------------------------
  /// -- @ spaces vertical
  static double spaceSmall = 6;
  static double spaceMedium = 12;
  static double spaceLarge = 24;
  static double spaceExtraLarge = 36;
  static double spaceGaint = 48;

  ///---------------------------------------------------------
  /// -- @ padding
  static double paddingSmall = 4;
  static double paddingMedium = 8;
  static double paddingLarge = 12;
  static double paddingExtraLarge = 24;
  static double paddingGaint = 36;
  static double paddingExtraGaint = 48;

  ///---------------------------------------------------------
  ///-- @ margin
  static double marginSmall = 8;
  static double marginMedium = 12;
  static double marginBody = 24;
  static double marginlarge = 16;
  static double marginExtraLarge = 20;
  static double marginGaint = 24;

  ///---------------
  /// -- @ button height

  static double btnHeightSmall = 43;

  static Duration debounceTime = Duration(milliseconds: 750);
  static Duration snackbarDuration = Duration(seconds: 4);
  static double btnIconWidth = 30;
  static double bodyPadding = 24;
  static double breatingSpace = 20;
  static double headerGap = 12;

  static double alertRadius = 5;
}
