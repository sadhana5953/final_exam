import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService
{
  CloudFireStoreService._();
  static CloudFireStoreService fireStoreService=CloudFireStoreService._();

  FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<String> addFitnessData(String email,String name,String time,String date,String type)
  async {
    var refId=await firestore.collection(email).add({
      'Workout Name':name,
      'Duration (minute)':time,
      'Date':date,
      'Type':type
    });
    return refId.id;
  }

  Future<void> updateFitnessData(String email,String name,String time,String date,String type,String docId)
  async {
    await firestore.collection(email).doc(docId).update({
      'Workout Name':name,
      'Duration (minute)':time,
      'Date':date,
      'Type':type
    });
  }

  Future<void> deleteFitnessData(String email,String docId)
  async {
    await firestore.collection(email).doc(docId);
  }
}
////Workout Name, Duration (minutes), Date, and Type (e.g., Cardio, Strength).