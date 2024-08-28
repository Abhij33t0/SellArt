import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../HomePages/homepage.dart';

class PaintingUploader {
  Future<void> uploadPainting(
      String imagePath, String authorName, String paintingName, String price) async {
    var url = Uri.parse('https://192.168.5.136/flutterApp/upload_painting.php');

    var request = http.MultipartRequest('POST', url)
      ..fields['authorName'] = authorName
      ..fields['paintingName'] = paintingName
      ..fields['price'] = price
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    print('Image Path: $imagePath');
    print('Author Name: $authorName');
    print('Painting Name: $paintingName');
    print('Price: $price');

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print('Response Data: $responseData');
      var decodedData = json.decode(responseData);
      print('Painting uploaded successfully: $decodedData');
      Get.to(() => const MyHomePage());
    } else {
      var responseData = await response.stream.bytesToString();
      print('Failed to upload painting. Response Data: $responseData');
    }
  }
}
