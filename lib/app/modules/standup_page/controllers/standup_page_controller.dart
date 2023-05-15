import 'package:get/get.dart';

import 'package:flutter/material.dart';



class StandupPageController extends GetxController {
  Map<String, TextEditingController> inputs = {
    "payment": TextEditingController(),
    "name": TextEditingController(),
    "phone": TextEditingController(),
  };

  RxBool isSubmitting = false.obs;
  submitTicket() async {
    
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
