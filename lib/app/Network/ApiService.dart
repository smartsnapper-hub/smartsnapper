import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../modules/home/controllers/home_controller.dart';
import 'ApiMethod.dart';

class ApiService {
  static var client = http.Client();

  static Future sendManualSnap(String regioncode, String latlng) async {
    // Replace with the URL of your Node.js API endpoint
    String createOrderAPI = ApiMethods.getManualSnap();

    // Replace with your actual image file data in base64 format
    // final String base64Image = '...';

    DateTime today = DateTime.now();
    String month = (today.month < 10)
        ? '0' + today.month.toString()
        : today.month.toString();
    String minute = (today.minute < 10)
        ? '0' + today.minute.toString()
        : today.minute.toString();
    String second = (today.second < 10)
        ? '0' + today.second.toString()
        : today.second.toString();
    String hour =
        (today.hour < 10) ? '0' + today.hour.toString() : today.hour.toString();
    String dateStr = "${today.day}-${month}-${today.year}";
    String timeStr = "${hour}:${minute}:${second}";
    print(dateStr);
    print(timeStr);

    final Map<String, dynamic> requestBody = {
      "function": "point-to-grid",
      "order": "1",
      "position": "1",
      "region_code": regioncode,
      "column1": "6",
      "rings": "2",
      "separator": "SEMICOLON",
      "size": "10",
      "srid": "3035",
      "json_data": [
        {
          "Int-Nr": " 6808",
          "Name": "snapper point",
          "Modell": "Snap",
          "Kennzeichen": "Test01",
          "Datum": "01.05.2024",
          "lat+long": latlng,
          "Uhrzeit": "00:01"
        }
      ],
      "with Centroid": true,
      "with square": true
    };
    print(requestBody);
    try {
      final response = await http.post(
        Uri.parse(createOrderAPI),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('File saved successfully.');
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print('Failed to save file. Error: ${response.statusCode}');
        return false;
      }
      // return false;
    } catch (e) {
      print('Error occurred while calling the API: $e');
      rethrow;
    }
  }
}
