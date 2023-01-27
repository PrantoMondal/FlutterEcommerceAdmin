import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{
  static const String collectionAdmin = 'Flutter_admins';
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async{
    final snapshot = await _db.collection(collectionAdmin).doc().get();
    return snapshot.exists;
  }
}