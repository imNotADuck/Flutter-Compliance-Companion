import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).set({
      "id": uid,
      "email": "tobeimplementd"
    });
    safePrint(("createUser success uid {$uid}"));
    return true;
    } catch(e) {
      safePrint(e);
      return false;
    }
  }
}
