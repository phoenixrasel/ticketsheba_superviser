import 'package:get/get.dart';
import 'package:ticketsheba_superviser/app/data/services/repository.dart';

class QuickBookingPageController extends GetxController {
  var ticketData = Get.arguments;
  submitSeat() async {
    try {
      Repository().submitQuick(ticketData['id'], {
        "seats": "",
        "unit_fair": 400,
        'total_fair': 1200,
        'grand_total': 1200.00,
        'payment_amount': 1200.00,
        'payment_method': 'cash',
        'payment_status': 'paid',
      }).then((value) {
        
      });
    } on Exception catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
