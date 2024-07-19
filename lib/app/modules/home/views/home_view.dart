import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:smartsnapper/app/modules/home/controllers/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return BottomNavigationBar(
          // selectedLabelStyle:const TextStyle(color: Colors.yellow),
          // unselectedLabelStyle:const TextStyle(color: Colors.yellow),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.article,
                // color: Colors.grey.shade600,
              ),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                // color: Colors.grey.shade600,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.transparent,
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
                // color: Colors.grey.shade600,
              ),
              label: 'Logbook',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
                // color: Colors.grey.shade600,
              ),
              label: 'Calendar',
            ),
          ],
          currentIndex: controller.selectedIndex,
          selectedItemColor: Colors.orange.shade800,
          onTap: controller.onItemTapped,
        );
      },
    );
  }
}

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      print("Coordinates are");
      print(controller.coordinates.isEmpty);
      print(controller.polygones);
      return Scaffold(
         key: _scaffoldKey,
          backgroundColor: Colors.white,
          //  bottomNavigationBar: BottomNavBar(),
          drawerEdgeDragWidth: 20.0,
          // appBar: AppBar(),
          floatingActionButton: GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    // spreadRadius: 1,
                    blurRadius: 5
                )
                ],
                color: Colors.orange.shade400,
                // borderRadius: BorderRadius.circular(70),
                shape: BoxShape.circle
                ),
              child: const Icon(Icons.add, size: 20,)
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavBar(),
          // bottomNavigationBar: BottomAppBar(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Expanded(
          //         child: IconButton(
          //             onPressed: () {}, icon: const Icon(Icons.home)),
          //       ),
          //       Expanded(
          //         child: IconButton(
          //             onPressed: () {}, icon: const Icon(Icons.show_chart)),
          //       ),
          //       Expanded(child: Text('')),
          //       Expanded(
          //         child:
          //             IconButton(onPressed: () {}, icon: const Icon(Icons.tab)),
          //       ),
          //       Expanded(
          //         child: IconButton(
          //             onPressed: () {}, icon: const Icon(Icons.settings)),
          //       ),
          //     ],
          //   ),
          // ),
          // endDrawer: const DrawerScreen(),
          body: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: (controller.coordinates.isEmpty)
                    // ? Text("Test Coordinates")

                        ? const FlutterMapWidget()
                        : FlutterMap(
                          mapController: controller.mapController,
                            options: MapOptions(
                              onTap: (tapPosition, point) async {
                                int selectedIndex = -1;
                                print(tapPosition);
                                controller.isSelectedPolygon=List.filled(25, false);
                                controller.mapController!.move(point, 18.3);
                                // controller.update();
                                controller.polygones.forEach((element) {
                                  // if point is on the polygon isGeoPointInPolygon iS true
                                  bool isGeoPointInPolygon = controller.geodesy
                                      .isGeoPointInPolygon(
                                          point, element.points);
                                  if (isGeoPointInPolygon == true) {
                                    print(element.points);
                                    selectedIndex =
                                        controller.polygones.indexOf(element);
                                    controller
                                            .isSelectedPolygon[selectedIndex] =
                                        true;

                                    controller.blywsg = controller
                                        .coordinates[selectedIndex][0].latitude
                                        .toString();
                                    controller.blxwsg = controller
                                        .coordinates[selectedIndex][0].longitude
                                        .toString();

                                    controller.brywsg = controller
                                        .coordinates[selectedIndex][1].latitude
                                        .toString();
                                    controller.brxwsg = controller
                                        .coordinates[selectedIndex][1].longitude
                                        .toString();

                                    controller.trywsg = controller
                                        .coordinates[selectedIndex][2].latitude
                                        .toString();
                                    controller.trxwsg = controller
                                        .coordinates[selectedIndex][2].longitude
                                        .toString();

                                    controller.tlywsg = controller
                                        .coordinates[selectedIndex][3].latitude
                                        .toString();
                                    controller.tlxwsg = controller
                                        .coordinates[selectedIndex][3].longitude
                                        .toString();

                                    controller.cywgs = controller
                                        .listOfCenterCoordinates[selectedIndex]
                                        .latitude
                                        .toString();
                                    controller.cxwgs = controller
                                        .listOfCenterCoordinates[selectedIndex]
                                        .longitude
                                        .toString();
                                    controller.selectedDatum = MyVector(
                                        controller
                                            .listOfData[selectedIndex].uhrzeit,
                                        controller
                                            .listOfData[selectedIndex].datum,
                                        controller.listOfData[selectedIndex]
                                            .areaseal);
                                  }
                                });
                                if (selectedIndex != -1) {
                                  controller.polygones = [];
                                  controller.coordinates.forEach(((e) {
                                    controller.polygones.add(Polygon(
                                      points: e,
                                      // color: Colors.blue,
                                      color: controller.isSelectedPolygon[
                                              controller.coordinates.indexOf(e)]
                                          ? Colors.green.shade700
                                          : Colors.white54,
                                      borderColor: controller.isSelectedPolygon[
                                              controller.coordinates.indexOf(e)]
                                          ? Colors.green.shade900
                                          : Colors.blue,
                                      borderStrokeWidth: 3.0,
                                      isFilled: true,
                                    ));
                                  }));
                                  controller.update();
                                  // await Get.defaultDialog(
                                  //     title: "Actions",
                                  //     content: const ShowDialog());
                                  
                                  // controller.isSelectedPolygon[selectedIndex] =
                                  //     false;
                                  
                                  
                                }else{
                                  controller.isSelectedPolygon=List.filled(25, false);
                                  controller.polygones = [];
                                  controller.coordinates.forEach(((e) {
                                    controller.polygones.add(Polygon(
                                      points: e,
                                      // color: Colors.blue,
                                      color: controller.isSelectedPolygon[
                                              controller.coordinates.indexOf(e)]
                                          ? Colors.green.shade700
                                          : Colors.white54,
                                      borderColor: controller.isSelectedPolygon[
                                              controller.coordinates.indexOf(e)]
                                          ? Colors.green.shade900
                                          : Colors.blue,
                                      borderStrokeWidth: 3.0,
                                      isFilled: true,
                                    ));
                                  }));
                                  controller.update();
                                }
                              },
                              center: controller.centerCoordinates,
                              zoom: 17.5,
                            ),
                            children: [
                              (controller.isSatellite)?TileLayer(
                                urlTemplate:
                                    'https://mts1.google.com/vt/lyrs=s@186112443&x={x}&y={y}&z={z}',
                                subdomains: [
                                  'mt0',
                                  'mt1',
                                  'mt2',
                                  'mt3'
                                ], // No subdomains needed for Google Hybrid tiles
                              )
                              :TileLayer(
                                urlTemplate:
                                    'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                                subdomains: [
                                  'mt0',
                                  'mt1',
                                  'mt2',
                                  'mt3'
                                ], // No subdomains needed for Google Hybrid tiles
                              ),
                              PolygonLayer(polygons: controller.polygones),
                            ],
                          ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: IconButton(onPressed: (){
                      _scaffoldKey.currentState?.openDrawer();
                    }, icon: const Icon(
                      Icons.menu,
                      size: 35
                      
                    )),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: (controller.isSatellite)?Colors.white:Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: IconButton(onPressed: (){
                      controller.setSatelliteView=!controller.isSatellite;
                    }, icon: const Icon(
                      Icons.layers,
                      size: 35
                    )),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: IconButton(onPressed: () async {
                      await Get.defaultDialog(title: "Actions",content: const ShowDialog2());
                    }, icon: const Icon(
                      Icons.near_me,
                      size: 35
                      
                    )),
                  ),
                ],
              ),
            ],
          ));
    });
  }
}

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
      builder: (controller) {
        return FlutterMap(
                              
                                options: MapOptions(
                                  onTap: (tapPosition, point) async {
                                    
                                  },
                                  center: LatLng(51.5, 0.1276),
                                  zoom: 12,
                                ),
                                children: [
                                  (controller.isSatellite)?TileLayer(
                                    urlTemplate:
                                        'https://mts1.google.com/vt/lyrs=s@186112443&x={x}&y={y}&z={z}',
                                    subdomains: [
                                      'mt0',
                                      'mt1',
                                      'mt2',
                                      'mt3'
                                    ], // No subdomains needed for Google Hybrid tiles
                                  )
                                  :TileLayer(
                                    urlTemplate:
                                        'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                                    subdomains: [
                                      'mt0',
                                      'mt1',
                                      'mt2',
                                      'mt3'
                                    ], // No subdomains needed for Google Hybrid tiles
                                  ),
                                  PolygonLayer(polygons: controller.polygones),
                                ],
                              );
      }
    );
  }
}

class ShowDialog2 extends StatelessWidget {
  const ShowDialog2({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Dialog(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700, // Background color
                      textStyle:
                          const TextStyle(color: Colors.white), // Text color
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Rectangular shape
                      ),
                    ),
                    onPressed: () async {
                      await controller.sendManualSnap(isDialog: true);
                      Get.back();
                    },
                    child: const Text(
                      'Relocate',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}


class ShowDialog extends StatelessWidget {
  const ShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Dialog(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700, // Background color
                    textStyle:
                        const TextStyle(color: Colors.white), // Text color
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Rectangular shape
                    ),
                  ),
                  onPressed: () async {
                    await controller.sendManualSnap(isDialog: true);
                    Get.back();
                  },
                  child: const Text(
                    'Relocate',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500, // Background color
                    textStyle:
                        const TextStyle(color: Colors.white), // Text color
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Rectangular shape
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/snap-screen');
                  },
                  child: const Text(
                    'SNAP',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      );
    });
  }
}

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('News Screen'));
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Chat Screen'));
  }
}

class PlusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Plus Screen'));
  }
}

class LogbookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Logbook Screen'));
  }
}

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Calendar Screen'));
  }
}
