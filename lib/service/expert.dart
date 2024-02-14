import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifit/models/expert.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ExpertModel>>? expertListStream;

  Stream<List<ExpertModel>> getExpertList() {
    return _db.collection("experts").snapshots().map((event) {
      return event.docs.map((doc) {
        final data = doc.data();
        return ExpertModel.fromJson(data);
      }).toList();
    });
  }

  void updateExpertListStream() {
    expertListStream = getExpertList();
    notifyListeners();
  }

  Stream<ExpertModel>? expertStream;

  Stream<ExpertModel> getExpert(String uid) {
    return _db.collection("experts").doc(uid).snapshots().map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ExpertModel.fromJson(data);
    });
  }

  void updateExpertStream({
    required String uid,
  }) {
    expertStream = getExpert(uid);
    notifyListeners();
  }
}