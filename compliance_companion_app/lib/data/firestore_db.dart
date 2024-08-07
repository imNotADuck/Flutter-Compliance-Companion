import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compliance_companion_app/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FirestoreDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        "id": uid,
        "email": "tobeimplementd",
      });
      print(("createUser success uid {$uid}"));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addTask(
      String title, String description, DateTime? dueDate, String status) async {
    var uuid = const Uuid().v4();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('userId');

    if (uid != null) {
      try {
        DateTime data = DateTime.now();
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .doc(uuid)
            .set({
          'id': uuid,
          'title': title,
          'description': description,
          'dueDate': dueDate,
          'status': status,
          'time': data,
        });
        print('add task to FirestoreDB successfully');
        return true;
      } catch (e) {
        print('add task failed with $e');
        return true;
      }
    }
    return true;
  }

  //Get data stream from Firestore
  Stream<QuerySnapshot> tasksStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .snapshots();
  }

  //Get data and map to model
  Stream<List<Task>> getTasksStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .snapshots()
        .map((QuerySnapshot query) {
          return query.docs.map((doc) {
            return Task.fromFirestore(doc);
          }).toList();
        });
  }


   Future<bool> setTaskCompleted(String uid, String uuid, bool isCompleted) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(uuid)
          .update({'status': isCompleted ? 'completed' : 'pending'});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> deleteTask(String uid, String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }


  Future<bool> updateTask(
      String uid, String uuid, String title, String description, DateTime dueDate, String status) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'description': description,
        'title': title,
        'dueDate': dueDate,
        'status': status,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }


}
