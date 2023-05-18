import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../core/extra/app_assets.dart';
import '../controllers/ticket_details_page_controller.dart';

class TicketDetailsPageView extends GetView<TicketDetailsPageController> {
  const TicketDetailsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.saveVideo();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Image.asset(
          AppAssets.MAIN_LOGO,
          height: 30,
          width: Get.width / 2,
        ),
        centerTitle: true,
      ),
      // body: PDF().cachedFromUrl(
      //   controller.pdfUrl,
      //   placeholder: (double progress) => Center(child: Text('$progress %')),
      //   errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      // ),
      // body: Obx(() => AlhPdfView(
      //       filePath: controller.file.value,
      //     )),
      body: Obx(() => controller.isFileLoading.value
          ? Center(
              child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : PdfViewPinch(
              controller: controller.pdfPinchController,
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.saveVideo();
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
