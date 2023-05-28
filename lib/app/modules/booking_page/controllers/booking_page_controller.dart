import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../global/global_alert/global_snackbar.dart';
import '../../../data/services/repository.dart';
import '../../../routes/app_pages.dart';

class BookingPageController extends GetxController {
  var data = Get.arguments['data'];
  var tripId = Get.arguments['ticket_id'];
  Map<String, dynamic> trip = Get.arguments['trip'];

  List<String> boardingPoint = Get.arguments['bording-point'];
  List<String> dropingPoint = Get.arguments['droping-point'];
  List<String> paymentOption = ["--Select payment--", "Cash"];
  List<String> paymentStatus = ["--Payment Status--", "Paid", "Unpaid"];

  RxString selectedPaymentOption = "--Select payment--".obs;
  RxString selectedPaymentStatus = "--Payment Status--".obs;

  updatePaymentOption(value) => selectedPaymentOption(value);
  updatePaymentStatus(value) => selectedPaymentStatus(value);

  Map<String, TextEditingController> inputs = {
    "name": TextEditingController(),
    "phone": TextEditingController(),
    "email": TextEditingController(),
    "address": TextEditingController(),
    "total-fair": TextEditingController(),
    "discount": TextEditingController(),
    "grand-total": TextEditingController(),
    "payment": TextEditingController(),
    "payment-amount": TextEditingController(),
    "due-amount": TextEditingController(),
    "boarding_point": TextEditingController(),
    "dropping_point": TextEditingController(),
    "boarding": TextEditingController(),
    "droping": TextEditingController(),
  };

  setAndSubmit() {
    data["payment_method"] = selectedPaymentOption.value.toLowerCase();
    data["payment_status"] = selectedPaymentStatus.value.toLowerCase();
    data["name"] = inputs['name']!.text;
    data["phone"] = inputs['phone']!.text;
    data["passenger_name"] = inputs['name']!.text;
    data["passenger_phone"] = inputs['phone']!.text;
    data["passenger_email"] = inputs['email']!.text;
    data["passenger_address"] = inputs['address']!.text;
    data["boarding_point"] = inputs['boarding']!.text;
    data["dropping_point"] = inputs['droping']!.text;
    data["payment_amount"] = inputs['payment-amount']!.text;
    data["discount"] = inputs['discount']!.text;
    data["due_amount"] = inputs['due-amount']!.text;
    submitQuickBook();
  }

  var isSubmitting = false.obs;
  submitQuickBook() async {
    isSubmitting(true);
    try {
      String seats = data['seats'].replaceAll("[", '').replaceAll("]", "");
      seats = seats.substring(0, seats.length - 1);
      data['seats'] = seats.split(",");
      Repository().createBooking(id: tripId, map: data).then((value) {
        print("value -> $value");
        if (value['type'] == "success") {
          isSubmitting(false);
          GlobalSnackbar.success(msg: value['message']);
          Get.offNamed(Routes.TICKET_DETAILS_PAGE, arguments: {
            "data": data,
            "ticket-data": value['data'],
            "trip": trip
          });
        } else {
          isSubmitting(false);
          GlobalSnackbar.error(msg: value['message']);
        }
      });
    } on Exception catch (e) {
      isSubmitting(false);
    }
  }

  updateView() {
    inputs['total-fair']!.text = "${data['total_fair']}";
    inputs['grand-total']!.text = "${data['grand_total']}";
    inputs['due-amount']!.text = "0";
  }

  @override
  void onInit() {
    super.onInit();
    updateView();
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
