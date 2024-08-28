import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../OtherPages/login.dart';

class RegistrationController extends GetxController {
  Future<void> registerUser({
    required String username,
    required String password,
    required String mail,
    required String mobile,
    required String address,
  }) async {
    try {
      final uri = Uri.https('192.168.5.136', '/flutterApp/registration.php');
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'mail': mail,
          'mobile': mobile,
          'address': address,
        }),
      );
      print(uri);
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        print('Response body: $responseBody');
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        print(responseData);
        if (responseData['message'] == "Success") {
          Fluttertoast.showToast(msg: "Registration Successful");
          Get.to(() => Login());
        } else {
          Fluttertoast.showToast(msg: "Username Already Exist");
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}
