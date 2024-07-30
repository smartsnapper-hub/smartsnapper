import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:smartsnapper/app/modules/home/controllers/home_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          maxZoom: 18.4,
          minZoom: 2,
          onTap: (tapPosition, point) async {
            int selectedIndex = -1;
            print(tapPosition);
            // controller.isSelectedPolygon = List.filled(25, false);
            print("Distance is");
            print(controller.distanceIndex.toString());
            if (controller.distanceIndex.toString() == "100000") {
              controller.mapController!.move(point, 6.3);
            } else if (controller.distanceIndex.toString() == "10000") {
              controller.mapController!.move(point, 9.3);
            } else if (controller.distanceIndex.toString() == "1000") {
              controller.mapController!.move(point, 12.3);
            } else if (controller.distanceIndex.toString() == "100") {
              controller.mapController!.move(point, 15.2);
            } else if (controller.distanceIndex.toString() == "10") {
              print("zrec");
              controller.mapController!.move(point, 18.3);
            } else if (controller.distanceIndex.toString() == "1") {
              controller.mapController!.move(point, 18.3);
            }
            // controller.update();
            controller.polygones.forEach((element) {
              // if point is on the polygon isGeoPointInPolygon iS true
              bool isGeoPointInPolygon =
                  controller.geodesy.isGeoPointInPolygon(point, element.points);
              if (isGeoPointInPolygon == true) {
                print(element.points);
                selectedIndex = controller.polygones.indexOf(element);
                print("Is Selected");
                print(controller.isSelectedPolygon[selectedIndex]);
                if (controller.isSelectedPolygon[selectedIndex] == false) {
                  // controller.isSelectedPolygon = List.filled(25, false);
                  controller.isSelectedPolygon[selectedIndex] = true;

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
                      .listOfCenterCoordinates[selectedIndex].latitude
                      .toString();
                  controller.cxwgs = controller
                      .listOfCenterCoordinates[selectedIndex].longitude
                      .toString();
                  controller.selectedDatum = MyVector(
                      controller.listOfData[selectedIndex].uhrzeit,
                      controller.listOfData[selectedIndex].datum,
                      controller.listOfData[selectedIndex].areaseal);
                } else {
                  
                  // selectedIndex = -1;
                  controller.isSelectedPolygon[selectedIndex]=false;
                  print("Selecting selected");
                }
              }
            });
            if (selectedIndex != -1) {
              controller.polygones = [];
              controller.coordinates.forEach(((e) {
                controller.polygones.add(Polygon(
                  points: e,
                  // color: Colors.blue,
                  color: controller
                          .isSelectedPolygon[controller.coordinates.indexOf(e)]
                      ? Colors.green.shade700.withOpacity(0.7)
                      : Colors.white54,
                  borderColor: controller
                          .isSelectedPolygon[controller.coordinates.indexOf(e)]
                      ? Colors.green.shade900.withOpacity(0.7)
                      : Color(0xFF00008B).withOpacity(0.5),
                  borderStrokeWidth: 1.5,
                  isFilled: true,
                ));
              }));
              controller.update();
            } else {
              controller.isSelectedPolygon = List.filled(25, false);
              controller.polygones = [];
              controller.coordinates.forEach(((e) {
                controller.polygones.add(Polygon(
                  points: e,
                  // color: Colors.blue,
                  color: controller
                          .isSelectedPolygon[controller.coordinates.indexOf(e)]
                      ? Colors.green.shade700
                      : Colors.white54,
                  borderColor: controller
                          .isSelectedPolygon[controller.coordinates.indexOf(e)]
                      ? Colors.green.shade900
                      : Color(0xFF00008B).withOpacity(0.5),
                  borderStrokeWidth: 1.5,
                  isFilled: true,
                ));
              }));
              controller.update();
            }
          },
          center: controller.centerCoordinates,
          zoom: controller.zoomValue,
        ),
        children: [
          (controller.mapIndex == 0)
              ? TileLayer(
                  urlTemplate:
                      'https://mts1.google.com/vt/lyrs=s@186112443&x={x}&y={y}&z={z}',
                  subdomains: [
                    'mt0',
                    'mt1',
                    'mt2',
                    'mt3'
                  ], // No subdomains needed for Google Hybrid tiles
                )
              : (controller.mapIndex == 1)
                  ? TileLayer(
                      urlTemplate:
                          'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                      subdomains: [
                        'mt0',
                        'mt1',
                        'mt2',
                        'mt3'
                      ], // No subdomains needed for Google Hybrid tiles
                    )
                  : TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
          PolygonLayer(polygons: controller.polygones),
        ],
      );
    });
  }
}
