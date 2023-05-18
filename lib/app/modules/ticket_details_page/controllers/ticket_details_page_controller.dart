import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../../global/global_alert/global_snackbar.dart';
import '../../../../global/widget/yes_no_btn.dart';

class TicketDetailsPageController extends GetxController {
  String pdfUrl =
      "https://system.ticketsheba.com/invoice/customer/ticket/${Get.arguments['id']}";

  var file = Rxn();

  var pdfPinchController;
  loadPdf(filePath) {
    print("file path - $filePath");
    pdfPinchController = PdfControllerPinch(
        document: PdfDocument.openFile(filePath)
        // document: PdfDocument.openData(InternetFile.get(
        //     'https://system.ticketsheba.com/invoice/customer/ticket/${Get.arguments['id']}')),
        );
    isFileLoading.value = false;
    update();
  }

  RxBool isFileLoading = false.obs;

  final Dio dio = Dio();
  String filePath = '/storage/emulated/0/Download/ticketsheba';
  RxDouble progress = 0.0.obs;

//----------------------------------------
//--@Save video function
  saveVideo() async {
    print("clled");
    isFileLoading.value = true;
    update();

    Directory directory;
    try {
      // if (Platform.isAndroid) {
      if (await Permission.mediaLibrary.isGranted) {
        directory = (await getExternalStorageDirectory())!;
        String newPath = "";
        print("Recieved Directory: ${directory}");

        List<String> paths = directory.path.split("/");
        print(paths);
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/Download/ticketsheba";
        print("Genarated directory: " + newPath);
        directory = Directory(newPath);
      } else {
        showMyDialog();
        return false;
      }
      File saveFile = File("${directory.path}/${pdfUrl.split("/").last}.pdf");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        print("Genarated directory was not found.Creating new directory.. ");
      }
      if (await directory.exists()) {
        if (await saveFile.exists()) {
          print("Duplicate file detected.Deleting Older version...");
          await saveFile.delete().then((value) async {
            print("Duplicate file deleted.Starting new download");
            await dio.download(pdfUrl, saveFile.path,
                onReceiveProgress: (value1, value2) {
              progress.value = (value1 / value2);
              update();
            });
          });
        } else {
          await dio.download(pdfUrl, saveFile.path,
              onReceiveProgress: (value1, value2) {
            progress.value = (value1 / value2);
            update();
          });
        }

        GlobalSnackbar.success(msg: "File save to ${saveFile.path}");
        loadPdf(saveFile.path);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  downloadNow() async {
    isFileLoading.value = true;
    // loadPdf();
    update();
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
    final response = await http.get(Uri.parse(pdfUrl));
    final bytes = response.bodyBytes;

    final path = await getDownloadsDirectory();
    file.value = File('$path/${pdfUrl.split("/").last}.pdf');
    await file.value.writeAsBytes(bytes, flush: true);
    isFileLoading.value = false;
    update();
    GlobalSnackbar.success(msg: "File save to ${file.value.path}");
  }

  ///---------------------------------------------------------------------------
  /// -- @ permission alert
  ///
  showMyDialog() async {
    return Get.generalDialog(
        barrierDismissible: false,
        barrierLabel: "Can't close this window",
        navigatorKey: null,
        //transitionDuration: Duration(milliseconds: 100),
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4 * anim1.value,
                sigmaY: 4 * anim1.value,
              ),
              child: FadeTransition(
                child: child,
                opacity: anim1,
              ),
            ),
        pageBuilder: (bCtx, anim1, anim2) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.all(16),
              title: Text(
                "Permission required",
                style: TextStyle(
                    // color: Colors.grey.shade200,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              content: Container(
                width: Get.width - 200,
                height: 70,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "We need storage permission to save file and videos on your device. Would you like to give permission?",
                    style: TextStyle(
                        // color: Colors.grey.shade200,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              actions: [
                YesNoButton.yesNoButton(
                    btn1Click: () {
                      saveVideo();
                    },
                    btn2Click: () async {
                      Get.back();
                      await Permission.mediaLibrary.request().then((result) {
                        print("result -> $result");
                        if (result != PermissionStatus.granted) {
                          showMyDialog();
                        } else {
                          saveVideo();
                        }
                      });
                    },
                    btn1Text: "Deny",
                    btn2Text: "Allow",
                    btn1Color: Colors.red.shade400,
                    btn2Color: Colors.green.shade400),
              ],
              // actions: <Widget>[],
            ));
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
