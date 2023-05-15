import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../core/extra/app_dimens.dart';

class GlobalButton {
  
  static btn(
          {required String text,
          required VoidCallback onTap,
          double? fontSize,
          double? height,
          double? width}) =>
      ZoomTapAnimation(
        onTap: onTap,
        child: Material(
          elevation: 6,
          shadowColor: Theme.of(Get.context!).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.rTiny)),
          child: Container(
            height: height ?? AppDimens.fHeight,
            width: width ?? Get.width,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.primary,
              borderRadius: BorderRadius.circular(AppDimens.rTiny),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Theme.of(Get.context!).colorScheme.primary,
            //     blurRadius: 4,
            //     blurStyle: BlurStyle.outer,
            //     offset: Offset(0, 0),
            //   )
            // ],),
            alignment: Alignment.center,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: fontSize ?? AppDimens.tH5)),
          ),
        ),
      );

  static backBtn({required VoidCallback onTap}) => ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ));
}
