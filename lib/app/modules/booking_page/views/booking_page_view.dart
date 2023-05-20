import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../../core/extra/app_dimens.dart';
import '../../../../global/global_alert/global_snackbar.dart';
import '../../../../global/widget/global_btn.dart';
import '../../../../global/widget/global_input.dart';
import '../../../../global/widget/global_loading.dart';
import '../controllers/booking_page_controller.dart';

class BookingPageView extends GetView<BookingPageController> {
  const BookingPageView({Key? key}) : super(key: key);
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
                      text: "Buy",
                      onTap: () {
                        if (controller.inputs['payment']!.text.isEmpty) {
                          GlobalSnackbar.error(msg: "Enter payment amount");
                        } else {
                          controller.submitQuickBook();
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
