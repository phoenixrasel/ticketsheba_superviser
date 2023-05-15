import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ticketsheba_superviser/app/routes/app_pages.dart';

import '../../../../global/global_alert/global_snackbar.dart';
import '../../../data/services/prefrences.dart';
import '../../../data/services/repository.dart';

import 'package:flutter/foundation.dart';

class LoginController extends GetxController {
  Map<String, TextEditingController> inputs = {
    "user": TextEditingController(text: kDebugMode ? "hridoy@mail.com" : ""),
    "pass": TextEditingController(text: kDebugMode ? "12345678" : "")
  };

  RxBool shouldLogin = true.obs;
  changeLoginOption() {
    shouldLogin.value = !shouldLogin.value;
    update();
  }

  RxBool isSubmitting = false.obs;

  login() async {
    isSubmitting.value = true;
    update();
    try {
      await Repository().requestLogin(map: {
        "email": inputs['user']?.text ?? "",
        "password": inputs['pass']?.text ?? "",
      }).then((value) {
        if (value['status_code'] == 200) {
          Pref.writeData(key: Pref.SESSION, value: value);
          Get.offAllNamed(Routes.HOME);
          GlobalSnackbar.success(msg: value['message']);
          // Get.offAllNamed(Routes.HOME);
        } else {
          GlobalSnackbar.error(msg: value['message']);
        }
        isSubmitting.value = false;
        update();
      });
    } on Exception catch (e) {
      Get.rawSnackbar(message: e.toString(), backgroundColor: Colors.red);
      isSubmitting.value = false;
      update();
    }
  }

  List<String> gender = ['Male', 'Female', "Other"];
  RxString selectedGender = 'Male'.obs;
  updateSelectedGender(value) {
    selectedGender.value = value;
    update();
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
