import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/extra/app_assets.dart';
import '../controllers/stand_up_ticket_details_controller.dart';

class StandUpTicketDetailsView extends GetView<StandUpTicketDetailsController> {
  const StandUpTicketDetailsView({Key? key}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${controller.loginInfo['company']['name']}"),
          Text("Stand Ticket No: ${controller.ticketData['ticket_no']}"),
          Text("${controller.trip['trip']['title'].split(" / ").first}"),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text("Issue Date"),
              Text(": ${controller.trip['assign_date']}"),
            ],
          ),
          Row(
            children: [
              Text("Paid"),
              Text(": ${controller.data['paid']}"),
            ],
          ),
          Row(
            children: [
              Text("Passenger Name"),
              Text(": ${controller.data['name']}"),
            ],
          ),
          Row(
            children: [
              Text("Passenger Phone"),
              Text(": ${controller.data['phone']}"),
            ],
          ),
        ],
      ),
    );
  }
}
