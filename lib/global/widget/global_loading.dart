import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global_text_style.dart';

class GlobalLoadng {
  static loading() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: .7,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Fetching data .....",
              style: GlobalTextStyle.customStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );

  static loadingOnly({Color? color}) => Center(
        child: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: .7,
            valueColor: AlwaysStoppedAnimation(
                color ?? Theme.of(Get.context!).colorScheme.primary),
          ),
        ),
      );
}
