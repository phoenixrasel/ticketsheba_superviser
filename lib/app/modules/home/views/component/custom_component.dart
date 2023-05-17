import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:searchfield/searchfield.dart';

import '../../../../../core/extra/app_dimens.dart';
import '../../../../../core/theme/extra_colors.dart';
import '../../../../../global/global_backdrop.dart';
import '../../../../../global/widget/global_decoration.dart';
import '../../controllers/home_controller.dart';

class HomeComponent {
  static normalAlert(
          {bool barrierDismissible = false,
          required String titleText,
          required String bodyText,
          String? btnText,
          required VoidCallback onTap,
          bool closeVisible = false}) =>
      Get.generalDialog(
        barrierDismissible: barrierDismissible,
        barrierLabel: "",
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            GlobalBackDrop().drop(animation, child),
        pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: AppDimens.bodyPadding),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.all(
            AppDimens.bodyPadding * 2,
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ZoomTapAnimation(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade300,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.close, color: Colors.grey.shade700),
              ),
            )
          ]),
          content: Container(
            height: 270,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
          ),
        ),
      );
  static searchView(
          {required HomeController controller,
          required ColorScheme theme,
          required List<SearchFieldListItem<String>> suggestions,
          required String hint,
          required TextEditingController inputController,
          required onSelected}) =>
      Container(
        height: 50,
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 24,
          right: 8,
        ),
        margin: EdgeInsets.only(top: AppDimens.breatingSpace),
        decoration: GlobalDecoration.inputDecoration(theme),
        child: SearchField(
          suggestions: //       items: controller.storepoint
              suggestions,
          suggestionState: Suggestion.expand,
          hint: hint,
          controller: inputController,
          // hasOverlay: true,
          searchStyle: TextStyle(
            fontSize: 18,
            color: Colors.black.withOpacity(0.8),
          ),
          validator: (x) {
            // if (controller.storepoint.contains(x) || x!.isEmpty) {
            //   return 'Please Enter a valid State';
            // }
            return null;
          },
          suggestionItemDecoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal:
                      BorderSide(color: Colors.grey.shade400, width: 0.3))),
          suggestionsDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400, width: 0.6)),
          searchInputDecoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
              // suffix: Text(
              //   '*',
              //   style: TextStyle(color: Colors.red.shade400),
              // ),
              border: InputBorder.none),
          maxSuggestionsInViewPort: 6,
          // itemHeight: 50,
          onSuggestionTap: onSelected,
        ),
      );

  static inputField(
          {required TextEditingController controller,
          String? hintText,
          Widget? suffixIcon,
          bool? isObscure = true,
          bool? isEnable,
          TextInputType? inputType}) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: GlobalDecoration.inputDecoration(
                  Theme.of(Get.context!).colorScheme),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: isEnable,
                      controller: controller,
                      obscureText: isObscure ?? false,
                      keyboardType: inputType,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                      ),
                    ),
                  ),
                  if (suffixIcon != null) suffixIcon
                ],
              ),
            ),
          ],
        ),
      );

  static homeButtons(
          {required String btnText,
          required Color color,
          required VoidCallback onTap}) =>
      ZoomTapAnimation(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: color),
          child: Text(btnText, style: TextStyle(color: Colors.white)),
        ),
      );
}
