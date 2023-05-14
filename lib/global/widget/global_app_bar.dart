import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/extra/app_assets.dart';

class GlobalAppBar {
  appbar() => AppBar(
        title: Image.asset(
          AppAssets.MAIN_LOGO,
          height: 30,
          width: Get.width / 2,
        ),
        centerTitle: true,
      );
}
