import 'package:flutter/material.dart';

class GlobalDecoration {
  static inputDecoration(theme) => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: theme.primary,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primary.withOpacity(.1),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset.zero,
            )
          ]);
}
