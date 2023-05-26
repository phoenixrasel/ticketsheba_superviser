import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/extra/app_dimens.dart';
import '../../core/theme/extra_colors.dart';

class GlobalInput {
  static inputField(
          {required TextEditingController controller,
          required String headerText,
          String? hint,
          Widget? suffixIcon,
          bool? isObsecure,
          bool enable = true,
          TextInputType? inputType}) =>
      Container(
        height: 76,
        margin: EdgeInsets.only(top: AppDimens.breatingSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headerText,
                style: TextStyle(
                    color: ExtraColors.BLACK_500,
                    fontWeight: FontWeight.w400,
                    fontSize: AppDimens.tNormal)),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: enable ? Colors.white : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: ExtraColors.BLACK_400, width: .8)),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: isObsecure ?? false,
                      keyboardType: inputType,
                      enabled: enable,
                      style: TextStyle(color: ExtraColors.BLACK_500),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: hint),
                    ),
                  ),
                  if (suffixIcon != null) suffixIcon
                ],
              ),
            ),
          ],
        ),
      );

  static searchField(
          {required TextEditingController controller,
          String? hintText,
          Widget? prefix,
          bool? isObscure,
          TextInputType? inputType}) =>
      Container(
        height: 46,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(Get.context!).colorScheme.primary, width: 1.5)),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            if (prefix != null) prefix,
            if (prefix != null)
              SizedBox(
                width: 12,
              ),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isObscure ?? false,
                keyboardType: inputType,
                style: TextStyle(
                    color: ExtraColors.BLACK_600,
                    fontSize: AppDimens.tExtraSmall),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: ExtraColors.BLACK_400)),
              ),
            ),
          ],
        ),
      );
}
