import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quick_booking_page_controller.dart';

class QuickBookingPageView extends GetView<QuickBookingPageController> {
  const QuickBookingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBookingPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuickBookingPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
