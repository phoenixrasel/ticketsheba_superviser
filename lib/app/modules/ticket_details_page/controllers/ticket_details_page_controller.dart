import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';
import 'package:ticketsheba_superviser/app/data/services/prefrences.dart';
import 'package:flutter/material.dart';
import 'package:ticketsheba_superviser/global/global_alert/global_snackbar.dart';

import 'dart:async';

class TicketDetailsPageController extends GetxController {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  Map<String, dynamic> data = Get.arguments['data'];
  var trip = Get.arguments['trip'];

  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  late BluetoothDevice device;
  RxBool connected = false.obs;
  late String pathImage;
  RxString connectedDeviceName = "".obs;
  RxBool bluetoothConnecting = true.obs;

  RxString selectedPrinter = "".obs;

  RxString topMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool isConnected = await bluetooth.isConnected ?? false;
    // selectedPrinter.value =
    //     await PrefStorage.getPrefValue(key: PrefStorage.selectedPrinter) ??
    //         "80 mm";
    List<BluetoothDevice> devicesList = [];
    try {
      devicesList = await bluetooth.getBondedDevices();
    } catch (e) {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          connected.value = true;
          print("bluetooth device state: connected");
          update();
          break;
        case BlueThermalPrinter.DISCONNECTED:
          connected.value = false;
          print("bluetooth device state: disconnected");
          update();
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          connected.value = false;
          print("bluetooth device state: disconnect requested");
          update();
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          connected.value = false;
          print("bluetooth device state: bluetooth turning off");
          update();
          break;
        case BlueThermalPrinter.STATE_OFF:
          connected.value = false;
          print("bluetooth device state: bluetooth off");
          update();
          break;
        case BlueThermalPrinter.STATE_ON:
          connected.value = false;
          print("bluetooth device state: bluetooth on");
          update();
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          connected.value = false;
          print("bluetooth device state: bluetooth turning on");
          update();
          break;
        case BlueThermalPrinter.ERROR:
          connected.value = false;
          print("bluetooth device state: error");
          update();
          break;
        default:
          print(state);
          break;
      }
    });

    // if (!mounted) return;
    String? savedDeviceName = await Pref.readData(key: Pref.btDeviceName);
    devices.value = devicesList;
    var deviceIndex = devices.indexWhere(
        (element) => element.name == (savedDeviceName ?? "RP328-E"));
    connectedDeviceName.value =
        deviceIndex < 0 ? devices[deviceIndex].name ?? "" : "";
    update();
    device = deviceIndex < 0 ? devices[deviceIndex] : devices.first;
    devices.forEach((element) {
      print("blue name -> ${element.name}");
    });
    update();
    connectNow();

    if (isConnected) {
      connected.value = true;
      update();
    }
  }

  setDevice(name) {
    connectedDeviceName.value = name;
    device = devices[devices.indexWhere((element) => element.name == name)];
    update();
  }

  void connectNow() {
    if (device == null) {
      print('No device selected.');
      bluetoothConnecting.value = false;
      update();
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(device).catchError((error) {
            connected.value = false;
            update();
          });
          connected.value = true;
          update();

          bluetoothConnecting.value = false;
          update();
        } else {
          print("device connected");

          connected.value = true;
          bluetoothConnecting.value = false;
          update();
        }
      });
    }
  }

  void connectNow2(BuildContext context) {
    if (device == null) {
      print('No device selected.');
      bluetoothConnecting.value = false;
      update();
    } else {
      bluetooth.isConnected.then((isConnected) async {
        Pref.writeData(
            key: Pref.btDeviceName, value: connectedDeviceName.value);
        if (!isConnected!) {
          bluetooth.connect(device).catchError((error) {
            connected.value = false;
            update();
          });
          connected.value = true;
          update();

          bluetoothConnecting.value = false;
          update();
          GlobalSnackbar.success(
              title: "Success", msg: "Device connected print now");
        } else {
          print("device connected");
          connected.value = true;
          bluetoothConnecting.value = false;
          update();
          GlobalSnackbar.success(
              title: "Success", msg: "Device connected print now");
        }
      });
    }
  }

  RxBool isPrinting = false.obs;

  // printNow({required BuildContext context}) {
  //   isPrinting.value = true;
  //   update();
  //   bluetooth.isConnected.then((isConnected) {
  //     if (isConnected ?? false) {
  //       bluetooth.printCustom("${getBusinessBranchInfo()}", 2, 1,
  //           charset: "windows-1250");
  //       bluetooth.printCustom("${getAddress()}", 1, 1, charset: "windows-1250");
  //       bluetooth.printCustom("${getPhone()}", 1, 1, charset: "windows-1250");
  //       bluetooth.printCustom(getLineLarge(), 1, 0);
  //       bluetooth.printLeftRight("Sales Receipt ", "${getPaymentType()}", 1,
  //           format: "%-26s %20s %n");
  //       bluetooth.printLeftRight(
  //           "ID: ${getSalesId()} (APP) ", "DateTime: ${getSalesDate()}", 0,
  //           format: "%-32s %30s %n");
  //       bluetooth.printLeftRight(
  //           "Payment By: ${getPaymentBy()}", "Cashier: ${getCashier()}", 0,
  //           format: "%-32s %30s %n");
  //       bluetooth.printCustom("Customer: ${getCustomerInfo()}", 0, 0);
  //       bluetooth.printCustom(getLineLarge(), 1, 0);
  //       bluetooth.print4Column("S/L   Item's", "MRP", "Qty", "Total", 1,
  //           format: "%-23s %-6s %-7s %8s%n");
  //       bluetooth.printCustom(getLineLarge(), 1, 0);
  //       for (int index = 0; index < data.length; index++) {
  //         bool hasSecond = false;
  //         String firstColumn =
  //             "${index + 1}   ${data[index].brandName ?? ""}${data[index].strength ?? ""}";
  //         if (firstColumn.length > 28) {
  //           hasSecond = true;
  //         }
  //         bluetooth.print4Column(
  //             firstColumn.length > 28
  //                 ? firstColumn.substring(0, 28)
  //                 : firstColumn,
  //             "${data[index].salesPrice!.toStringAsFixed(2)}",
  //             "${data[index].quantity}",
  //             "${(data[index].quantity! * data[index].salesPrice!).toStringAsFixed(2)}",
  //             0,
  //             format: "%-31s %-9s %-1s %17s%n");
  //         if (hasSecond) {
  //           bluetooth.print4Column(
  //               "     ${firstColumn.substring(29, firstColumn.length)}",
  //               "  ",
  //               "  ",
  //               "  ",
  //               0,
  //               format: "%-31s %-9s %-1s %17s%n");
  //         }

  //         // bluetooth.printCustom(getLine(), 1, 0);
  //       }
  //       bluetooth.printCustom(getLineLarge(), 1, 0);
  //       bluetooth.printLeftRight("", "Total Price: ${getTotalPrice()}", 0,
  //           format: "%-32s %30s %n");
  //       bluetooth.printLeftRight("", "Less Adjustment(-): ${getDiscount()}", 0,
  //           format: "%-32s %30s %n");
  //       if (Get.arguments["vat"] != 0.0)
  //         bluetooth.printLeftRight("", "Vat(+): ${getVat()}", 0,
  //             format: "%-32s %30s %n");
  //       bluetooth.printLeftRight("", "Net Price: ${getNetPrice()}", 1,
  //           format: "%-15s %31s %n");
  //       bluetooth.printNewLine();
  //       bluetooth.printNewLine();
  //       // bluetooth.printCustom("আমি বাংলাই গান গাই", 0, 1, charset: "\u088F");
  //       bluetooth.printCustom(topMessage.value, 0, 1);
  //       bluetooth.printCustom(getLineLarge(), 1, 0);
  //       bluetooth.printCustom(getMessageBottom(), 0, 1);
  //       bluetooth.printCustom("Call Us: 01922800322 or 09609080706", 0, 1);
  //       bluetooth.printNewLine();
  //       bluetooth.paperCut();
  //       isPrinting.value = false;
  //       update();
  //     } else {
  //       CustomTopBar.showErrorTop(
  //           title: "Success",
  //           message:
  //               "Printer not connected. Please connect your printer using bluetooth");
  //       isPrinting.value = false;
  //       update();
  //     }
  //   });
  // }

  printNow58({required BuildContext context}) {
    isPrinting.value = true;
    update();
    bluetooth.isConnected.then((isConnected) {
      if (isConnected ?? false) {
        var prefValue = Pref.readData(key: Pref.SESSION);
        var companyName = prefValue['company']['name'];
        bluetooth.printCustom(companyName, 2, 1, charset: "windows-1250");
        bluetooth.printCustom("App", 0, 1, charset: "windows-1250");
        bluetooth.printCustom("*********************", 1, 0);
        bluetooth.printCustom("Journey: ${trip['title'].split(" / ").first}", 0, 1,
            charset: "windows-1250");
        bluetooth.printCustom("Seat details:", 0, 1, charset: "windows-1250");
        bluetooth.printCustom("Seat details:", 0, 1, charset: "windows-1250");
        bluetooth.printLeftRight(
          "Sales Receipt ",
          "",
          1,
        );

        ///format: "%-26s %10s %n"
        // bluetooth.printLeftRight(
        //     "ID: ${getSalesId()} (APP) ", "DateTime: ${getSalesDate()}", 0,
        //     format: "%-2s %23s %n");
        // bluetooth.printLeftRight(
        //     "Payment By: ${getPaymentBy()}", "Cashier: ${getCashier()}", 0,
        //     format: "%-2s %22s %n");
        // bluetooth.printCustom("Customer: ${getCustomerInfo()}", 0, 0);
        // bluetooth.printCustom(getLine(), 1, 0);
        // bluetooth.print4Column("S/L   Item's", "MRP", "Qty", "Total", 0,
        //     format: "%-20s %-6s %-4s %4s %n");
        // bluetooth.printCustom(getLine(), 1, 0);
        for (int index = 0; index < data.length; index++) {
          bool hasSecond = false;
          String firstColumn =
              "${index + 1}   ${data[index].brandName ?? ""}${data[index].strength ?? ""}";
          if (firstColumn.length > 20) {
            hasSecond = true;
          }
          bluetooth.print4Column(
              firstColumn.length > 20
                  ? firstColumn.substring(0, 20)
                  : firstColumn,
              "${data[index].salesPrice!.toStringAsFixed(2)}",
              "${data[index].quantity}",
              "${(data[index].quantity! * data[index].salesPrice!).toStringAsFixed(2)}",
              0,
              format: "%-20s %-6s %2s %7s %n");
          if (hasSecond) {
            bluetooth.print4Column(
                "     ${firstColumn.substring(20, firstColumn.length)}",
                "  ",
                "  ",
                "  ",
                0,
                format: "%-20s %-6s %2s %7s %n");
          }

          // bluetooth.printCustom(getLine(), 1, 0);
        }
        // bluetooth.printCustom(getLine(), 1, 0);
        // bluetooth.printLeftRight("", "Total Price: ${getTotalPrice()}", 0,
        //     format: "%-15s %25s %n");
        // bluetooth.printLeftRight("", "Less Adjustment(-): ${getDiscount()}", 0,
        //     format: "%-15s %20s %n");
        // if (Get.arguments["vat"] != 0.0)
        //   bluetooth.printLeftRight("", "Vat(+): ${getVat()}", 0,
        //       format: "%-15s %20 %n");
        // bluetooth.printLeftRight("", "Net Price: ${getNetPrice()}", 1,
        //     format: "%-13s %-10s %n"); //format: "%-15s %31s %n"
        // bluetooth.printNewLine();
        // bluetooth.printNewLine();
        // // bluetooth.printCustom("আমি বাংলাই গান গাই", 0, 1, charset: "\u088F");
        // bluetooth.printCustom(topMessage.value, 0, 1);
        // bluetooth.printCustom(getLine(), 1, 0);
        // bluetooth.printCustom(getMessageBottom(), 0, 1);
        // bluetooth.printCustom("Call Us: 01922800322 or 09609080706", 0, 1);
        bluetooth.printNewLine();
        bluetooth.paperCut();
        isPrinting.value = false;
        update();
      } else {
        GlobalSnackbar.error(
            title: "Success",
            msg:
                "Printer not connected. Please connect your printer using bluetooth");
        isPrinting.value = false;
        update();
      }
    });
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
