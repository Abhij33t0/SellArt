import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellart/HomePages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'OtherPages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? value = "";
  final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
  fetchData() async {
    final SharedPreferences prefs = await prefsFuture;
    value = prefs.getString('userid');
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 2).animate(_controller);

    _controller.forward();

    Timer(const Duration(milliseconds: 2500), () {
      if (value == null) {
        Get.off(() => Login());
      } else {
        Get.off(() => const MyHomePage());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Image.asset('assets/icon.jpg'),
        ),
      ),
    );
  }
}
