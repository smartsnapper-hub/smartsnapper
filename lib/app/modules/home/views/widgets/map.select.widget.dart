import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartsnapper/app/modules/home/controllers/home_controller.dart';

class MapSelectView extends StatelessWidget {
  final List<GridItem> items = [
    GridItem(index: 0, mapImage: 'assets/images/satellite_image.jpg'),
    GridItem(index: 1, mapImage: 'assets/images/satellite_image.jpg'),
    GridItem(index: 2, mapImage: 'assets/images/base_map.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Container(
          width: device.width * 0.4,
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
                  controller.setMapIndex = item.index;
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset(
                            item.mapImage,
                          ).image,
                          fit: BoxFit.cover),
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(item.mapImage),
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
  int index;
  final String mapImage;
  GridItem({required this.index, required this.mapImage});
}
