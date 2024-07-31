import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartsnapper/app/modules/home/controllers/home_controller.dart';

class CustomGridView extends StatelessWidget {
  final List<GridItem> items = [
    GridItem(
        icon: Icons.square_outlined,
        text: '100km',
        iconSize: 20.0,
        distanceIndex: 100000),
    GridItem(
        icon: Icons.square_outlined,
        text: '10km',
        iconSize: 18.0,
        distanceIndex: 10000),
    GridItem(
        icon: Icons.square_outlined,
        text: '1km',
        iconSize: 16.0,
        distanceIndex: 1000),
    GridItem(
        icon: Icons.square_outlined,
        text: '100m',
        iconSize: 14.0,
        distanceIndex: 100),
    GridItem(
        icon: Icons.square_outlined,
        text: '10m',
        iconSize: 12.0,
        distanceIndex: 10),
    GridItem(
        icon: Icons.square_outlined,
        text: '1m',
        iconSize: 10.0,
        distanceIndex: 1),
    GridItem(
        icon: Icons.square_outlined,
        text: '100mm',
        iconSize: 8.0,
        distanceIndex: 0.1),
    GridItem(
        icon: Icons.square_outlined,
        text: '10mm',
        iconSize: 6.0,
        distanceIndex: 0.01),
    GridItem(
        icon: Icons.square_outlined,
        text: '1mm',
        iconSize: 4.0,
        distanceIndex: 0.001),


  ];

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          // height: 300,
          width: device.width * 0.6,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            padding: const EdgeInsets.all(2.0),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            children: items.map((item) {
              return GestureDetector(
                onTap: () {
                  controller.setDistanceIndex = item.distanceIndex;
                },
                child: Container(
                  color: Colors.green.shade500.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        item.icon,
                        size: item.iconSize,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        item.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class GridItem {
  final IconData icon;
  final String text;
  final double iconSize;
  final double distanceIndex;
  GridItem(
      {required this.icon,
      required this.text,
      required this.iconSize,
      required this.distanceIndex});
}
