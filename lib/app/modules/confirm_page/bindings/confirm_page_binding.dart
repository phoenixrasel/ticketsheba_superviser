import 'package:get/get.dart';

import '../controllers/confirm_page_controller.dart';

class ConfirmPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmPageController>(
      () => ConfirmPageController(),
    );
  }
}
