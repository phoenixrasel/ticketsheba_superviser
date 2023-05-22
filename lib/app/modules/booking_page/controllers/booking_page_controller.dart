import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../global/global_alert/global_snackbar.dart';
import '../../../data/services/repository.dart';

class BookingPageController extends GetxController {
  var data = Get.arguments['data'];
  var tripId = Get.arguments['id'];

  List<String> boardingPoint = Get.arguments['boarding-points'];
  List<String> dropingPoint = Get.arguments['droping-point'];
  List<String> paymentOption = ["--Select payment--", "Cash"];
  List<String> paymentStatus = ["--Payment Status--", "Paid", "Unpaid"];

  Map<String, TextEditingController> inputs = {
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "email": TextEditingController(),
    "address": TextEditingController(),
    "total-fair": TextEditingController(),
    "discount": TextEditingController(),
    "grand-total": TextEditingController(),
    "payment-amount": TextEditingController(),
    "due-amount": TextEditingController(),
  };

  var isSubmitting = false.obs;
  submitQuickBook() async {
    isSubmitting(true);
    try {
      String seats = data['seats'].replaceAll("[", '').replaceAll("]", "");
      seats = seats.substring(0, seats.length - 1);

      Repository().createBooking(id: tripId, map: data).then((value) {
        if (value['type'] == "success") {
          GlobalSnackbar.success(msg: value['message']);
          // Get.offNamed(Routes.TICKET_DETAILS_PAGE,
          //     arguments: {"id": value['data']['id']});
        } else {
          GlobalSnackbar.error(msg: value['message']);
        }
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
