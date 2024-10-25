import 'package:final_exam/Services/Auth_Service.dart';
import 'package:final_exam/View/Home_Screen.dart';
import 'package:final_exam/View/Login_Screen.dart';
import 'package:flutter/material.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return AuthService.authService.getCurrentUser()==null?LoginScreen():HomeScreen();
  }
}
