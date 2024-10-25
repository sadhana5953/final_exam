import 'package:final_exam/Controller/Fitness_controller.dart';
import 'package:final_exam/Services/Auth_Service.dart';
import 'package:final_exam/Services/Cloud_FireStroe_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AdddataScreen extends StatelessWidget {
  const AdddataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(FitnessController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff191b28),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Text('Add Data Screen',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff191b28),
        child: Column(
          children: [
            TextFormField(
              controller: controller.txtName,
              decoration: InputDecoration(
                hintText: 'Workout Name',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width: 2)
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                  color: Colors.white,
                  width: 3
                )),
              ),
            ).marginSymmetric(horizontal: 20,vertical: 15),
            TextFormField(
              controller: controller.txtTime,
              decoration: InputDecoration(
                hintText: 'Duration (minutes)',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 2)
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.white,
                    width: 3
                )),
              ),
            ).marginSymmetric(horizontal: 20,vertical: 15),
            TextFormField(
              controller: controller.txtDate,
              decoration: InputDecoration(
                hintText: 'Date',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 2)
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.white,
                    width: 3
                )),
              ),
            ).marginSymmetric(horizontal: 20,vertical: 15),
            Obx(
              () =>  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Type:',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Flexible(
                    child: RadioListTile(value: 'Cardio',title: Text('Cardio',style: TextStyle(color: Colors.white),), groupValue: controller.type.value, onChanged: (value) {
                      controller.type.value=value!;
                    },),
                  ),
                  Flexible(
                    child: RadioListTile(value: 'Strength',title: Text('Strength',style: TextStyle(color: Colors.white),), groupValue: controller.type.value, onChanged: (value) {
                      controller.type.value=value!;
                    },),
                  )
                ],
              ).marginSymmetric(horizontal: 18),
            ),
            FilledButton(onPressed: () async {
              User? user=AuthService.authService.getCurrentUser();
              String? email=user!.email;
              String name=controller.txtName.text;
              String time=controller.txtTime.text;
              String date=controller.txtDate.text;
              String type=controller.type.value;
              String docId=await CloudFireStoreService.fireStoreService.addFitnessData(email!, name, time, date, type);
              controller.insertData(email, name, time, date, type, docId);
              controller.type.value='Cardio';
              controller.txtName.clear();
              controller.txtTime.clear();
              controller.txtDate.clear();
              Get.back();
            }, child: Text('ADD')),
          ],
        ),
      ),
    );
  }
}
//Workout Name, Duration (minutes), Date, and Type (e.g., Cardio, Strength).