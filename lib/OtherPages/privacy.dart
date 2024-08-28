import 'package:flutter/material.dart';
import 'package:sellart/main.dart';

class PrivacyPage extends StatelessWidget {
  AppColor apk = AppColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                'Privacy Policy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We value your privacy and are committed to protecting your personal information.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Information Collection',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We collect information that you provide directly to us, such as when you create an account, update your profile, or communicate with us.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Information Use',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We use the information we collect to provide, maintain, and improve our services, to communicate with you, and to protect our users.',
              ),
              SizedBox(height: 16),
              Text(
                '4. Information Sharing',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We do not share your personal information with third parties except as described in this policy or with your consent.',
              ),
              SizedBox(height: 16),
              Text(
                '5. Your Choices',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You have the right to access, update, or delete your personal information. You can also object to the processing of your data.',
              ),
              SizedBox(height: 16),
              Text(
                '6. Changes to This Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on our site.',
              ),
              SizedBox(height: 16),
              Text(
                '7. Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions about this privacy policy, please contact us.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
