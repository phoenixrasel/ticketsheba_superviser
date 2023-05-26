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
