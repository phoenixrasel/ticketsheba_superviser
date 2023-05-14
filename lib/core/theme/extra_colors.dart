import 'package:flutter/material.dart';

class ExtraColors {
  ///-------------------
  /// -- primary colorset
  static Color PRIMARY_100 = Color(0xffFEF1CB);
  static Color PRIMARY_200 = Color(0xffFEDF98);
  static Color PRIMARY_300 = Color(0xffFCC764);
  static Color PRIMARY_400 = Color(0xffF9B03E);
  static Color PRIMARY_500 = Color(0xffF58B00);
  static Color PRIMARY_600 = Color(0xffD26E00);
  static Color PRIMARY_700 = Color(0xffB05400);
  static Color PRIMARY_800 = Color(0xff8E3D00);
  static Color PRIMARY_900 = Color(0xff752E00);

  ///-----------------------
  /// -- @ success
  static Color SUCCESS_100 = Color(0xffCFFED5);
  static Color SUCCESS_200 = Color(0xffA0FDB4);
  static Color SUCCESS_300 = Color(0xff71F99B);
  static Color SUCCESS_400 = Color(0xff4DF492);
  static Color SUCCESS_500 = Color(0xff15ED84);
  static Color SUCCESS_600 = Color(0xff0FCB83);
  static Color SUCCESS_700 = Color(0xff0AAA7C);
  static Color SUCCESS_800 = Color(0xff068971);
  static Color SUCCESS_900 = Color(0xff047168);

  ///-----------------------
  /// -- @ info
  static Color INFO_100 = Color(0xffD3F9FE);
  static Color INFO_200 = Color(0xffA7EEFD);
  static Color INFO_300 = Color(0xff7ADCFB);
  static Color INFO_400 = Color(0xff59C8F8);
  static Color INFO_500 = Color(0xff24A8F4);
  static Color INFO_600 = Color(0xff1A83D1);
  static Color INFO_700 = Color(0xff1262AF);
  static Color INFO_800 = Color(0xff0B458D);
  static Color INFO_900 = Color(0xff063175);

  ///-----------------------
  /// -- @ Warning
  static Color WARNING_100 = Color(0xffFDFDD7);
  static Color WARNING_200 = Color(0xffFCFCAF);
  static Color WARNING_300 = Color(0xffF8F787);
  static Color WARNING_400 = Color(0xffF2F068);
  static Color WARNING_500 = Color(0xffEAE738);
  static Color WARNING_600 = Color(0xffC9C628);
  static Color WARNING_700 = Color(0xffA8A51C);
  static Color WARNING_800 = Color(0xff878511);
  static Color WARNING_900 = Color(0xff706D0A);

  ///------------------------
  /// -- @ danger
  static Color DANGER_100 = Color(0xffFFEBD6);
  static Color DANGER_200 = Color(0xffFFD2AD);
  static Color DANGER_300 = Color(0xffFFB483);
  static Color DANGER_400 = Color(0xffFF9665);
  static Color DANGER_500 = Color(0xffFF6532);
  static Color DANGER_600 = Color(0xffDB4524);
  static Color DANGER_700 = Color(0xffB72A19);
  static Color DANGER_800 = Color(0xff93140F);
  static Color DANGER_900 = Color(0xff7A090D);

  ///------------------------
  /// -- @ Black
  static Color BLACK_100 = Color(0xffF5F4F5);
  static Color BLACK_200 = Color(0xffEBE9EC);
  static Color BLACK_300 = Color(0xffC4C2C6);
  static Color BLACK_400 = Color(0xff8C8A8D);
  static Color BLACK_500 = Color(0xff414042);
  static Color BLACK_600 = Color(0xff332E38);
  static Color BLACK_700 = Color(0xff26202F);
  static Color BLACK_800 = Color(0xff1A1426);
  static Color BLACK_900 = Color(0xff120C1F);

  ///---------------------
  /// -- @ linear color
  static Color linear = Color(0xffFEF1CB);

  ///------------------------
  /// -- @ Gradient color
  static LinearGradient GRADIENT_BLUE_DARK = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [INFO_700, INFO_900],
  );
  static LinearGradient GRADIENT_BLUE_MID = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [INFO_500, INFO_700],
  );
  static LinearGradient GRADIENT_BLUE_LIGHT = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [INFO_300, INFO_500],
  );
  static LinearGradient GRADIENT_ORANGE_DARK = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [PRIMARY_700, PRIMARY_900],
  );
  static LinearGradient GRADIENT_ORANGE_MID = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [PRIMARY_500, PRIMARY_700],
  );
  static LinearGradient GRADIENT_ORANGE_LIGHT = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [PRIMARY_300, PRIMARY_500],
  );
  static LinearGradient GRADIENT_BLACK = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [BLACK_400, BLACK_600],
  );
  static LinearGradient GRADIENT_RED_MID = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [DANGER_500, DANGER_700],
  );
  static LinearGradient GRADIENT_RED_BLACK = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [DANGER_700, DANGER_900],
  );
}
