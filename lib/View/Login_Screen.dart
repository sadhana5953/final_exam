import 'package:final_exam/Controller/Fitness_controller.dart';
import 'package:final_exam/Services/Auth_Service.dart';
import 'package:final_exam/View/Home_Screen.dart';
import 'package:final_exam/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(FitnessController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff191b28),
        child: Center(
          child: Container(
            height: 300,
            width: 330,
            decoration: BoxDecoration(
              color: Color(0xff34364b),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: controller.txtEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff191b28),width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff191b28),width: 3)
                    ),
                  ),
                ).marginSymmetric(horizontal: 20,vertical: 15),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: controller.txtPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff191b28),width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff191b28),width: 3)
                    ),
                  ),
                ).marginSymmetric(horizontal: 20,vertical: 15),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(onPressed: () {
                      AuthService.authService.loginAccount(controller.txtEmail.text, controller.txtPassword.text);
                      controller.txtEmail.clear();
                      controller.txtPassword.clear();
                      Get.to(HomeScreen());
                    }, child: Text('Login')),
                    FilledButton(onPressed: () {
                      AuthService.authService.createAccount(controller.txtEmail.text, controller.txtPassword.text);
                      controller.txtEmail.clear();
                      controller.txtPassword.clear();
                      Get.to(HomeScreen());
                    }, child: Text('SignUp')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
