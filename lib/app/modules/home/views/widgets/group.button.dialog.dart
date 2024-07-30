import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smartsnapper/app/modules/home/controllers/home_controller.dart';
import 'package:smartsnapper/app/modules/home/views/widgets/custom.grid.view.dart';
import 'package:smartsnapper/app/modules/home/views/widgets/map.select.widget.dart';

class GroupButtonDialog extends StatelessWidget {
  const GroupButtonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          // height: 300,
          // width: device.width * 0.4,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox( width: 10,),
              Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      onPressed: () async {
                        // controller.setSatelliteView = !controller.isSatellite;
                        await showAlignedDialog(
                                      context: context,
                                      builder: _mapDialogBuilder,
                                      followerAnchor: Alignment.topCenter,
                                      targetAnchor: Alignment.bottomCenter,
                                      barrierColor: Colors.transparent);
                      },
                      icon: const Icon(Icons.layers, size: 35)),
                ),
              ),
              const SizedBox( width: 10,),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                                onPressed: () async {
                                  // await showDialog(context: context, builder: _localDialogBuilder);
                                  await showAlignedDialog(
                                      context: context,
                                      builder: _localDialogBuilder,
                                      followerAnchor: Alignment.topRight,
                                      targetAnchor: Alignment.topLeft,
                                      barrierColor: Colors.transparent);
                                  // controller.setDistance = !controller.isDistance;
                                },
                                icon: const Icon(Icons.grid_3x3, size: 35)),
                          );
                        }),
              const SizedBox( width: 10,),
            ],
          ),
        ),
      );
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