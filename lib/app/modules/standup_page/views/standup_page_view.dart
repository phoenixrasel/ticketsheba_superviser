import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ticketsheba_superviser/global/global_alert/global_snackbar.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../../core/extra/app_dimens.dart';
import '../../../../global/widget/global_btn.dart';
import '../../../../global/widget/global_input.dart';
import '../../../../global/widget/global_loading.dart';
import '../controllers/standup_page_controller.dart';

class StandupPageView extends GetView<StandupPageController> {
  const StandupPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.MAIN_LOGO,
          height: 30,
          width: Get.width / 2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  offset: Offset.zero,
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(6)),
          child: Column(children: [
            Text("STAND UP TICKET BOOKING"),
            Divider(
              height: 16,
              thickness: .75,
              color: Colors.grey.shade400,
            ),
            Text("${controller.tripData['trip']['title'] ?? ""}"),
            GlobalInput.inputField(
                controller: controller.inputs['payment']!,
                headerText: "Payment"),
            GlobalInput.inputField(
                controller: controller.inputs['name']!,
                headerText: "Name (Optional)"),
            GlobalInput.inputField(
                controller: controller.inputs['phone']!,
                headerText: "Phone (Optional)"),
            SizedBox(
              height: AppDimens.paddingExtraGaint,
            ),
            Obx(
              () => controller.isSubmitting.value
                  ? GlobalLoadng.loadingOnly(
                      color: Theme.of(context).colorScheme.primary)
                  : GlobalButton.btn(
                      text: "Sign In",
                      onTap: () {
                        if (controller.inputs['payment']!.text.isEmpty) {
                          GlobalSnackbar.error(msg: "Enter payment amount");
                        } else {
                          controller.submitTicket();
                        }
                      }),
            ),
            SizedBox(
              height: AppDimens.breatingSpace,
            ),
          ]),
        ),
      ),
    );
  }
}
