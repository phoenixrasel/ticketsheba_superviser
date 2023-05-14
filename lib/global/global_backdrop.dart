import 'dart:ui';

import 'package:flutter/material.dart';

class GlobalBackDrop {
  Widget drop(Animation<double> anim1, child) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4 * anim1.value,
          sigmaY: 4 * anim1.value,
        ),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      );
}
