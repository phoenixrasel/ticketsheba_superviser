import 'package:get/get.dart';

import '../controllers/ticket_details_page_controller.dart';

class TicketDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketDetailsPageController>(
      () => TicketDetailsPageController(),
    );
  }
}
