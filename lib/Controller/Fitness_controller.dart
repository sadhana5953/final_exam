import 'package:final_exam/Helper/DatabseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Services/Auth_Service.dart';

class FitnessController extends GetxController
{
  var txtEmail=TextEditingController();
  var txtPassword=TextEditingController();
  var txtName=TextEditingController();
  var txtTime=TextEditingController();
  var txtDate=TextEditingController();
  RxString type='Cardio'.obs;
  RxList dataList=[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initDb();
    getData();
    super.onInit();
  }

  Future<void> initDb()
  async {
    await DataBaseHelper.dbHelper.database;
  }

  Future<void> insertData(String email,String name,String time,String date,String type,String docId)
  async {
    await DataBaseHelper.dbHelper.insertData(email, name, time, date, type, docId);
    getData();
  }

  Future<RxList> getData()
  async {
    User? user=AuthService.authService.getCurrentUser();
    String? email=user!.email;
    dataList.value=await DataBaseHelper.dbHelper.redaData(email!);
    return dataList;
  }

  Future<void> updateData(String name,String time,String date,String type,int id,String email)
  async {
    await DataBaseHelper.dbHelper.updateData(name, time, date, type, id, email);
    getData();
  }

  Future<void> deleteData(int id,String email)
  async {
    await DataBaseHelper.dbHelper.removeData(id, email);
    getData();
  }

  Future<RxList> selectData(String email,String category)
  async {
    dataList.value=await DataBaseHelper.dbHelper.selectData(email, category);
    return dataList;
  }
}

////Workout Name, Duration (minutes), Date, and Type (e.g., Cardio, Strength).