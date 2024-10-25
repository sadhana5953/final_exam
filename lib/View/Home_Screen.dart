import 'package:final_exam/Controller/Fitness_controller.dart';
import 'package:final_exam/Services/Auth_Service.dart';
import 'package:final_exam/Services/Cloud_FireStroe_Service.dart';
import 'package:final_exam/View/AddData_Screen.dart';
import 'package:final_exam/View/Manage_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(FitnessController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff191b28),
        title: Text('Home Screen',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: () async {
            await AuthService.authService.signOutAccount();
            Get.to(ManageScreen());
          }, icon: Icon(Icons.login,color: Colors.white,))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff191b28),
        child: Obx(
          () =>  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(onPressed: () {
                    User? user=AuthService.authService.getCurrentUser();
                    String? email=user!.email;
                    controller.selectData(email!, 'Cardio');
                  }, child: Text('Cardio')),
                  OutlinedButton(onPressed: () {
                    User? user=AuthService.authService.getCurrentUser();
                    String? email=user!.email;
                    controller.selectData(email!, 'Strength');
                  }, child: Text('Strength')),
                  OutlinedButton(onPressed: () {
                    controller.getData();
                  }, child: Text('All')),
                ],
              ),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  if(controller.dataList.isEmpty)
                    {
                      return Center(child: Text('No Data'),);
                    }
                  else
                    {
                      return Card(
                        child: ListTile(
                          tileColor: Color(0xff34364b),
                          title: Text(controller.dataList[index]['name'],style: TextStyle(color: Colors.white),),
                          subtitle: Text('${controller.dataList[index]['name']}:${controller.dataList[index]['date']}',style: TextStyle(color: Colors.white),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(controller.dataList[index]['type'],style: TextStyle(color: Colors.white),),
                              IconButton(onPressed: () {
                                controller.txtName.text=controller.dataList[index]['name'];
                                controller.txtTime.text=controller.dataList[index]['time'];
                                controller.txtDate.text=controller.dataList[index]['date'];
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  title: Text('Update Data'),
                                  content: Obx(
                                    () =>  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: controller.txtName,
                                          decoration: InputDecoration(
                                            hintText: 'Workout Name',
                                            enabledBorder: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                          ),
                                        ).marginSymmetric(vertical: 5),
                                        TextFormField(
                                          controller: controller.txtTime,
                                          decoration: InputDecoration(
                                            hintText: 'Duration (minutes)',
                                            enabledBorder: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                          ),
                                        ).marginSymmetric(vertical: 5),
                                        TextFormField(
                                          controller: controller.txtDate,
                                          decoration: InputDecoration(
                                            hintText: 'Date',
                                            enabledBorder: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                          ),
                                        ).marginSymmetric(vertical: 5),
                                        Row(
                                          children: [
                                            Text('  Type:'),
                                            Spacer(),
                                          ],
                                        ),
                                        Flexible(
                                          child: RadioListTile(value: 'Cardio',title: Text('Cardio'), groupValue: controller.type.value, onChanged: (value) {
                                            controller.type.value=value!;
                                          },),
                                        ),
                                        Flexible(
                                          child: RadioListTile(value: 'Strength',title: Text('Strength'), groupValue: controller.type.value, onChanged: (value) {
                                            controller.type.value=value!;
                                          },),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(onPressed: () {
                                      String name=controller.txtName.text;
                                      String time=controller.txtTime.text;
                                      String date=controller.txtDate.text;
                                      String type=controller.type.value;
                                      String email=controller.dataList[index]['email'];
                                      String docId=controller.dataList[index]['docId'];
                                      int id=controller.dataList[index]['id'];
                                      CloudFireStoreService.fireStoreService.updateFitnessData(email, name, time, date, type, docId);
                                      controller.updateData(name, time, date, type, id, email);
                                      controller.txtName.clear();
                                      controller.txtDate.clear();
                                      controller.txtTime.clear();
                                      controller.type.value='Cardio';
                                      Get.back();
                                    }, child: Text('Update')),
                                    TextButton(onPressed: () {
                                      controller.txtName.clear();
                                      controller.txtDate.clear();
                                      controller.txtTime.clear();
                                      controller.type.value='Cardio';
                                      Get.back();
                                    }, child: Text('cancle')),
                                  ],
                                ),);
                              }, icon: Icon(Icons.edit,color: Colors.white,)),
                              IconButton(onPressed: () {
                                String email=controller.dataList[index]['email'];
                                String docId=controller.dataList[index]['docId'];
                                int id=controller.dataList[index]['id'];
                                CloudFireStoreService.fireStoreService.deleteFitnessData(email, docId);
                                controller.deleteData(id, email);
                              }, icon: Icon(Icons.delete,color: Colors.white,)),
                            ],
                          ),
                        ),
                      );
                    }
                },itemCount: controller.dataList.length,),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(onPressed: () {
        Get.to(AdddataScreen());
      },child: Icon(Icons.add),),
    );
  }
}
