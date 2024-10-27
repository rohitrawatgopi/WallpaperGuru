import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FullScreenRepo {
  static Future<String> downloadAndSaveImage(String imageUrl) async {
    try {
      // Make the HTTP GET request to fetch the image
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Convert response body to Uint8List
        Uint8List imageData = response.bodyBytes;

        // Save the image locally
        final directory = await getApplicationDocumentsDirectory();
        final path =
            '${directory.path}/image.jpg'; // You can change the file name
        final file = File(path);
        print(path);
        // Write the bytes to the file
        await file.writeAsBytes(imageData);
        print('Image saved locally at: $path');

        return path;
      }
      return "";
    } catch (error) {
      print(error);
      return "";
    }
  }
}
