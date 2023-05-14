import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/extra/app_assets.dart';
import '../controllers/home_controller.dart';
import 'component/custom_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.MAIN_LOGO,
          height: 30,
          width: Get.width / 2,
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawer.drawer(controller),
      body: Column(children: []),
    );
  }
}
