import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sellart/HomePages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
  String userid = "";
  Future<void> loginUser(String mail, String password) async {
    try {
      print(mail);
      print(password);
      final uri = Uri.https('192.168.5.136', '/flutterApp/login.php');
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'mail': mail,
          'password': password,
        }),
      );
      print(uri);
      final SharedPreferences prefs = await prefsFuture;
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        if (responseData['message'] == "Success") {
          Fluttertoast.showToast(msg: "Login Successful");
          prefs.setString('userid', responseData['userID']);
          print(responseData);
          Get.to(() => const MyHomePage());
        } else {
          Fluttertoast.showToast(msg: "Login Failed");
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      Fluttertoast.showToast(msg: "An error occurred");
    }
  }
}
