import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ticketsheba_superviser/app/modules/home/views/component/custom_component.dart';
import 'package:ticketsheba_superviser/app/routes/app_pages.dart';
import 'package:ticketsheba_superviser/global/widget/global_loading.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/extra/app_assets.dart';
import '../controllers/home_controller.dart';
import 'component/custom_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.MAIN_LOGO,
          height: 30,
          width: Get.width / 2,
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawer.drawer(controller),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          ZoomTapAnimation(
            onTap: () {
              HomeComponent.normalAlert(
                  titleText: "Search", bodyText: "Search", onTap: () {}, controller: controller);
            },
            child: Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400, width: .7)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Search trip",
                        style: TextStyle(color: Colors.grey.shade800)),
                    Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                    )
                  ]),
            ),
          ),
          //MARK:-- home list view
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.green.shade500),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(width: 50, child: Text("DATE")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 70, child: Text("ROUTE")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 40, child: Text("TYPE")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 60, child: Text("DEPARTURE TIME")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 50, child: Text("COACH NO")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 50, child: Text("FARE")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 50, child: Text("AVAILABLE SEATS")),
                        SizedBox(
                          width: 12,
                        ),
                        Container(width: 250, child: Text("Actions")),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => controller.getRouteState == ApiCallState.FETCHING
                        ? GlobalLoadng.loadingOnly()
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(children: getTripList()),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> getTripList() {
    List<Widget> list = [];
    controller.busData.forEach((element) {
      list.add(Card(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(width: 50, child: Text("${element['assign_date']}")),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 70,
                  child:
                      Text("${element['trip']['title'].split(" / ").first}")),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 40, child: Text("${element['trip']['bus_type']}")),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 60,
                  child: Text("${element['trip']['departure_time']}")),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 50, child: Text("${element['trip']['coach_no']}")),
              SizedBox(
                width: 12,
              ),
              Container(width: 50, child: Text("${element['trip']['price']}")),
              SizedBox(
                width: 12,
              ),
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  child: Text(
                      "${element['trip']['fleet']['seats'] - element['sold_ticket'].length}")),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeComponent.homeButtons(
                        btnText: "Booking",
                        color: Colors.deepPurple,
                        onTap: () {
                          // Get.toNamed(Routes.BOOKING_PAGE);
                          Get.toNamed(Routes.SEAT_DETAILS, arguments: {
                            "book-type": "normal",
                            'tirp-id': element['id'],
                            'trip': element,
                          });
                        }),
                    HomeComponent.homeButtons(
                        btnText: "Quick.B",
                        color: Colors.yellow.shade800,
                        onTap: () {
                          // Get.toNamed(Routes.QUICK_BOOKING_PAGE);
                          Get.toNamed(Routes.SEAT_DETAILS, arguments: {
                            "book-type": "quick",
                            'tirp-id': element['id'],
                            'trip': element,
                          });
                        }),
                    HomeComponent.homeButtons(
                        btnText: "StandUp.B",
                        color: Colors.deepOrange.shade700,
                        onTap: () {
                          Get.toNamed(Routes.STANDUP_PAGE, arguments: element);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    });
    return list;
  }
}
