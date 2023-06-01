import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:ticketsheba_superviser/core/extensions/extensions.dart';
import 'package:ticketsheba_superviser/global/widget/global_loading.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../../core/theme/extra_colors.dart';
import '../controllers/ticket_details_page_controller.dart';

class TicketDetailsPageView extends GetView<TicketDetailsPageController> {
  const TicketDetailsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.back();
        Get.back();
        return true;
      },
      child: Scaffold(
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
        body:
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Obx(() {
              //   return controller.connected.value
              //       ? Container()
              //       : Row(
              //           children: [
              //             Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(4),
              //                   border: Border.all(
              //                       color: ExtraColors.BLACK_400, width: .8)),
              //               width: 170,
              //               padding: EdgeInsets.symmetric(horizontal: 10),
              //               child: Obx(() {
              //                 return controller.devices.isEmpty
              //                     ? Container()
              //                     : DropdownButtonHideUnderline(
              //                         child: DropdownButton(
              //                             isExpanded: true,
              //                             value: controller
              //                                 .connectedDeviceName.value,
              //                             items: controller.devices
              //                                 .map((e) => DropdownMenuItem(
              //                                     value: e.name,
              //                                     child: Text("${e.name}")))
              //                                 .toList(),
              //                             onChanged: (value) {
              //                               controller.setDevice(value);
              //                             }),
              //                       );
              //               }),
              //             ),
              //             Container(
              //               height: 40,
              //               width: 120,
              //               margin: EdgeInsets.only(left: 10),
              //               child: ElevatedButton.icon(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: Colors.orange,
              //                   foregroundColor: Colors.white,
              //                 ),
              //                 onPressed: () {
              //                   // controller.connectNow2(context);
              //                 },
              //                 icon: Icon(Icons.bluetooth),
              //                 label: Text("Connect"),
              //               ),
              //             )
              //           ],
              //         );
              // }),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              controller.loginInfo['company']['name'],
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                controller.trip['trip']['title']
                                    .split(" / ")
                                    .first,
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            Text(controller.trip['assign_date']),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGapRadius: 0.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Ticket Info'),
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGapRadius: 0.0,
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ticket No:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            '${controller.ticketData['ticket_no']}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Catch No:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            '${controller.trip['trip']['coach_no']}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Departure Time:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            '${controller.trip['trip']['departure_time']}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Arrival Time:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            '${controller.trip['trip']['arrival_time']}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Bording Point:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            '${controller.data['boarding_point']} - ${controller.getBoardingTime()}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Dropping Point:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            '${controller.data['dropping_point']} - ${controller.getDropingTime()}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Issue Date:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text: DateTime.now()
                                            .dateFormat("dd MMM, yyyy")),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Booked By:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text: controller.loginInfo['data']
                                            ['name']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGapRadius: 0.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Seat Details'),
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGapRadius: 0.0,
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'P Name:  ', style: TextStyle()),
                                    TextSpan(text: controller.data['name']),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'P Phone:  ', style: TextStyle()),
                                    TextSpan(text: controller.data['phone']),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Seat No:  ', style: TextStyle()),
                                    TextSpan(
                                        text: controller.data['seats']
                                            .toString()),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Total Seats:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            "${controller.data['seats'].length}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGapRadius: 0.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Payment Details'),
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashGapRadius: 0.0,
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'Seat Fare (${controller.trip['trip']['price']} X ${controller.data['seats'].length}):  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            'BDT ${(double.tryParse("${controller.trip['trip']['price']}") ?? 0.0) * controller.data['seats'].length}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '(+) Service Charge:  ',
                                        style: TextStyle()),
                                    TextSpan(text: 'BDT 0'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '(-) Discount:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            'BDT ${controller.data['discount']}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Grand Total:  ',
                                        style: TextStyle()),
                                    TextSpan(
                                        text:
                                            'BDT ${((double.tryParse("${controller.trip['trip']['price']}") ?? 0.0) * controller.data['seats'].length) - (double.tryParse("${controller.data['discount']}") ?? 0.0)}'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Booked By:  ',
                                        style: TextStyle()),
                                    TextSpan(text: controller.data['name']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                margin: EdgeInsets.only(right: 32),
                height: 60,
                width: 150,
                child: Obx(() {
                  return controller.isPrinting.value
                      ? GlobalLoadng.loadingOnly()
                      : ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            // controller.printNow58(context: context);
                            controller.printNow();
                          },
                          icon: Icon(Icons.print),
                          label: Text("Print"));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
