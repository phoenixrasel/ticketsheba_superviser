import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/enums/global_enums.dart';
import '../../../../global/global_alert/global_snackbar.dart';
import '../../../data/services/repository.dart';
import '../../../routes/app_pages.dart';

class SeatDetailsController extends GetxController {
  var bookType = Get.arguments['book-type'];

  int tripId = Get.arguments['tirp-id'];
  // String startingPoint = Get.arguments['starting-point'];
  // String endingPoint = Get.arguments['ending-point'];
  Map<String, dynamic> trip = Get.arguments['trip'];
  RxList<List<Map<String, dynamic>>> specialSeats =
      <List<Map<String, dynamic>>>[].obs;
  RxList<List<Map<String, dynamic>>> seats = <List<Map<String, dynamic>>>[].obs;
  List<String> seatText = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];

  RxList<String> boardingPoint = ["-- Boarding points --"].obs;
  RxList<String> dropingPoint = ["-- Droping points --"].obs;

  Map<String, TextEditingController> inputs = {
    "boarding": TextEditingController(),
    "droping": TextEditingController(),
    "date": TextEditingController(),
  };

  @override
  void onInit() {
    super.onInit();
    getSeatDetails();
    // seatText.forEach((element) {
    //   for (int index = 0; index < 4; index++) {
    //     seats.add({
    //       "seat-name": "$element${index + 1}",
    //       "is-selected": false,
    //       "is-booked": false,
    //       "price": 1000,
    //     });
    //   }
    // });

    // seats[0]['is-booked'] = true;
    // seats[3]['is-booked'] = true;
    // seats[5]['is-booked'] = true;
    // seats.refresh();
  }

  RxBool isFetching = false.obs;
  RxInt leftSeatCount = 0.obs;
  RxInt rightSeatCount = 0.obs;
  RxInt specialLeftSeatCount = 0.obs;
  RxInt specialRightSeatCount = 0.obs;
  RxInt companyId = 0.obs;
  RxInt customerId = 0.obs;
  RxInt price = 0.obs;
  getSeatDetails() async {
    isFetching.value = true;
    update();
    try {
      await Repository().getBusSeats(id: tripId).then((response) {
        var value = response['trip'];
        price.value = value['trip']['price'];

        companyId.value = value['trip']['fleet']['company_id'];
        /**
         * add boarding points
         */
        value['trip']['boarding_points'].forEach((element) {
          boardingPoint.add(element['boarding_point']);
        });
        boardingPoint.refresh();
        /**
         * add droping points
         */
        value['trip']['dropping_points'].forEach((element) {
          dropingPoint.add(element['dropping_point']);
        });
        dropingPoint.refresh();
        /**
         * store special seat
         */
        storeSpecialSeats(value['trip'], value['sold_ticket']);
        /**
         * store normal seat
         */
        storeNormalSat(value['trip'], value['sold_ticket']);
        isFetching.value = false;
        update();
      });
    } on Exception catch (e) {
      if (kDebugMode) print("error -> $e");
    }
  }

  storeSpecialSeats(value, soldList) {
    List<String> specialSeatNumber =
        value['fleet']['special_numbers'].split(", ");
    specialLeftSeatCount.value =
        int.parse(value['fleet']['special_layout'].split('-').first);
    specialRightSeatCount.value =
        int.parse(value['fleet']['special_layout'].split('-').last);
    int totalColumn = specialLeftSeatCount.value + specialRightSeatCount.value;
    int totalSeats = value['fleet']['special_seats'];
    int totalRow = (totalSeats / totalColumn).round();

    print("total seats -> $totalRow");

    List<dynamic> bookedSeats = soldList;
    /**
         * Calculating row
         */
    for (int row = 0; row < totalRow; row++) {
      /**
           * Calculating left column
           */
      List<Map<String, dynamic>> columns = [];
      for (int leftColumn = (specialSeats.length * 3);
          leftColumn < ((specialSeats.length * 3) + specialLeftSeatCount.value);
          leftColumn++) {
        columns.add({
          "seat-name": "${specialSeatNumber[row + leftColumn]}",
          "is-selected": false,
          "is-booked":
              bookedSeats.contains("${specialSeatNumber[row + leftColumn]}"),
          "price": value['trip']?['special_price'] ?? 0,
        });
      }
      /**
           * adding gap or seat
           */
      columns.add({
        "seat-name": "",
        "is-selected": false,
        "is-booked": false,
        "price": 0,
      });
      /**
           * Calculating right column
           */
      for (int rightColumn =
              (specialLeftSeatCount.value + (specialSeats.length * 3));
          rightColumn <
              (specialRightSeatCount.value +
                  specialLeftSeatCount.value +
                  (specialSeats.length * 3));
          rightColumn++) {
        print(
            "row and -> ${row + rightColumn} and ${specialSeatNumber.length}");
        if ((row + rightColumn) >= specialSeatNumber.length) {
          columns.add({
            "seat-name": "",
            "is-selected": false,
            "is-booked": false,
            "price": 0,
          });
        } else {
          columns.add({
            "seat-name": "${specialSeatNumber[row + rightColumn]}",
            "is-selected": false,
            "is-booked":
                bookedSeats.contains("${specialSeatNumber[row + rightColumn]}"),
            "price": value['trip']?['special_price'] ?? 0,
          });
        }
      }
      specialSeats.add(columns);
    }
    specialSeats.refresh();
  }

  storeNormalSat(value, soldList) {
    List<String> seatNumber = value['fleet']['numbers'].split(", ");
    leftSeatCount.value = int.parse(value['fleet']['layout'].split('-').first);
    rightSeatCount.value = int.parse(value['fleet']['layout'].split('-').last);
    int totalColumn = leftSeatCount.value + rightSeatCount.value;
    int totalSeats = value['fleet']['seats'];
    int lastSeatCount = value['fleet']['last_seat'];
    int totalRow = (totalSeats / totalColumn).round();

    List<dynamic> bookedSeats = soldList;
    /**
         * Calculating row
         */
    for (int row = 0; row < totalRow; row++) {
      /**
           * Calculating left column
           */
      List<Map<String, dynamic>> columns = [];
      for (int leftColumn = (seats.length * 3);
          leftColumn < ((seats.length * 3) + leftSeatCount.value);
          leftColumn++) {
        columns.add({
          "seat-name": "${seatNumber[row + leftColumn]}",
          "is-selected": false,
          "is-booked": bookedSeats.contains("${seatNumber[row + leftColumn]}"),
          "price": value['price'],
        });
      }
      /**
           * adding gap or middle seat
           */
      if (lastSeatCount == 1 && row == totalRow - 1) {
        columns.add({
          "seat-name":
              "${seatNumber[row + (leftSeatCount.value + (seats.length * 3))]}",
          "is-selected": false,
          "is-booked": bookedSeats.contains(
              "${seatNumber[row + (leftSeatCount.value + (seats.length * 3))]}"),
          "price": value['price'],
        });
      } else {
        columns.add({
          "seat-name": "",
          "is-selected": false,
          "is-booked": false,
          "price": 0,
        });
      }

      /**
           * Calculating right column
           */
      for (int rightColumn = (leftSeatCount.value +
              (seats.length * 3) +
              (lastSeatCount == 1 && row == totalRow - 1 ? 1 : 0));
          rightColumn <
              (rightSeatCount.value +
                  leftSeatCount.value +
                  (seats.length * 3) +
                  (lastSeatCount == 1 && row == totalRow - 1 ? 1 : 0));
          rightColumn++) {
        columns.add({
          "seat-name": "${seatNumber[row + rightColumn]}",
          "is-selected": false,
          "is-booked": bookedSeats.contains("${seatNumber[row + rightColumn]}"),
          "price": value['price'],
        });
      }
      seats.add(columns);
    }

    List<dynamic> lastSeats = seatNumber.sublist(
        seatNumber.length - lastSeatCount, seatNumber.length);
    if (lastSeatCount == 1) {
      seats.last.forEach((element) {
        if (element['seat-name'] == "") {
          print("elemnt -> $element");
          element = {
            "seat-name": "${lastSeats[0]}",
            "is-selected": false,
            "is-booked": bookedSeats.contains("${lastSeats[0]}"),
            "price": value['price'],
          };
          print("element 2 -> $element");
        }
      });
      seats.refresh();
      update();
    } else {
      List<Map<String, dynamic>> lastSeatColumn = [];

      for (int index = 0; index < lastSeatCount; index++) {
        lastSeatColumn.add({
          "seat-name": "${lastSeats[index]}",
          "is-selected": false,
          "is-booked": bookedSeats.contains("${lastSeats[index]}"),
          "price": value['price'],
        });
      }
      seats.add(lastSeatColumn);
    }

    seats.refresh();
    update();
  }

  checkSeat(seat) async {
    isFetching.value = true;
    update();
    try {
      await Repository()
          .tempSeatCheckedAndStore(
              tripId: tripId,
              seatNumber: seat['seat-name'],
              bookedType: BookedType.CHECKED,
              shouldStore: false)
          .then((value) {
        print("value -> $value");
        if (value['check'] == "available") {
          storeBook(seat, true);
        } else {
          // if(seat['is-booked'])
          GlobalSnackbar.error(msg: "This seat was selected");
          isFetching.value = false;
          // updateSeatSelection(seat);
          storeBook(seat, true);
          update();
        }
      });
    } on Exception catch (e) {
      if (kDebugMode) print("error -> $e");
    }
  }

  storeBook(seat, bool shouldStore) async {
    try {
      await Repository()
          .tempSeatCheckedAndStore(
              tripId: tripId,
              seatNumber: seat['seat-name'],
              bookedType: BookedType.STORE,
              shouldStore: shouldStore)
          .then((value) {
        print("value -> $value");
        if (value['store'] == "success") {
          GlobalSnackbar.success(
              msg: seat['is-selected'] ? "Seat removed" : "Seat added");
          updateSeatSelection(seat);
        } else
          GlobalSnackbar.error(msg: "This seat already selected by someone");
        isFetching.value = false;
        update();
      });
    } on Exception catch (e) {
      if (kDebugMode) print("booking error -> $e");
    }
  }

  RxInt total = 0.obs;
  RxInt selectedSeatCount = 0.obs;

  updateSeatSelection(seat) {
    // seats[index]['is-selected'] = !seats[index][index]['is-selected'];
    // seats.refresh();
    // total.value = 0;
    // seats.forEach((element) {
    //   if (element['is-selected']) {
    //     total.value += int.parse("${element['price']}");
    //   }
    // });
    print("data -> ${!seat['is-selected']}");
    seat['is-selected'] = !seat['is-selected'];
    seats.refresh();
    specialSeats.refresh();
    total.value = 0;
    selectedSeatCount.value = 0;
    /**
     * special seat total
     */
    specialSeats.forEach((row) {
      row.forEach((column) {
        if (column['is-selected']) {
          selectedSeatCount.value += 1;
          total.value += int.parse("${column['price']}");
        }
      });
    });
    /**
     * seat total
     */
    seats.forEach((row) {
      row.forEach((column) {
        if (column['is-selected']) {
          selectedSeatCount.value += 1;
          total.value += int.parse("${column['price']}");
        }
      });
    });
    update();
  }

  var isSubmitting = false.obs;
  String selectedSeatName() {
    // List<Widget> seat = [];
    String seat = "";
    specialSeats.forEach((row) {
      row.forEach((column) {
        if (column['is-selected']) {
          seat += "[ ${column['seat-name']} ],";
        }
      });
    });
    seats.forEach((row) {
      row.forEach((column) {
        if (column['is-selected']) {
          seat += "[ ${column['seat-name']} ],";
        }
      });
    });
    return seat;
  }

  submitQuickBook() async {
    isSubmitting(true);
    try {
      String seats = selectedSeatName().replaceAll("[", '').replaceAll("]", "");
      seats = seats.substring(0, seats.length - 1);

      Repository().submitQuick(tripId, {
        "seats": seats.split(","),
        "unit_fair": price.value,
        'total_fair': total.value,
        'grand_total': total.value,
        'payment_amount': total.value,
        'payment_method': 'cash',
        'payment_status': 'paid',
      }).then((value) {
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
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
