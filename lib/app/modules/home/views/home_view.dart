import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ticketsheba_superviser/app/modules/home/views/component/custom_component.dart';
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
                  titleText: "Search", bodyText: "Search", onTap: () {});
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
                  SingleChildScrollView(
                    child: Column(
                        children: [1, 2, 3, 4, 5, 6, 7]
                            .map(
                              (e) => Card(
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 50, child: Text("15 May, 23")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                          width: 70,
                                          child: Text("Dhaka-to-Feni")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                          width: 40, child: Text("non-ac")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                          width: 60, child: Text("02:00 AM")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                          width: 50, child: Text("534534")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(width: 50, child: Text("400")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          width: 50,
                                          child: Text("41")),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        width: 250,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Colors.deepPurple),
                                              child: Text("Booking",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color:
                                                      Colors.yellow.shade800),
                                              child: Text("Quick.B",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Colors
                                                      .deepOrange.shade700),
                                              child: Text("StandUp.B",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
