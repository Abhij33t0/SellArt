// import 'dart:convert';
// import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:sellart/ApiModel/profilemodel.dart';
//
// class ProfileController extends GetxController {
//   Rxn<UserProfile> userProfile = Rxn<UserProfile>();
// // UserProfile? userProfile;
//
//   Future<UserProfile?> fetchProfile(String username) async {
//     try {
//       final uri = Uri.https('172.16.2.36', '/flutterApp/fetchProfile.php');
//       final response = await http.post(
//         uri,
//         headers: {
//           HttpHeaders.contentTypeHeader: 'application/json',
//         },
//         body: jsonEncode({
//           'username': username,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final String responseBody = response.body;
//         final Map<String, dynamic> responseData = jsonDecode(responseBody);
//         print(responseData);
//         if (responseData.containsKey('profile')) {
//           final userProfileJson = responseData['profile'];
//            userProfile = UserProfile.fromJson(userProfileJson);
//           return userProfile;
//         } else {
//           Fluttertoast.showToast(msg: "Profile not found");
//         }
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//       Fluttertoast.showToast(msg: "An error occurred");
//     }
//     return null;
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sellart/ApiModel/profilemodel.dart';

class ProfileController extends GetxController {
  Rxn<UserProfile> userProfile = Rxn<UserProfile>(); // Ensure this is observable

  Future<void> fetchProfile(String userid) async {
    try {
      final uri = Uri.https('192.168.5.136', '/flutterApp/fetchProfile.php');
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'userid': userid,
        }),
      );

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        print(responseData);
        if (responseData.containsKey('profile')) {
          final userProfileJson = responseData['profile'];
          userProfile.value = UserProfile.fromJson(userProfileJson);
        } else {
          Fluttertoast.showToast(msg: "Profile not found");
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
