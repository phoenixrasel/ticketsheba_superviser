import 'package:flutter/material.dart';


class YesNoButton {
  static Widget yesNoButton(
          {required Function btn1Click,
          required Function btn2Click,
          required String btn1Text,
          required String btn2Text,
          required Color btn1Color,
          required Color btn2Color,
          Widget? btn1Icon,
          Widget? btn2Icon}) =>
      Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customButton(
              btn1Click,
              iconWidget: btn1Icon ?? Icon(Icons.check, color: Colors.white),
              textColor: Colors.white,
              borderColor: btn1Color,
              fontSize: 16,
              bgColor: btn1Color,
              text: btn1Text,
            ),
            customButton(
              btn2Click,
              iconWidget: btn2Icon ?? Icon(Icons.close, color: Colors.white),
              textColor: Colors.white,
              borderColor: btn2Color,
              fontSize: 16,
              bgColor: btn2Color,
              text: btn2Text,
            ),
          ],
        ),
      );
}


Widget customButton(onTap,
        {bgColor,
        borderColor,
        Widget? iconWidget,
        text,
        textColor,
        double? fontSize}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget ?? Container(),
            iconWidget != null ? SizedBox(
              width: 10,
            ) : Container(),
            Text(
              "$text",
              style: TextStyle(
                fontSize: fontSize ?? 20,
                color: textColor == null ? Colors.white : textColor,
              ),
            ),
          ],
        ),
      ),
    );

