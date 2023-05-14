import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/confirm_page_controller.dart';

class ConfirmPageView extends GetView<ConfirmPageController> {
  const ConfirmPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConfirmPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ConfirmPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
