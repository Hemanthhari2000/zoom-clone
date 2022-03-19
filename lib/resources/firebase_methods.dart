import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory => _firestore
      .collection("user")
      .doc(_auth.currentUser!.uid)
      .collection("meeting_history")
      .snapshots();

  void addToMeetingHistory(String meetingName) async {
    try {
      await _firestore
          .collection("user")
          .doc(_auth.currentUser!.uid)
          .collection("meeting_history")
          .add({
        "meeting_name": meetingName,
        "timestamp": DateTime.now(),
      });
    } catch (error) {
      log("error: $error");
    }
  }
}
