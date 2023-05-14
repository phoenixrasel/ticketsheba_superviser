import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stand_up_controller.dart';

class StandUpView extends GetView<StandUpController> {
  const StandUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StandUpView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StandUpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
