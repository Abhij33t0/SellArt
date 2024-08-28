import 'package:flutter/material.dart';
import 'package:sellart/main.dart';

class TermsAndConditionsPage extends StatelessWidget {
  AppColor apk = AppColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        foregroundColor: Colors.white,
        backgroundColor: apk.secondaryColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'These terms and conditions outline the rules and regulations for the use of our application.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Acceptance of Terms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'By accessing and using our application, you accept and agree to be bound by the terms and provisions of this agreement.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Changes to Terms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We reserve the right to modify these terms at any time. You should review these terms periodically for changes.',
              ),
              SizedBox(height: 16),
              Text(
                '4. User Responsibilities',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You agree to use our application only for lawful purposes and in a way that does not infringe the rights of others or restrict their use of the application.',
              ),
              SizedBox(height: 16),
              Text(
                '5. Limitation of Liability',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We are not liable for any damages that may occur from the use of our application. This includes, but is not limited to, direct, indirect, incidental, and consequential damages.',
              ),
              SizedBox(height: 16),
              Text(
                '6. Governing Law',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'These terms are governed by and construed in accordance with the laws of our jurisdiction, and you irrevocably submit to the exclusive jurisdiction of the courts in that location.',
              ),
              SizedBox(height: 16),
              Text(
                '7. Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions about these terms, please contact us.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
