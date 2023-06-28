import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:ticketsheba_superviser/core/extensions/extensions.dart';
import '../../../data/services/prefrences.dart';
import '../../../data/services/repository.dart';

enum ApiCallState { IDLE, FETCHING, DONE }

class HomeController extends GetxController {
  var getRouteState = ApiCallState.IDLE.obs;
  var searchTripState = ApiCallState.IDLE.obs;
  var boardingPoint = <String>[].obs;

  RxMap<String, dynamic> loginData = <String, dynamic>{}.obs;
  var selectedBusType = "--Select bus type--".obs;
  var busType = ["--Select bus type--", "AC", "Non-AC"];
  updateBusType(value) => selectedBusType(value);

  var routeList = <dynamic>[].obs;
  var from = <String>[].obs;
  var to = <String>[].obs;

  var tripDate = DateTime.now().obs;

  RxBool isProfileLoading = false.obs;

  refreshLoginData() {
    loginData.value = Pref.readData(key: Pref.SESSION);
    update();
  }

  Map<String, TextEditingController> inputs = {
    "from": TextEditingController(),
    "to": TextEditingController(),
    "date": TextEditingController(),
    "boarding": TextEditingController(),
  };

  var searchDate = DateTime.now().obs;


  @override
  void onInit() {
    super.onInit();
    loginData.value = Pref.readData(key: Pref.SESSION);
    update();
    getAllRoutes();
    // getAllTrips();
  }

  var boardingId = <int>[].obs;

  getAllRoutes() async {
    loginData.value = Pref.readData(key: Pref.SESSION);
    update();
    try{
      getRouteState(ApiCallState.FETCHING);
      await Repository().getAllRoutes().then((value) {
        boardingPoint.add("Clear");
        value['routes'].forEach((element) {boardingPoint.add(element["name"]);});
        value['routes'].forEach((element) {boardingId.add(element["id"]);});

        getAllTrips();
      });
    }on Exception catch(e){}
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxList<dynamic> busData = <dynamic>[].obs;
  var searchedList = <String>[].obs;
  addSearchlist(){
    searchedList.clear();
    if(inputs['date']!.text.isNotEmpty)
      searchedList.add(inputs['date']!.text);
    if(inputs["boarding"]!.text.isNotEmpty)
      searchedList.add(inputs['boarding']!.text);
    if(selectedBusType.value != "--Select bus type--")
      searchedList.add(selectedBusType.value);
    searchedList.refresh();
    getAllTrips();
  }

  clearData(){
    searchedList.clear();
    searchedList.refresh();
    inputs['date']!.text = "";
    inputs['boarding']!.text = "";
    selectedBusType("--Select bus type--");
    getAllTrips();
  }



  getAllTrips() async {
    // loginData.value = Pref.readData(key: Pref.SESSION);
    // update();
    try {
      getRouteState(ApiCallState.FETCHING);
      await Repository().getAllTrip({
        "assign_date": inputs['date']!.text.toString(),
        "route_id": boardingId[boardingPoint.indexWhere((element) => element == inputs['boarding']!.text)],
        "bus_type": selectedBusType == "--Select bus type--" ? "" : selectedBusType.value.toLowerCase()
      }).then((response) {
        // routeList(response as List<dynamic>);
        busData(response['assign_trips']['data'] as List<dynamic>);
        // from.clear();
        // to.clear();
        // for (dynamic obj in routeList) {
        //   from.add(obj['start_point'] ?? "");
        //   to.add(obj['end_point'] ?? "");
        // }
        // from.removeDuplicates();
        // to.removeDuplicates();
        getRouteState(ApiCallState.DONE);
      });
    } on Exception catch (e) {
      getRouteState(ApiCallState.DONE);
      Get.rawSnackbar(message: e.toString(), backgroundColor: Colors.red);
    }
  }

  // onSearchTrip() async {
  //   if (isValidate()) {
  //     try {
  //       searchTripState(ApiCallState.FETCHING);
  //       final body = {
  //         "fromlocation": inputs['from']?.text,
  //         "tolocation": inputs['to']?.text,
  //         "assign_date": DateFormat("yyyy-MM-dd").format(tripDate.value),
  //       };
  //       final response = await Repository().getTripList(map: body);
  //       searchTripState(ApiCallState.DONE);

  //       if (response['status'] == true &&
  //           (response['data'] as List).isNotEmpty) {
  //         final args = {
  //           "from": inputs['from']?.text,
  //           "to": inputs['to']?.text,
  //           "date": tripDate.value.ddMMyyyy,
  //           "data": response['data'] as List,
  //         };
  //         Get.toNamed(Routes.BUSS_LIST_PAGE, arguments: args);
  //       } else {
  //         Get.rawSnackbar(
  //             message: "No trip found!", backgroundColor: Colors.red);
  //       }
  //     } on Exception catch (e) {
  //       getRouteState(ApiCallState.IDLE);
  //       Get.rawSnackbar(message: e.toString(), backgroundColor: Colors.red);
  //     }
  //   } else {
  //     Get.rawSnackbar(
  //         message: "Input fields are required!", backgroundColor: Colors.red);
  //   }
  // }

  bool isValidate() {
    if ((inputs['from']?.text ?? "").isEmpty) {
      print("empty from field");
      return false;
    } else if ((inputs['to']?.text ?? "").isEmpty) {
      print("empty to field");
      return false;
    }
    return true;
  }
}
