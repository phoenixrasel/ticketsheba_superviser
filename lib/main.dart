import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/routes/app_pages.dart';
import 'core/theme/app_theme.dart';

void main() async {

  /// -- @ ensure binding
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  /// -- @ init packages
  /// -- @ language, getstorage,
  // await EasyLocalization.;
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  // FirebaseServices().init();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xffdc3545),),);
  initializeDateFormatting();

  /// - @ run first page from here
  runApp(
    GetMaterialApp(
      useInheritedMediaQuery: true,
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
