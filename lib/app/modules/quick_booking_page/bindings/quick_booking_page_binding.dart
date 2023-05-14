import 'package:get/get.dart';

import '../controllers/quick_booking_page_controller.dart';

class QuickBookingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuickBookingPageController>(
      () => QuickBookingPageController(),
    );
  }
}
