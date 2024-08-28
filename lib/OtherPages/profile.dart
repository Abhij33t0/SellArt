import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellart/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/fetchprofile_api.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
  AppColor apk = AppColor();
  bool isUpdate = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());
  String userid = "";

  @override
  void dispose() {
    _nameController.dispose();
    _mailController.dispose();
    _mobileController.dispose();
    _ageController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
   fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final SharedPreferences prefs = await prefsFuture;
    userid = prefs.getString("userid")!;
    profileController.fetchProfile(userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: apk.secondaryColor,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 25, color: apk.primaryColor),
        ),
        foregroundColor: apk.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Obx(
                () {
              if (profileController.userProfile.value != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Adjust Your Profile",
                      style: TextStyle(
                          color: apk.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox.fromSize(
                      size: const Size.fromRadius(50),
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundImage: AssetImage(
                          // 'assets/images/girl.jpg',
                          'assets/icon.jpg',
                        ),
                      ),
                    ),
                    Text(profileController.userProfile.value!.username ?? 'Name',
                        style:
                        TextStyle(fontSize: 20, color: apk.secondaryColor)),
                    // const Text('Title: Author',
                    //     style: TextStyle(color: Colors.green, fontSize: 20)),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextField(Icons.person, _nameController,
                        profileController.userProfile.value!.username ?? 'Name'),
                    const SizedBox(height: 10),
                    _buildTextField(Icons.email, _mailController,
                        profileController.userProfile.value!.mail ?? 'E-mail'),
                    const SizedBox(height: 10),
                    _buildTextField(Icons.smartphone, _mobileController,
                        profileController.userProfile.value!.mobile ?? 'Mobile No.'),
                    const SizedBox(height: 10),
                    _buildTextField(Icons.business, _ageController,
                        profileController.userProfile.value!.address ?? 'Address'),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => apk.secondaryColor),
                          foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => apk.primaryColor)),
                      onPressed: () {
                        // Get.to(() => const MyHomePage());
                        setState(() {
                          isUpdate = !isUpdate;
                        });
                      },
                      child: isUpdate ? const Text("Save") : const Text("Edit"),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: apk.secondaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: TextStyle(color: apk.secondaryColor),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: apk.secondaryColor,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: apk.secondaryColor),
          fillColor: Colors.white,
          focusColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
