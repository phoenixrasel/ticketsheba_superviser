import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:ticketsheba_superviser/global/widget/global_input.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:searchfield/searchfield.dart';

import '../../../../../core/extra/app_dimens.dart';
import '../../../../../core/theme/extra_colors.dart';
import '../../../../../global/global_backdrop.dart';
import '../../../../../global/widget/global_btn.dart';
import '../../../../../global/widget/global_decoration.dart';
import '../../controllers/home_controller.dart';

class HomeComponent {
  static normalAlert(
          {bool barrierDismissible = false,
          required String titleText,
          required String bodyText,
            required HomeController controller,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZoomTapAnimation(
                    onTap: (){
                      _selectDate(context, controller);
                    },
                    child: GlobalInput.inputField(controller: controller.inputs['date']!, headerText: "Search Date", enable: false)),

                SizedBox(height: 6),
                Text("Route",
                    style: TextStyle(
                        color: ExtraColors.BLACK_500,
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimens.tNormal)),
                searchView(
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

                SizedBox(height: 6),
                Container(
                  height: 76,
                  margin:
                  EdgeInsets.only(top: AppDimens.breatingSpace / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bus Type",
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
                                  .selectedBusType.value,
                              items: controller.busType
                                  .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                controller.updateBusType(value);
                              }),
                        ),
                      )),
                    ],
                  ),
                ),

              ],
            ),
          ),

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: GlobalButton.btn(
                      text: "Search",
                      onTap: () {
                        Get.back();

                          controller.addSearchlist();
                      },
                      width: Get.width - 100),
                ),
              ],
            )
          ],
        ),
      );

  static _selectDate(BuildContext context, HomeController  controller) async {
    final DateTime? currentDate = await showDatePicker(
      context: context,
      initialDate: controller.searchDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      helpText: "Date",
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: const Color.fromRGBO(142, 139, 139, 1.0),
            ),
          ),
          child: child!,
        );
      },
    );
    if (currentDate != null && currentDate != controller.searchDate.value) {
      controller.searchDate.value = currentDate;
      controller.inputs['date']!.text =
          DateFormat("yyyy-MM-dd").format(currentDate);
      controller.update();
    }
  }

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
