import 'dart:async';

import 'package:final_exam/View/Login_Screen.dart';
import 'package:final_exam/View/Manage_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Get.to(ManageScreen());
    },);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff191b28),
        child: Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(image: NetworkImage('https://bcassetcdn.com/public/blog/wp-content/uploads/2022/01/04214914/gym-music-speaker-fitness-by-simplepixelsl-brandcrowd1.png')),
            ),
          ),
        ),
      ),
    );
  }
}
