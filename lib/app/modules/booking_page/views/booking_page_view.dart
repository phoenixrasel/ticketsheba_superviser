import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:ticketsheba_superviser/app/modules/booking_page/views/component.dart';
import 'package:ticketsheba_superviser/core/theme/app_theme.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../../core/extra/app_dimens.dart';
import '../../../../core/theme/extra_colors.dart';
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
        child: Column(
          children: [
            // ticketView(),
            SizedBox(
              height: 12,
            ),
            inputUserInfo(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Obx(
                () => controller.isSubmitting.value
                    ? GlobalLoadng.loadingOnly(
                        color: Theme.of(Get.context!).colorScheme.primary)
                    : GlobalButton.btn(
                        text: "Buy",
                        onTap: () {
                          if (controller.inputs['name']!.text.isEmpty)
                            GlobalSnackbar.error(msg: "Enter name");
                           else if (controller.inputs['phone']!.text.isEmpty)
                            GlobalSnackbar.error(msg: "Enter phone");
                           else if (controller.inputs['boarding']!.text.isEmpty)
                             GlobalSnackbar.error(msg: "Please select boarding poiont");
                           else if (controller.inputs['droping']!.text.isEmpty)
                             GlobalSnackbar.error(msg: "Please enter dropping point");
                           else
                            showSubmitAlert(controller: controller);

                        }),
              ),
            ),
            SizedBox(
              height: AppDimens.breatingSpace,
            ),
          ],
        ),
      ),
    );
  }

  showSubmitAlert({required BookingPageController controller}) {
    Get.generalDialog(
        pageBuilder: (ctx, anim1, anim2) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              actionsPadding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Information"),
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
                height: Get.height - 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GlobalInput.inputField(
                          enable: false,
                          controller: controller.inputs['total-fair']!,
                          headerText: "Total fair"),
                      GlobalInput.inputField(
                          controller: controller.inputs['discount']!,
                          headerText: "Discount"),
                      GlobalInput.inputField(
                          enable: false,
                          controller: controller.inputs['grand-total']!,
                          headerText: "Grand Total"),
                      GlobalInput.inputField(
                          controller: controller.inputs['payment-amount']!,
                          onChange: (value) {
                            controller.inputs['due-amount']!.text =
                                "${int.parse(controller.inputs['grand-total']!.text) - int.parse(controller.inputs['payment-amount']!.text)}";
                          },
                          headerText: "Payment Amount"),
                      GlobalInput.inputField(
                          enable: false,
                          controller: controller.inputs['due-amount']!,
                          headerText: "Due Amount"),
                      Container(
                        height: 76,
                        margin:
                            EdgeInsets.only(top: AppDimens.breatingSpace / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Payment Option",
                                style: TextStyle(
                                    color: ExtraColors.BLACK_500,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppDimens.tNormal)),
                            Obx(() => Container(
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: ExtraColors.BLACK_400,
                                          width: .8)),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        isExpanded: true,
                                        value: controller
                                            .selectedPaymentOption.value,
                                        items: controller.paymentOption
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (value) {
                                          controller.updatePaymentOption(value);
                                        }),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 76,
                        margin:
                            EdgeInsets.only(top: AppDimens.breatingSpace / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Payment Status",
                                style: TextStyle(
                                    color: ExtraColors.BLACK_500,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppDimens.tNormal)),
                            Obx(() => Container(
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: ExtraColors.BLACK_400,
                                          width: .8)),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        isExpanded: true,
                                        value: controller
                                            .selectedPaymentStatus.value,
                                        items: controller.paymentStatus
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (value) {
                                          controller.updatePaymentStatus(value);
                                        }),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            Get.back();
                            if(controller.selectedPaymentOption.value == controller.paymentOption[0])
                              GlobalSnackbar.error(msg: "Please select your payment options");
                            else if(controller.selectedPaymentStatus.value == controller.paymentStatus[0])
                              GlobalSnackbar.error(msg: "Please select your payment status");
                            else
                            controller.setAndSubmit();
                            // if (controller.inputs['droping']!.text.isEmpty) {
                            //   GlobalSnackbar.error(msg: "Enter droping point");
                            // } else if (controller
                            //     .inputs['boarding']!.text.isEmpty) {
                            //   GlobalSnackbar.error(msg: "Enter boarding point");
                            // } else {
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

  inputUserInfo() => Container(
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
          Container(
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.primary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
            child:
                Text("Passenger Info", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 15,
          ),
          GlobalInput.inputField(
              controller: controller.inputs['name']!, headerText: "Name"),
          GlobalInput.inputField(
              controller: controller.inputs['phone']!, headerText: "Phone "),
          GlobalInput.inputField(
              controller: controller.inputs['email']!,
              headerText: "Email (Optional)"),
          GlobalInput.inputField(
              controller: controller.inputs['address']!,
              headerText: "Address (Optional)"),
          Component.searchView(
              controller: controller,
              theme: Theme.of(Get.context!).colorScheme,
              suggestions: controller.boardingPoint
                  .map((e) => SearchFieldListItem(e,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(e)),
                      item: e))
                  .toList(),
              hint: '-- Boarding points --',
              inputController: controller.inputs['boarding']!,
              onSelected: (value) {
                // controller.updateCustomerType(value.item);
              }),
          SizedBox(
            height: 6,
          ),
          Component.searchView(
              controller: controller,
              theme: Theme.of(Get.context!).colorScheme,
              suggestions: controller.dropingPoint
                  .map((e) => SearchFieldListItem(e,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(e)),
                      item: e))
                  .toList(),
              hint: '-- Droping points --',
              inputController: controller.inputs['droping']!,
              onSelected: (value) {
                // controller.updateCustomerType(value.item);
              }),
          SizedBox(
            height: AppDimens.paddingExtraGaint,
          ),
        ]),
      );

// ticketView() => Container(
//       margin: EdgeInsets.all(24),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 6,
//               offset: Offset.zero,
//               spreadRadius: 2,
//             )
//           ],
//           borderRadius: BorderRadius.circular(6)),
//       child: Column(children: [
//         Container(
//           height: 24,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Theme.of(Get.context!).colorScheme.primary,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(6), topRight: Radius.circular(6)),
//           ),
//           child: Text("Payment Information"),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         GlobalInput.inputField(
//             controller: controller.inputs['payment']!, headerText: "Payment"),
//         GlobalInput.inputField(
//             controller: controller.inputs['discount']!,
//             headerText: "Discount"),
//         GlobalInput.inputField(
//             controller: controller.inputs['grand-total']!,
//             headerText: "Grand Total"),
//         GlobalInput.inputField(
//             controller: controller.inputs['payment-amount']!,
//             headerText: "Payment Amount"),
//         GlobalInput.inputField(
//             controller: controller.inputs['grand-total']!,
//             headerText: "Due Amount"),
//         DropdownButton(
//             items: controller.paymentOption
//                 .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                 .toList(),
//             onChanged: (value) {}),
//         SizedBox(
//           height: AppDimens.paddingExtraGaint,
//         ),
//       ]),
//     );
}
