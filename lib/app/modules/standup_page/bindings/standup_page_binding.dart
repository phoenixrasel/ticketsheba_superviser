import 'package:get/get.dart';

import '../controllers/standup_page_controller.dart';

class StandupPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StandupPageController>(
      () => StandupPageController(),
    );
  }
}
