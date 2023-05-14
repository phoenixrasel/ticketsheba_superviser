import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../core/extra/app_dimens.dart';
import '../../core/theme/extra_colors.dart';
import '../widget/global_btn.dart';
import '../widget/global_text_style.dart';

class GlobalAlert {
  static confirmAlert({String? title, required String message, String? btnText, required VoidCallback onBtnPressed}) {
    Get.generalDialog(
        pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title ?? "Alert"),
                    ZoomTapAnimation(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: ExtraColors.BLACK_200,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.close,
                              color: ExtraColors.BLACK_700,
                              size: 20,
                            )))
                  ]),
              content: Container(
                  padding: EdgeInsets.all(AppDimens.bodyPadding),
                  child: Text(
                    message,
                    style: GlobalTextStyle.normal(weight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
                  actions: [
                    GlobalButton.btn(
                        text: btnText ?? "Ok",
                        onTap: onBtnPressed),
                  ],
            ));
  }
}
