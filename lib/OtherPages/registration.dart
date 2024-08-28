import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellart/API/register_api.dart';
import 'package:sellart/OtherPages/login.dart';
import 'package:sellart/main.dart';

class Registration extends StatelessWidget {
  Registration({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final RegistrationController regController =
      Get.put(RegistrationController());

  registerVal() {
    regController.registerUser(
        username: _nameController.text.toString(),
        mail: _emailController.text.toString(),
        mobile: _mobileController.text.toString(),
        password: _passController.text.toString(),
        address: _addressController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: AppColor().secondaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Image(image: AssetImage('assets/logo.jpg')),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "Art Connect",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          labelText: "Mobile",
                          prefixIcon: Icon(Icons.smartphone_sharp),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: "Address",
                          prefixIcon: Icon(Icons.business),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Get.to(() => const MyHomePage());
                          registerVal();
                        },
                        child: const Text("Register"),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.to(() => Login());
                        },
                        child:
                            const Text("Already have an account? Login here"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
