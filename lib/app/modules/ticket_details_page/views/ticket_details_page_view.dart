import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Obx(() {
                return controller.connected.value
                    ? Container()
                    : Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: ExtraColors.BLACK_400, width: .8)),
                            width: 170,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Obx(() {
                              return controller.devices.isEmpty
                                  ? Container()
                                  : DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          value: controller
                                              .connectedDeviceName.value,
                                          items: controller.devices
                                              .map((e) => DropdownMenuItem(
                                                  value: e.name,
                                                  child: Text("${e.name}")))
                                              .toList(),
                                          onChanged: (value) {
                                            controller.setDevice(value);
                                          }),
                                    );
                            }),
                          ),
                          Container(
                            height: 40,
                            width: 120,
                            margin: EdgeInsets.only(left: 10),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                controller.connectNow2(context);
                              },
                              icon: Icon(Icons.bluetooth),
                              label: Text("Connect"),
                            ),
                          )
                        ],
                      );
              })
            ,SizedBox(height: 12),
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
                      'Star Line',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text('Dhaka to Feni',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Text('26 May, 2023'),
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
                            TextSpan(text: 'Ticket No:  ', style: TextStyle()),
                            TextSpan(text: '3153215454'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Catch No:  ', style: TextStyle()),
                            TextSpan(text: '2135432163'),
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
                                text: 'Departure Time:  ', style: TextStyle()),
                            TextSpan(text: '02.00 AM'),
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
                                text: 'Departure Time:  ', style: TextStyle()),
                            TextSpan(text: '07.00 AM'),
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
                                text: 'Bording Point:  ', style: TextStyle()),
                            TextSpan(text: 'TT.para - 2.00 AM'),
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
                                text: 'Dropping Point:  ', style: TextStyle()),
                            TextSpan(text: 'Tong Road - 7.00 AM'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Issue Date:  ', style: TextStyle()),
                            TextSpan(text: '26 May, 2023'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Booked By:  ', style: TextStyle()),
                            TextSpan(text: 'Mr. Hridoy'),
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
                            TextSpan(text: 'P Name:  ', style: TextStyle()),
                            TextSpan(text: 'Rasel'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'P Phone:  ', style: TextStyle()),
                            TextSpan(text: '01546654682'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Seat No:  ', style: TextStyle()),
                            TextSpan(text: 'A1'),
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
                                text: 'Total Seats:  ', style: TextStyle()),
                            TextSpan(text: '1'),
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
                                text: 'Seat Fare (400 X 1):  ',
                                style: TextStyle()),
                            TextSpan(text: 'BDT 400'),
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
                                text: '(-) Discount:  ', style: TextStyle()),
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
                                text: 'Grand Total:  ', style: TextStyle()),
                            TextSpan(text: 'BDT 400'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Booked By:  ', style: TextStyle()),
                            TextSpan(text: 'Mr. Hridoy'),
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
                            controller.printNow58(context: context);
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
