import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../core/extra/app_dimens.dart';
import '../../core/theme/extra_colors.dart';

class GlobalTextWidget {
  static twoText(
          {required VoidCallback onTap,
          required String text1,
          required String text2}) =>
      ZoomTapAnimation(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Text.rich(TextSpan(
              text: text1,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppDimens.tLarge,
                  color: ExtraColors.BLACK_400),
              children: [
                TextSpan(
                    text: text2,
                    style: TextStyle(
                        color: Theme.of(Get.context!).colorScheme.primary,
                        fontWeight: FontWeight.w600))
              ])),
        ),
      );

  static headerText(text, {double? fontSize}) => Text(text,
      style: TextStyle(
          color: Theme.of(Get.context!).colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? AppDimens.tLarge));

  static bodyText(text, {double? fontSize}) => Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: fontSize ?? AppDimens.tExtraSmall,
        ),
        textAlign: TextAlign.center,
      );
}
