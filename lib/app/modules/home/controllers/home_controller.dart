import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smartsnapper/app/Network/ApiService.dart';
import 'package:smartsnapper/app/models/manual_snap/manual_snap.dart';
import 'package:smartsnapper/app/widgets/permission_dialog.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  Geodesy geodesy = Geodesy();

  List<Polygon> polygones = [];
  List<bool> isSelectedPolygon = List.filled(25, false);
  List<List<LatLng>> coordinates = [];
  List<LatLng> listOfCenterCoordinates = [];
  LatLng centerCoordinates = const LatLng(0, 0);
  String _reportLat = "";
  String _reportLong = "";
  String _reportAlt = "";
  double zoomValue = 17.5;
  String selectedDamageText = "";
  bool isSatellite = false;
  bool isDistance = false;
  MyVector selectedDatum = MyVector("uhrzeit", "datum", "areaseal");
  MapController? mapController;
  set setSatelliteView(bool value) {
    isSatellite = value;
    update();
  }

  set setDistance(bool value) {
    isDistance = value;
    update();
  }

  var selectedIndex = 0;
  int selectedNavIndex = 0;
  int mapIndex = 0;

  double distanceIndex = 10;
  List<MyVector> listOfData = [];
  ManualSnap? manualSnap;
  String datum = "";
  String uhrzeit = "";
  String blxwsg = "";
  String blywsg = "";
  String brxwsg = "";
  String brywsg = "";
  String tlxwsg = "";
  String tlywsg = "";
  String trxwsg = "";
  String trywsg = "";
  String cxwgs = "";
  String cywgs = "";
  bool _captureManualSnap = false;
  bool get captureManualSnap => _captureManualSnap;
  set setManualSnap(bool value) {
    _captureManualSnap = value;
    update();
  }

  void onItemTappedNav(int index) {
    selectedNavIndex = index;
    update();
  }

  set setMapIndex(int value) {
    mapIndex = value;
    update();
  }

  set setDistanceIndex(double value) {
    distanceIndex = value;
    sendManualSnap(isDistanceRelocate: true);
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkPermission();
    sendManualSnap();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
    // Handle screen changes here if necessary
  }

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      //   Get.toNamed('/google-map-integration');
      // }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.dialog(PermissionDialog());
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Get.toNamed('/google-map-integration');
    }
  }

  Future<void> sendManualSnap(
      {bool isRelocate = false,
      String distance = "10",
      bool isDistanceRelocate = false}) async {
    try {
      // print(otp);
      if (isRelocate)
        Get.defaultDialog(
            title: 'Loading', content: const CircularProgressIndicator());
      if (isDistanceRelocate)
        Get.defaultDialog(
            title: 'Loading', content: const CircularProgressIndicator());
      setManualSnap = true;
      distance=distanceIndex.toInt().toString();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: false);
      _reportLat = position.latitude.toString();
      _reportLong = position.longitude.toString();
      _reportAlt = position.altitude.toString();
      // Get.find<HomeController>().empty_list();
      String latLng = "";
      String regioncode;
      latLng = '${position.latitude},${position.longitude}';
      if (position.latitude >= 36.0) {
        regioncode = "rg3";
      } else if (position.latitude < 36.0 && position.latitude > -36.0) {
        regioncode = "rg7";
      } else {
        regioncode = "rg9";
      }
      final resp =
          await ApiService.sendManualSnap(regioncode, latLng, distanceIndex.toString());

      print(resp);
      manualSnap = ManualSnap.fromJson(resp);
      setManualSnap = false;
      manualSnap = ManualSnap.fromJson(resp ?? {});
      polygones = [];
      coordinates = [];
      isSelectedPolygon = List.filled(25, false);
      for (var ele in manualSnap!.csvDataResult!) {
        double latitude1 = double.parse(ele.blywsg ?? "0.0");
        double longitude1 = double.parse(ele.blxwsg ?? "0.0");

        double latitude2 = double.parse(ele.brywsg ?? "0.0");
        double longitude2 = double.parse(ele.brxwsg ?? "0.0");
        double latitude3 = double.parse(ele.trywsg ?? "0.0");
        double longitude3 = double.parse(ele.trxwsg ?? "0.0");

        double latitude4 = double.parse(ele.tlywsg ?? "0.0");
        double longitude4 = double.parse(ele.tlxwsg ?? "0.0");
        double centerLatitude = double.parse(ele.cywgs ?? "0.0");
        double centerLongitude = double.parse(ele.cxwgs ?? "0.0");
        centerCoordinates = LatLng(centerLatitude, centerLongitude);
        listOfCenterCoordinates.add(centerCoordinates);
        listOfData.add(
            MyVector(ele.uhrzeit ?? "", ele.datum ?? "", ele.areaseal ?? ""));
        coordinates.add([
          LatLng(latitude1, longitude1),
          LatLng(latitude2, longitude2),
          LatLng(latitude3, longitude3),
          LatLng(latitude4, longitude4)
        ]);
      }
      coordinates.forEach(((e) {
        polygones.add(Polygon(
          points: e,
          // color: Colors.blue,
          color: isSelectedPolygon[coordinates.indexOf(e)]
              ? Colors.green.shade700
              : Colors.white54,
          borderColor: isSelectedPolygon[coordinates.indexOf(e)]
              ? Colors.green.shade900
              : Color(0xFF00008B).withOpacity(0.5),
          borderStrokeWidth: 1.5,
          isFilled: true,
        ));
      }));
      if (isRelocate) {
        if (distance == "100000") {
          mapController!.move(centerCoordinates, 5.5);
        } else if (distance == "10000") {
          mapController!.move(centerCoordinates, 8.5);
        } else if (distance == "1000") {
          mapController!.move(centerCoordinates, 11.5);
        } else if (distance == "100") {
          mapController!.move(centerCoordinates, 14.5);
        } else if (distance == "10") {
          mapController!.move(centerCoordinates, 17.7);
        }  else {
          mapController!.move(centerCoordinates, 21.5);
        }
        Get.back();
        Get.back();
      }
      // print("Distance is");
      // print(distance);
      if (isDistanceRelocate) {
        if (distance == "100000") {
          mapController!.move(centerCoordinates, 5.5);
        } else if (distance == "10000") {
          mapController!.move(centerCoordinates, 8.5);
        } else if (distance == "1000") {
          mapController!.move(centerCoordinates, 11.5);
        } else if (distance == "100") {
          mapController!.move(centerCoordinates, 14.5);
        } else if (distance == "10") {
          mapController!.move(centerCoordinates, 17.9);
        } else  {
          mapController!.move(centerCoordinates, 21.5);
        }
        Get.back();
        Get.back();
      }
      mapController = MapController();

      update();
      // Get.toNamed('/map-display',arguments: resp);
    } catch (e, stacktrace) {
      // print(stacktrace);
      print(e);
      print(stacktrace);
      // print(e);
    }
  }
}

class MyVector {
  String uhrzeit;
  String datum;
  String areaseal;
  MyVector(this.uhrzeit, this.datum, this.areaseal);
}
