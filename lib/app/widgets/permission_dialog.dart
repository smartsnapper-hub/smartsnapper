import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.add_location_alt_rounded,
                color: Theme.of(context).primaryColor, size: 100),
            SizedBox(height: 10),
            Text(
              'you denied location permission'.tr,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: Size(1, 50),
                  ),
                  child: Text('close'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  await Geolocator.openAppSettings();
                  Navigator.pop(context);
                },
                child: Text("Settings"),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
