import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../../core/extra/app_dimens.dart';
import '../../../../core/theme/extra_colors.dart';
import '../../../../global/global_alert/global_snackbar.dart';
import '../../../../global/widget/global_btn.dart';
import '../../../../global/widget/global_loading.dart';
import '../../../../global/widget/global_text_style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/seat_details_controller.dart';

class SeatDetailsView extends GetView<SeatDetailsController> {
  const SeatDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Image.asset(
            AppAssets.MAIN_LOGO,
            height: 30,
            width: Get.width / 2,
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => controller.isFetching.value
              ? GlobalLoadng.loadingOnly()
              : Column(children: [
                  // Container(
                  //   color: Colors.grey.shade200,
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: AppDimens.bodyPadding, vertical: 6),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text.rich(TextSpan(
                  //             text: "${controller.trip['company']['name']}",
                  //             style: GlobalTextStyle.customStyle(
                  //                 fontSize: AppDimens.tLarge,
                  //                 color: Colors.grey.shade700,
                  //                 weight: FontWeight.bold),
                  //             children: [
                  //               TextSpan(
                  //                   text: "\nType: ",
                  //                   style: GlobalTextStyle.bold(
                  //                       color: Colors.grey.shade600),
                  //                   children: [
                  //                     TextSpan(
                  //                         text:
                  //                             "${controller.trip['trip']['bus_type']?.toString().toUpperCase()}",
                  //                         style: GlobalTextStyle.normal(
                  //                             color: Colors.grey.shade600)),
                  //                     TextSpan(
                  //                         text:
                  //                             "  (৳ ${controller.price.value})",
                  //                         style: GlobalTextStyle.customStyle(
                  //                             fontSize: AppDimens.tLarge,
                  //                             color: Colors.grey.shade700,
                  //                             weight: FontWeight.bold)),
                  //                   ]),
                  //             ])),
                  //         Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 seatsWithType("Available"),
                  //                 SizedBox(
                  //                   width: 12,
                  //                 ),
                  //                 seatsWithType("Booked"),
                  //                 SizedBox(
                  //                   width: 12,
                  //                 ),
                  //                 seatsWithType("Selected"),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ]),
                  // ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(AppDimens.bodyPadding),
                      child: Obx(() => Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: Get.width / 7),
                          child: SingleChildScrollView(
                              child: Column(children: generateSeats())))),
                    ),
                  ),
                  Container(
                    color: ExtraColors.BLACK_200,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text("Seats: ",
                                      style: GlobalTextStyle.normal()),
                                  Obx(() => Expanded(
                                        child: Text(
                                          selectedSeatName() == ""
                                              ? ""
                                              : selectedSeatName().substring(
                                                  0,
                                                  selectedSeatName().length -
                                                      1),
                                          style: GlobalTextStyle.bold(
                                              fontSize: 16,
                                              color: ExtraColors.INFO_700),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Obx(() => Text.rich(TextSpan(
                                      text: "Total: ",
                                      style: GlobalTextStyle.normal(),
                                      children: [
                                        TextSpan(
                                            text: " ৳${controller.total.value}",
                                            style: GlobalTextStyle.bold(
                                              color: ExtraColors.DANGER_700,
                                              fontSize: 25,
                                            ))
                                      ])))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        GlobalButton.btn(
                            height: 40,
                            fontSize: 18,
                            width: Get.width / 3,
                            text: "Buy",
                            onTap: () {
                              if (controller.bookType == "quick") {
                                controller.submitQuickBook();
                              } else {
                                Get.toNamed(Routes.BOOKING_PAGE, arguments: {
                                  "ticket_id": controller.tripId,
                                  "bording-point": controller.boardingPoint,
                                  "droping-point": controller.dropingPoint,
                                  "data": {
                                    "seats": selectedSeatName(),
                                    "unit_fair": controller.price.value,
                                    'total_fair': controller.total.value,
                                    'grand_total': controller.total.value,
                                    'payment_amount': controller.total.value,
                                    'payment_method': '',
                                    'payment_status': '',
                                    "name": "",
                                    "phone": "",
                                    "unit_special_fair": 0,
                                    "discount": 0.0,
                                    "due_amount": 0.0,
                                    "passenger_name": "",
                                    "passenger_phone": "",
                                    "passenger_email": "",
                                    "passenger_address": "",
                                    "boarding_point": "",
                                    "dropping_point": ""
                                  }
                                });
                                // showSubmitAlert(controller: controller);
                              }
                            }),
                      ],
                    ),
                  )
                ]),
        ));
  }

  showSubmitAlert({required SeatDetailsController controller}) {
    Get.generalDialog(
        pageBuilder: (ctx, anim1, anim2) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              actionsPadding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Choose Boarding Point"),
                  ZoomTapAnimation(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: ExtraColors.BLACK_200,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.close, color: ExtraColors.BLACK_700),
                    ),
                  )
                ],
              ),
              content: Container(
                width: Get.width,
                height: 170,
                child: Column(
                  children: [],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: GlobalButton.btn(
                          text: "Continue",
                          onTap: () {
                            // if (controller.inputs['droping']!.text.isEmpty) {
                            //   GlobalSnackbar.error(msg: "Enter droping point");
                            // } else if (controller
                            //     .inputs['boarding']!.text.isEmpty) {
                            //   GlobalSnackbar.error(msg: "Enter boarding point");
                            // } else {
                            Get.back();
                            // Get.toNamed(Routes.PAYMENT_DETAILS_PAGE,
                            //     arguments: {
                            //       "trip": controller.trip,
                            //       "data": {
                            //         "assign_trip_id": controller.tripId,
                            //         "company_id": controller.companyId.value,
                            //         "customer_id": "",
                            //         "name": "",
                            //         "gender": "",
                            //         "phone": "",
                            //         "email": "",
                            //         "startpoint": controller.startingPoint,
                            //         "endpoint": controller.endingPoint,
                            //         "boarding_point":
                            //             controller.inputs['boarding']!.text,
                            //         "dropping_point":
                            //             controller.inputs['droping']!.text,
                            //         "seats": selectedSeatName(),
                            //         "upper_seats": [],
                            //         "unit_fair": controller.price.value,
                            //         "total_fair": controller.total.value,
                            //         "discount": 0,
                            //         "service_chargea": 0,
                            //         "payment_amount": controller.total.value,
                            //         "payment_method": "",
                            //         "payment_status": "unpaid"
                            //       }
                            //     });
                            // }
                          },
                          width: Get.width - 100),
                    ),
                  ],
                )
              ],
            ));
  }

  String selectedSeatName() {
    // List<Widget> seat = [];
    String seat = "";
    controller.specialSeats.forEach((row) {
      row.forEach((column) {
        if (column['is-selected']) {
          seat += "[ ${column['seat-name']} ],";
        }
      });
    });
    controller.seats.forEach((row) {
      row.forEach((column) {
        if (column['is-selected']) {
          seat += "[ ${column['seat-name']} ],";
        }
      });
    });
    return seat;
  }

  seatsWithType(type) => Container(
        height: 40,
        child: Column(children: [
          Image.asset(
            type == "Available"
                ? AppAssets.BUS_SEAT_FREE
                : type == "Booked"
                    ? AppAssets.BUS_SEAT_BOOKED
                    : AppAssets.BUS_SEAT_SELECTED,
            height: 20,
            width: 20,
          ),
          Text(
            type,
            style: GlobalTextStyle.bold(
                fontSize: 10,
                color: type == "Available"
                    ? Colors.grey.shade600
                    : type == "Booked"
                        ? Theme.of(Get.context!).colorScheme.primary
                        : Colors.deepPurple),
          )
        ]),
      );

  List<Widget> generateSeats() {
    List<Widget> seats = [];
    seats.add(Container(
      height: 25,
      margin: EdgeInsets.only(bottom: 12),
      color: Theme.of(Get.context!).colorScheme.primary,
      alignment: Alignment.center,
      child: Text(
        "Lower Decker",
        style: GlobalTextStyle.bold(color: Colors.white, fontSize: 12),
      ),
    ));
    /**
     * Addign special seats
     */
    if (controller.specialSeats.isNotEmpty) {
      seats.add(Row(
        children: [
          Container(
            height: 25,
            width: 130,
            margin: EdgeInsets.only(top: 12, bottom: 12),
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Text(
              "Special Seats",
              style: GlobalTextStyle.bold(
                  color: Colors.grey.shade700, fontSize: 12),
            ),
          ),
        ],
      ));
    }

    controller.specialSeats.forEach((row) {
      List<Widget> seatRow = [];
      seatRow.add(Spacer());
      for (int column = 0; column < row.length; column++) {
        // if (row[column]['seat-name'] != "")
        seatRow.add(seat(row[column]));
      }
      // row.forEach((column) {

      // });
      seatRow.add(Spacer());
      seats.add(Row(
        children: seatRow.map((e) => e).toList(),
      ));
    });
    /**
     * adding normal seats if special seats available
     */
    if (controller.specialSeats.isNotEmpty) {
      seats.add(Row(
        children: [
          Container(
            height: 25,
            width: 130,
            margin: EdgeInsets.only(top: 12, bottom: 12),
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Text(
              "Normal Seats",
              style: GlobalTextStyle.bold(
                  color: Colors.grey.shade700, fontSize: 12),
            ),
          ),
        ],
      ));
    }
    print("${controller.seats.last}");
    controller.seats.forEach((row) {
      List<Widget> seatRow = [];
      seatRow.add(Spacer());
      for (int column = 0; column < row.length; column++) {
        // if (row[column]['seat-name'] != "")
        seatRow.add(seat(row[column]));
      }
      seatRow.add(Spacer());
      seats.add(Row(
        children: seatRow.map((e) => e).toList(),
      ));
    });
    return seats;
  }

  seat(seat) => ZoomTapAnimation(
        onTap: () {
          print("seat -> ${controller.selectedSeatCount.value}");
          if (controller.selectedSeatCount.value >= 4) {
            GlobalSnackbar.error(
                msg:
                    "You can not select more than ${controller.selectedSeatCount.value} seats!",
                title: "Limit exceeded!");
          } else if (seat['seat-name'] != "") {
            if (!seat['is-booked'] && controller.selectedSeatCount.value < 4) {
              controller.checkSeat(seat);
            } else if (seat['is-booked']) {
              GlobalSnackbar.error(msg: "This seat is already booked");
            }
          }
        },
        child: Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.all(6),
          child: seat['seat-name'] == ""
              ? Container()
              : Stack(
                  children: [
                    Image.asset(seat['is-booked']
                        ? AppAssets.BUS_SEAT_BOOKED
                        : seat['is-selected']
                            ? AppAssets.BUS_SEAT_SELECTED
                            : AppAssets.BUS_SEAT_FREE),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 8,
                      child: Center(
                        child: Text(
                          "${seat['seat-name']}",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
}
