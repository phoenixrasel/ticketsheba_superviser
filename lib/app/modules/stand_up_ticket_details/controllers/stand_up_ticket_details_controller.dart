import 'package:get/get.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../data/services/prefrences.dart';

class StandUpTicketDetailsController extends GetxController {

  Map<String, dynamic> ticketData = Get.arguments['ticket-data'];
  var trip = Get.arguments['trip'];
  Map<String, dynamic> data = Get.arguments['data'];

  var loginInfo = Pref.readData(key: Pref.SESSION);


  printNow() async {
    await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText("${loginInfo['company']['name']}");
    await SunmiPrinter.printText("Stand Ticket No: ${ticketData['ticket_no']}");
    await SunmiPrinter.printText("${trip['trip']['title'].split(" / ").first}");
    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText("Ticket Info");
    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);// Left align
    await SunmiPrinter.printText("*********************");
    await SunmiPrinter.printText("Issue Date: ${trip['assign_date']}");
    await SunmiPrinter.printText("Paid: ${data['paid']}");
    await SunmiPrinter.printText("P Name: ${data['name']}");
    await SunmiPrinter.printText("P Phone: ${data['phone']}");



    await SunmiPrinter.submitTransactionPrint();
    await SunmiPrinter.exitTransactionPrint(true);
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
