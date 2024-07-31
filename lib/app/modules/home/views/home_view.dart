import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:smartsnapper/app/modules/home/controllers/home_controller.dart';
import 'package:smartsnapper/app/modules/home/views/map_widget.dart';
import 'package:smartsnapper/app/modules/home/views/widgets/custom.grid.view.dart';
import 'package:smartsnapper/app/modules/home/views/widgets/group.button.dialog.dart';
// import 'package:smartsnapper/app/modules/home/views/widgets/group.dialog.dart';

import 'package:smartsnapper/app/modules/home/views/widgets/map.select.widget.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return BottomNavigationBar(
          selectedLabelStyle: TextStyle(
              color: Colors.orange.shade800, fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(
              color: Colors.green.shade700, fontWeight: FontWeight.w700),
          type: BottomNavigationBarType.fixed,
          items: const [
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
          selectedItemColor: Colors.green.shade700,
          unselectedItemColor: Colors.grey.shade700,
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
      final device = MediaQuery.of(context).size;
      return Scaffold(
          extendBody: true,
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          //  bottomNavigationBar: BottomNavBar(),
          drawerEdgeDragWidth: 20.0,
          // appBar: AppBar(),
          floatingActionButton: GestureDetector(
            onTap: () {},
            child: Container(
              width: 75,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        // spreadRadius: 1,
                        blurRadius: 5)
                  ],
                  color: Colors.green.shade300..withOpacity(0.7),
                  image: DecorationImage(
                      image:
                          Image.asset('assets/images/logo_button.jpeg').image),
                  shape: BoxShape.circle),
              child: Image.asset(
                'assets/images/logo_button.jpeg',
                scale: 1000,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // bottomNavigationBar: BottomNavBar(),
          bottomNavigationBar: BottomAppBar(
            // color: Colors.transparent,
            height: 100,
            // surfaceTintColor: Colors.transparent,
            shape: const CircularNotchedRectangle(),
            notchMargin: 15.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.onItemTappedNav(0),
                        icon: const Icon(
                          Icons.home,
                          size: 30,
                        ),
                        color: controller.selectedNavIndex == 0
                            ? Colors.green.shade700.withOpacity(0.7)
                            : Colors.grey.shade700,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 13,
                            color: controller.selectedNavIndex == 0
                                ? Colors.green.shade700.withOpacity(0.7)
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.onItemTappedNav(1),
                        icon: const Icon(
                          Icons.show_chart,
                          size: 30,
                        ),
                        color: controller.selectedNavIndex == 1
                            ? Colors.green.shade700.withOpacity(0.7)
                            : Colors.grey.shade700,
                      ),
                      Text(
                        'Chart',
                        style: TextStyle(
                            fontSize: 13,
                            color: controller.selectedNavIndex == 1
                                ? Colors.green.shade700.withOpacity(0.7)
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                // const Expanded(child: SizedBox.shrink()),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        'Map',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600
                            // controller.selectedNavIndex == 1
                            //     ? Colors.orange.shade800
                            //     :

                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.onItemTappedNav(2),
                        icon: const Icon(
                          Icons.tab,
                          size: 30,
                        ),
                        color: controller.selectedNavIndex == 2
                            ? Colors.green.shade700.withOpacity(0.7)
                            : Colors.grey.shade700,
                      ),
                      Text(
                        'Tabs',
                        style: TextStyle(
                            fontSize: 13,
                            color: controller.selectedNavIndex == 2
                                ? Colors.green.shade700.withOpacity(0.7)
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.onItemTappedNav(3),
                        icon: const Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        color: controller.selectedNavIndex == 3
                            ? Colors.green.shade700.withOpacity(0.7)
                            : Colors.grey.shade700,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 13,
                            color: controller.selectedNavIndex == 3
                                ? Colors.green.shade700.withOpacity(0.7)
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                        : const MapWidget(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(right: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          icon: const Icon(Icons.menu, size: 35)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Builder(builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: IconButton(
                            onPressed: () async {
                              // await showDialog(context: context, builder: _localDialogBuilder);
                              // await showAlignedDialog(
                              //     context: context,
                              //     builder: _appsDialogBuilder,
                              //     followerAnchor: Alignment.centerRight,
                              //     targetAnchor: Alignment.centerLeft,
                              //     barrierColor: Colors.transparent);
                              controller.setDistance = !controller.isDistance;
                            },
                            icon: const Icon(Icons.apps, size: 35)),
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            // await Get.defaultDialog(title: "Actions",content: const ShowDialog2());
                            await controller.sendManualSnap(isRelocate: true);
                          },
                          icon: const Icon(Icons.near_me, size: 35)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (controller.isDistance)
                      Builder(
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                // controller.setSatelliteView = !controller.isSatellite;
                                await showAlignedDialog(
                                    context: context,
                                    builder: _mapDialogBuilder,
                                    followerAnchor: Alignment.centerRight,
                                    targetAnchor: Alignment.centerLeft,
                                    barrierColor: Colors.transparent);
                              },
                              icon: const Icon(Icons.layers, size: 35)),
                        ),
                      ),
                    if (controller.isDistance)
                      const SizedBox(
                        height: 15,
                      ),
                    if (controller.isDistance)
                      Builder(builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                // await showDialog(context: context, builder: _localDialogBuilder);
                                await showAlignedDialog(
                                    context: context,
                                    builder: _localDialogBuilder,
                                    followerAnchor: Alignment.centerRight,
                                    targetAnchor: Alignment.centerLeft,
                                    barrierColor: Colors.transparent);
                                // controller.setDistance = !controller.isDistance;
                              },
                              icon: const Icon(Icons.grid_3x3, size: 35)),
                        );
                      }),
                    const SizedBox(
                      height: 15,
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     if (controller.isDistance)
                    //       Container(
                    //         width: device.width * 0.6,
                    //         decoration: BoxDecoration(
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black.withOpacity(0.5),
                    //               spreadRadius: 2,
                    //               blurRadius: 4,
                    //               offset: const Offset(0, 1),
                    //             ),
                    //           ],
                    //           color: (controller.isDistance)
                    //               ? Colors.white
                    //               : Colors.grey.shade300,
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 4, vertical: 8),
                    //         child: SingleChildScrollView(
                    //           scrollDirection: Axis.horizontal,
                    //           child: Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: [
                    //               const SizedBox(
                    //                 width: 10,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   controller.setDistanceIndex = 10;
                    //                 },
                    //                 child: Container(
                    //                   width: 42,
                    //                   height: 35,
                    //                   decoration: BoxDecoration(
                    //                     color: Colors.white,
                    //                     borderRadius: BorderRadius.circular(5),
                    //                   ),
                    //                   child: const Center(
                    //                       child: Text(
                    //                     "10m",
                    //                     style: TextStyle(
                    //                         fontSize: 16,
                    //                         color: Colors.green,
                    //                         fontWeight: FontWeight.w800),
                    //                   )),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 width: 10,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   controller.setDistanceIndex = 100;
                    //                 },
                    //                 child: Container(
                    //                   width: 50,
                    //                   height: 35,
                    //                   decoration: BoxDecoration(
                    //                     // image: DecorationImage(
                    //                     //     image: Image.asset(
                    //                     //       'assets/images/100_img.png',
                    //                     //     ).image,
                    //                     //     fit: BoxFit.fitWidth),
                    //                     color: Colors.white,
                    //                     borderRadius: BorderRadius.circular(5),
                    //                   ),
                    //                   child: const Center(
                    //                       child: Text(
                    //                     "100m",
                    //                     style: TextStyle(
                    //                         fontSize: 16,
                    //                         color: Colors.green,
                    //                         fontWeight: FontWeight.w800),
                    //                   )),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 width: 10,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   controller.setDistanceIndex = 1000;
                    //                 },
                    //                 child: Container(
                    //                   width: 40,
                    //                   height: 35,
                    //                   decoration: BoxDecoration(
                    //                     // image: DecorationImage(
                    //                     //     image: Image.asset(
                    //                     //       'assets/images/1000_img.png',
                    //                     //     ).image,
                    //                     //     fit: BoxFit.fitWidth),
                    //                     color: Colors.white,
                    //                     borderRadius: BorderRadius.circular(5),
                    //                   ),
                    //                   child: const Center(
                    //                       child: Text(
                    //                     "1km",
                    //                     style: TextStyle(
                    //                         fontSize: 16,
                    //                         color: Colors.green,
                    //                         fontWeight: FontWeight.w800),
                    //                   )),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 width: 10,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   controller.setDistanceIndex = 10000;
                    //                 },
                    //                 child: Container(
                    //                   width: 50,
                    //                   height: 35,
                    //                   decoration: BoxDecoration(
                    //                     // image: DecorationImage(
                    //                     //     image: Image.asset(
                    //                     //       'assets/images/10000_img.png',
                    //                     //     ).image,
                    //                     //     fit: BoxFit.fitWidth),
                    //                     color: Colors.white,
                    //                     borderRadius: BorderRadius.circular(5),
                    //                   ),
                    //                   child: const Center(
                    //                       child: Text(
                    //                     "10km",
                    //                     style: TextStyle(
                    //                         fontSize: 16,
                    //                         color: Colors.green,
                    //                         fontWeight: FontWeight.w800),
                    //                   )),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 width: 10,
                    //               ),
                    //               GestureDetector(
                    //                 onTap: () {
                    //                   controller.setDistanceIndex = 100000;
                    //                 },
                    //                 child: Container(
                    //                   width: 55,
                    //                   height: 35,
                    //                   decoration: BoxDecoration(
                    //                     // image: DecorationImage(
                    //                     //     image: Image.asset(
                    //                     //       'assets/images/10000_img.png',
                    //                     //     ).image,
                    //                     //     fit: BoxFit.fitWidth),
                    //                     color: Colors.white,
                    //                     borderRadius: BorderRadius.circular(5),
                    //                   ),
                    //                   child: const Center(
                    //                       child: Text(
                    //                     "100km",
                    //                     style: TextStyle(
                    //                         fontSize: 16,
                    //                         color: Colors.green,
                    //                         fontWeight: FontWeight.w800),
                    //                   )),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 width: 10,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     if (controller.isDistance)
                    //       const SizedBox(
                    //         width: 15,
                    //       ),

                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}

WidgetBuilder get _localDialogBuilder {
  return (BuildContext context) {
    return CustomGridView();
  };
}

WidgetBuilder get _mapDialogBuilder {
  return (BuildContext context) {
    return MapSelectView();
  };
}

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return FlutterMap(
        options: MapOptions(
          maxZoom: 18.4,
          onTap: (tapPosition, point) async {},
          center: const LatLng(51.5, 0.1276),
          zoom: 12,
        ),
        children: [
          (controller.isSatellite)
              ? TileLayer(
                  urlTemplate:
                      'https://mts1.google.com/vt/lyrs=s@186112443&x={x}&y={y}&z={z}',
                  subdomains: const [
                    'mt0',
                    'mt1',
                    'mt2',
                    'mt3'
                  ], // No subdomains needed for Google Hybrid tiles
                )
              : TileLayer(
                  urlTemplate:
                      'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                  subdomains: const [
                    'mt0',
                    'mt1',
                    'mt2',
                    'mt3'
                  ], // No subdomains needed for Google Hybrid tiles
                ),
          PolygonLayer(polygons: controller.polygones),
        ],
      );
    });
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
                      // await controller.sendManualSnap(isDialog: true);
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
                    await controller.sendManualSnap(isRelocate: true);
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
    return const Center(child: Text('Calendar Screen'));
  }
}



// WidgetBuilder get _appsDialogBuilder {
//   return (BuildContext context) {
//     return const GroupButtonDialog();
//   };
// }
