import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellart/OtherPages/registration.dart';
import 'package:sellart/main.dart';

import '../API/login_api.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());


  loginval(){
    loginController.loginUser(_emailController.text.toString(), _passController.text.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10, backgroundColor: AppColor().secondaryColor,),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Get.to(() => const MyHomePage());
                          loginval();

                        },
                        child: const Text("Login"),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {Get.to(() => Registration());},
                        child: const Text("Don't have an account? Register here"),
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
