import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ticketsheba_superviser/global/global_alert/global_snackbar.dart';

import '../../../../core/extra/app_assets.dart';
import '../../../../core/extra/app_dimens.dart';
import '../../../../global/widget/global_btn.dart';
import '../../../../global/widget/global_input.dart';
import '../../../../global/widget/global_loading.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 4),
        child: Padding(
            padding: EdgeInsets.all(AppDimens.bodyPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    AppAssets.MAIN_RED_LOGO,
                    height: 50,
                    width: Get.width / 2,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  ),

                  GlobalInput.inputField(
                      controller: controller.inputs['user']!,
                      headerText: "User email"),

                  GlobalInput.inputField(
                      controller: controller.inputs['pass']!,
                      headerText: "Password"),
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
                              if (controller.inputs['user']!.text.isEmpty)
                                GlobalSnackbar.error(msg: "Enter user name");
                              else if (controller.inputs['pass']!.text.isEmpty)
                                GlobalSnackbar.error(msg: "Enter password");
                              else
                                controller.login();
                            }),
                  ),
                  SizedBox(
                    height: AppDimens.breatingSpace,
                  ),
                  // GlobalTextWidget.twoText(
                  //     onTap: () {
                  //       controller.changeLoginOption();
                  //     },
                  //     text1: controller.shouldLogin.value
                  //         ? "Don't have an Account?"
                  //         : "Already have an Account?",
                  //     text2: controller.shouldLogin.value
                  //         ? " SIGN UP"
                  //         : " SIGN IN")
                ],
              ),
            )),
      ),
    );
  }
}
