import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../core/extra/app_assets.dart';
import '../../../../../global/global_alert/global_alert.dart';
import '../../../../../global/global_alert/global_snackbar.dart';
import '../../../../../global/widget/global_text_style.dart';
import '../../../../data/services/prefrences.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';

class CustomDrawer {
  static drawer(HomeController controller) => Drawer(
        child: Column(children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                color: Theme.of(Get.context!).colorScheme.primary,
                alignment: Alignment.center,
                child: Image.asset(
                  AppAssets.MAIN_LOGO,
                  width: 200,
                ),
              )),
          // Obx(
          //   () => controller.loginData.value != null
          //       ? item("Profile", () {
          //           Get.back();
          //           Get.toNamed(Routes.PROFILE);
          //         })
          //       : item("Login", () {
          //           Get.back();
          //           Get.toNamed(Routes.LOGIN_PAGE, arguments: {"from": "Home"});
          //         }),
          // ),
          // Obx(() => controller.loginData.value != null
          //     ? item("Booking List", () {
          //         Get.back();
          //         Get.toNamed(Routes.BOOKING_LIST);
          //       })
          //     : Container()),

          // Obx(() => controller.loginData.value != null
          //     ? item("Pending List", () {
          //         Get.back();
          //         Get.toNamed(Routes.PENDING_LIST);
          //       })
          //     : Container()),
          // Obx(() => controller.loginData.value != null
          //     ? item("Cancellation List", () {
          //         Get.back();
          //         Get.toNamed(Routes.CANCELLATION_LIST);
          //       })
          //     : Container()),

          // item("Reschedule", () {
          //   Get.back();
          //   Get.toNamed(Routes.RESCHEDULE);
          // }),
          // item("Cancel", () {
          //   Get.back();
          //   Get.toNamed(Routes.CANCEL_REFUND);
          // }),
          // item("Show My Ticket", () {
          //   Get.back();
          //   Get.toNamed(Routes.SHOW_MY_TICKET);
          // }),
          // item("Email/SMS", () {
          //   Get.back();
          //   Get.toNamed(Routes.EMAIL_SMS);
          // }),
          Obx(() => controller.loginData.value != null
              ? item("Logout", () {
                  GlobalAlert.confirmAlert(
                      message: "Are you sure want to logout?",
                      onBtnPressed: () {
                        Pref.removeData(key: Pref.SESSION);
                        // Get.back();
                        GlobalSnackbar.success(msg: "Logout success");
                        Get.offAllNamed(Routes.HOME);
                      });
                })
              : Container()),
        ]),
      );

  static item(text, onTap) => ZoomTapAnimation(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade400, width: .5))),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.done_outline_rounded,
                color: Colors.grey.shade600,
                size: 15,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: GlobalTextStyle.bold(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      );
}
