import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:ticketsheba_superviser/app/data/services/prefrences.dart';

import 'dart:async';

import 'package:ticketsheba_superviser/core/extensions/extensions.dart';

class TicketDetailsPageController extends GetxController {

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  Map<String, dynamic> data = Get.arguments['data'];
  Map<String, dynamic> ticketData = Get.arguments['ticket-data'];
  var trip = Get.arguments['trip'];
  var loginInfo = Pref.readData(key: Pref.SESSION);

  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  late BluetoothDevice device;
  RxBool connected = false.obs;
  late String pathImage;
  RxString connectedDeviceName = "".obs;
  RxBool bluetoothConnecting = true.obs;

  RxString selectedPrinter = "".obs;

  RxString topMessage = "".obs;

  getBoardingTime() => trip['trip']['boarding_points'][
          trip['trip']['boarding_points'].indexWhere(
              (element) => element['boarding_point'] == data['boarding_point'])]
      ['boarding_time'];

  getDropingTime() => trip['trip']['dropping_points'][
          trip['trip']['dropping_points'].indexWhere(
              (element) => element['dropping_point'] == data['dropping_point'])]
      ['dropping_time'];

  RxBool isPrinting = false.obs;

  @override
  void onInit() {
    super.onInit();

    // initPlatformState();
  }

  printNow() async {
    await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText("${loginInfo['company']['name']}");
    await SunmiPrinter.printText("${trip['trip']['title'].split(" / ").first}");
    await SunmiPrinter.printText("${trip['assign_date']}");
    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("Ticket Info");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);// Left align
    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.printText("Ticket No: ${ticketData['ticket_no']}");
    await SunmiPrinter.printText("Coach No: ${trip['trip']['coach_no']}");
    await SunmiPrinter.printText("Departure Time: ${trip['trip']['departure_time']}");
    await SunmiPrinter.printText("Arrival Time: ${trip['trip']['arrival_time']}");
    await SunmiPrinter.printText("Boarding Point: ${data['boarding_point'] ?? ""} - ${data['boarding_point'] != null ? getBoardingTime() : ""}");
    await SunmiPrinter.printText("Dropping Point: ${data['dropping_point'] ?? ""} - ${data['dropping_point'] != null ? getDropingTime() : ""}");
    await SunmiPrinter.printText("Issue Date: ${DateTime.now().dateFormat("dd MMM, yyyy")}");
    await SunmiPrinter.printText("Booked By: ${loginInfo['data']['name']}");

    /**
     * seat details
     */

    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("Seat Details");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);// Left align
    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.printText("P Name: ${data['name'] ?? ""}");
    await SunmiPrinter.printText("P Phone: ${data['phone'] ?? ""}");
    await SunmiPrinter.printText("Seat No: ${data['seats'].toString()}");
    await SunmiPrinter.printText("Total Seats: ${data['seats'].length}");

    /**
     * payment details
     */

    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("Payment Details");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);// Left align
    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.printText("Seat Fare (${trip['trip']['price']} X ${data['seats'].length}): BDT ${(double.tryParse("${trip['trip']['price']}") ?? 0.0) * data['seats'].length}");
    await SunmiPrinter.printText("(+) Service Charge: BDT 0");
    await SunmiPrinter.printText("(-) Discount: BDT ${data['discount']}");
    await SunmiPrinter.printText("Grand Total: BDT ${((double.tryParse("${trip['trip']['price']}") ?? 0.0) * data['seats'].length) - (double.tryParse("${data['discount']}") ?? 0.0)}");


    await SunmiPrinter.submitTransactionPrint();
    await SunmiPrinter.exitTransactionPrint(true);
  }

  void disconnectNow() {
    bluetooth.disconnect();
    connected.value = false;
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
