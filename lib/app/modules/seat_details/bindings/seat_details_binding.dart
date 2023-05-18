import 'package:get/get.dart';

import '../controllers/seat_details_controller.dart';

class SeatDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeatDetailsController>(
      () => SeatDetailsController(),
    );
  }
}
