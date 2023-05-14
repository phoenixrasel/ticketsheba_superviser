import 'package:get/get.dart';

import '../controllers/stand_up_controller.dart';

class StandUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StandUpController>(
      () => StandUpController(),
    );
  }
}
