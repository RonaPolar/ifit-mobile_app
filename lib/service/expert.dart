import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/workout.dart';
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

  String? workoutCategory;

  List<String> workoutCategoryList = [
    "Upper Body",
    "Abdominal",
    "Lower Body",
    "Full Body"
  ];

  void updateWorkoutCategory(String value) {
    workoutCategory = value;
    notifyListeners();
  }

  String? workoutPurpose;

  List<String> workoutPurposeList = [
    "Lose Weight",
    "Gain Muscles",
    "Body Toning",
  ];

  void updateWorkoutPurpose(String value) {
    workoutPurpose = value;
    notifyListeners();
  }

  String? workoutDifficulty;

  List<String> workoutDifficultyList = [
    "Beginner",
    "Intermediate",
    "Expert",
  ];

  void updateWorkoutDifficulty(String value) {
    workoutDifficulty = value;
    notifyListeners();
  }

  static TextEditingController planName = TextEditingController();
  static TextEditingController description = TextEditingController();
  static TextEditingController daysOfThePlan = TextEditingController();
  static TextEditingController minutes = TextEditingController();
  static TextEditingController calories = TextEditingController();
  
  Future<void> addWorkoutPlan({
    required String id,
  }) async {
    final WorkoutPlan workoutPlan = WorkoutPlan(
      calories: calories.text,
      category: workoutCategory ?? "",
      daysOfThePlan: daysOfThePlan.text,
      description: description.text,
      difficulty: workoutDifficulty ?? "",
      minutes: minutes.text,
      planName: planName.text,
      purpose: workoutPurpose ?? "",
    );

    await _db.collection(tWorkoutPlanPath).doc(id).set(workoutPlan.toJson())
      .then((value) => debugPrint("Workout plan added successfully!"))
      .onError((error, stackTrace) => "Failed: $error");
  }
}