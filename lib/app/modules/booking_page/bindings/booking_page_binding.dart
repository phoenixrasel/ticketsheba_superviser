import 'package:get/get.dart';

import '../controllers/booking_page_controller.dart';

class BookingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingPageController>(
      () => BookingPageController(),
    );
  }
}
