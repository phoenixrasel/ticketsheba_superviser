import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:ticketsheba_superviser/app/data/services/repository.dart';
import 'package:ticketsheba_superviser/global/global_alert/global_snackbar.dart';

import '../../../routes/app_pages.dart';

class StandupPageController extends GetxController {
  Map<String, TextEditingController> inputs = {
    "payment": TextEditingController(),
    "name": TextEditingController(),
    "phone": TextEditingController(),
  };

  var tripData = Get.arguments as Map<String, dynamic>;

  RxBool isSubmitting = false.obs;
  submitTicket() async {
    isSubmitting(true);
    try {
      Repository().submitStandUp(tripData['id'], {
        "payment": inputs['payment']!.text.toString(),
        "passenger_name": inputs['name']!.text.toString(),
        "passenger_phone": inputs['phone']!.text.toString()
      }).then((value) {
        isSubmitting(false);
        if (value['type'] == "success") {
          GlobalSnackbar.success(msg: value['message']);
          Get.offNamed(Routes.STAND_UP_TICKET_DETAILS,
              arguments: {
                "data": {
                  "name": inputs['name']!.text.toString(),
                  "Phone": inputs['phone']!.text.toString(),
                  "paid": inputs['payment']!.text.toString(),
                },
                "ticket-data": value['data'],
                "trip": tripData
              });
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
