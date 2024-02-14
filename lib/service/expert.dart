import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/models/expert.dart';

class ExpertProvider extends ChangeNotifier {
  Stream<List<ExpertModel>>? expertListStream;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ExpertModel>> getExpertList() {
    return _db.collection("experts").snapshots().map((event) {
      return event.docs.map((doc) {
        final data = doc.data();
        return ExpertModel.fromJson(data);
      }).toList();
    });
  }

  void updateExpertListStream() {

  }
}
