import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellart/API/fetchprofile_api.dart';
import 'package:sellart/HomePages/utils/custombottombar.dart';
import 'package:sellart/OtherPages/login.dart';
import 'package:sellart/OtherPages/profile.dart';
import 'package:sellart/OtherPages/t_n_c.dart';
import 'package:sellart/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/fetchpaintings_api.dart';
import '../API/upload_painting_api.dart';
import '../ApiModel/fetchpaintingsmodel.dart';
import '../OtherPages/privacy.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isTheme = true;
  AppColor apk = AppColor();
  int _selectedIndex = 0;
  XFile? _image;
  List<Painting> _paintings = [];
  final ImagePicker _picker = ImagePicker();
  final PaintingUploader _paintingUploader = PaintingUploader();
  ProfileController profileController = Get.put(ProfileController());

  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _paintingNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();


  @override
  void initState() {
    super.initState();
    _fetchPaintings();
    _requestPermission(Permission.accessMediaLocation);
  }

  Future<void> logout() async{
    final SharedPreferences prefs = await prefsFuture;
    setState(() {
      prefs.remove('userid');
    });
    Get.offAll(() => Login());
  }

  Future<void> _fetchPaintings() async {
    final SharedPreferences prefs = await prefsFuture;
    try {
      List<Painting> paintings = await fetchPaintings();
      setState(() {
        _paintings = paintings;
      });
    } catch (e) {
      print('Failed to load paintings: $e');
    }
  }

  @override
  void dispose() {
    _authorNameController.dispose();
    _paintingNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Press again to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: apk.secondaryColor,
          title: Text(
            "ART CONNECT",
            style: TextStyle(fontSize: 25, color: apk.primaryColor),
          ),
          leading: IconButton(
            tooltip: "Profile",
            onPressed: () {
              Get.to(() => const Profile());
            },
            icon: SizedBox.fromSize(
              size: const Size.fromRadius(20),
              child: CircleAvatar(
                backgroundColor: Colors.white,
               child: Icon(Icons.account_circle),
                // foregroundImage: AssetImage("assets/images/girl.jpg",),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          isTheme: isTheme,
          selectedIndex: _selectedIndex,
          onItemTap: _onItemTapped,
        ),
        body: _selectedIndex == 0
            ? homeContent()
            : _selectedIndex == 1
                ? uploadContent()
                : settingsContent(),
      ),
    );
  }
  
  Widget homeContent() {
    return Container(
      color: apk.secondaryColor,
      child: _paintings.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: _paintings.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final painting = _paintings[index];
                return InkWell(
                  onTap: () {
                    showPaintingDetailsDialog(context, painting);
                  },
                  child: Card(
                    color: apk.primaryColor,
                    borderOnForeground: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'http://192.168.5.136/flutterApp/${painting.image}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          left: 2,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              painting.authorName,
                              style: TextStyle(color: apk.primaryColor),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          left: 2,
                          right: 8,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  painting.paintingName,
                                  style: TextStyle(
                                      color: apk.primaryColor, fontSize: 10),
                                ),
                                Text(
                                  painting.price,
                                  style: TextStyle(
                                      color: apk.primaryColor, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void showPaintingDetailsDialog(BuildContext context, Painting painting) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(painting.paintingName),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                    'http://192.168.5.136/flutterApp/${painting.image}'),
                const SizedBox(height: 10),
                Text('Author: ${painting.authorName}'),
                const SizedBox(height: 10),
                Text('Price: ${painting.price}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Purchase'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget uploadContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: _image == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  color: apk.secondaryColor,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: apk.primaryColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  elevation: 0,
                  onPressed: _pickImage,
                  child: _image == null
                      ? const Text(
                          'Pick Your Painting',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'Pick Again',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                Visibility(
                  visible: _image != null,
                  child: MaterialButton(
                    color: apk.secondaryColor,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: apk.primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    elevation: 0,
                    onPressed: _uploadImage,
                    child: const Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (await _requestPermission(Permission.photos)) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _cropImage(pickedFile.path);
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<void> _cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: apk.secondaryColor,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _image = XFile(croppedFile.path);
      });
    }
  }

  void _uploadImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add The Details",
              style: TextStyle(color: apk.secondaryColor)),
          content: SizedBox(
            height: 165,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: apk.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _authorNameController,
                    style: TextStyle(color: apk.secondaryColor),
                    decoration: InputDecoration(
                      hintText: "Author Name",
                      hintStyle: TextStyle(color: apk.secondaryColor),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: apk.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _paintingNameController,
                    style: TextStyle(color: apk.secondaryColor),
                    decoration: InputDecoration(
                      hintText: "Painting Name",
                      hintStyle: TextStyle(color: apk.secondaryColor),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: apk.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _priceController,
                    style: TextStyle(color: apk.secondaryColor),
                    decoration: InputDecoration(
                      hintText: "Price",
                      hintStyle: TextStyle(color: apk.secondaryColor),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text("CANCEL", style: TextStyle(color: apk.secondaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  Text("UPLOAD", style: TextStyle(color: apk.secondaryColor)),
              onPressed: () async {
                if (_image != null &&
                    _authorNameController.text.isNotEmpty &&
                    _paintingNameController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  await _paintingUploader.uploadPainting(
                    _image!.path,
                    _authorNameController.text,
                    _paintingNameController.text,
                    _priceController.text,
                  );
                  Navigator.of(context).pop();
                  _authorNameController.clear();
                  _paintingNameController.clear();
                  _priceController.clear();
                  setState(() {
                    _image = null;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Widget settingsContent() {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const SizedBox(height: 30),
  //         SizedBox(
  //           width: 350,
  //           child: Card(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 const Column(
  //                   children: [
  //                     Text(
  //                       "My Wallet",
  //                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  //                     ),
  //                     Text(
  //                       "Status",
  //                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox.fromSize(
  //                   size: const Size.fromRadius(20),
  //                   child: const CircleAvatar(
  //                     backgroundColor: Colors.red,
  //                     foregroundImage: AssetImage('assets/images/girl.jpg'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 40),
  //         Container(
  //           alignment: Alignment.center,
  //           width: 350,
  //           child: Card(
  //             child: Padding(
  //               padding: const EdgeInsets.all(20),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   const Column(
  //                     children: [
  //                       Text(
  //                         "Balance",
  //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  //                       ),
  //                       Text("\$40",
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.bold, fontSize: 20))
  //                     ],
  //                   ),
  //                   OutlinedButton(
  //                     style: ButtonStyle(
  //                       backgroundColor: MaterialStateColor.resolveWith(
  //                               (states) => apk.secondaryColor),
  //                     ),
  //                     onPressed: () {},
  //                     child: Text(
  //                       "ADD MONEY",
  //                       style: TextStyle(color: apk.primaryColor, fontSize: 14),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         const Text(
  //           "Last Transactions",
  //           textAlign: TextAlign.start,
  //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: 10,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ListTile(
  //                 leading: const Icon(Icons.money),
  //                 trailing: const Text(
  //                   "\$40",
  //                   style: TextStyle(color: Colors.green, fontSize: 15),
  //                 ),
  //                 title: Text("Transaction $index"),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget settingsContent() {
    return Column(
      children: [
         ListTile(
          title: const Text("Privacy Policy",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: () {
            Get.to(() => PrivacyPage());
          },
        ),
         ListTile(
          title: const Text("Terms & Conditions",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
           onTap: () {
             Get.to(() => TermsAndConditionsPage());
           },
        ),
        ListTile(
          title: const Text("Log-out",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          onTap: (){logout();},
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
