import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_page_controller.dart';

class BookingPageView extends GetView<BookingPageController> {
  const BookingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BookingPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
