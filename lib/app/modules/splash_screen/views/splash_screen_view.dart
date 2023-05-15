import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Get.offNamed(Routes.LOGIN);
    });
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Image.asset(
            AppAssets.MAIN_LOGO,
            height: 100,
            width: Get.width / 2,
          ),
        ),
      ),
    );
  }
}
