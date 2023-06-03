import 'package:get/get.dart';

import '../controllers/stand_up_ticket_details_controller.dart';

class StandUpTicketDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StandUpTicketDetailsController>(
      () => StandUpTicketDetailsController(),
    );
  }
}
