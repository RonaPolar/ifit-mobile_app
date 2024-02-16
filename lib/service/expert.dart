import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:image_picker/image_picker.dart';

class ExpertProvider extends ChangeNotifier {

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
    return _db.collection(tExpertPath).doc(uid).snapshots().map((doc) {
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
    "Shoulders",
    "Arms",
    "Biceps",
    "Triceps",
    "Forearms",
    "Chest",
    "Upper Back",
    "Lower Back",
    "Abdominals",
    "Lower Body",
    "Glutes",
    "Legs",
    "Quadriceps",
    "Hamstrings",
    "Calves",
    "Full Body"
  ];

  List<Map> data = [
    {
      "category": "upper body",
      "subcategory":{
        "list": [
          {
            "data1": "arm",
            "data2": "chest"
          }
        ]
      }

    }
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
  static TextEditingController minutes = TextEditingController();
  static TextEditingController calories = TextEditingController();

  XFile? workoutPicture;

  Future<void> uploadWorkoutPicture(BuildContext context) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        workoutPicture = img;
        notifyListeners();
      },
    );
  }

  DateTime? daysOfThePlan;

  void updateDaysOfThePlan(DateTime? value) {
    daysOfThePlan = value;
    notifyListeners();
  }

  List<TextEditingController> equipmentsText = [];

  void updateEquipmentsText(bool add) {
    if (add) {
      equipmentsText.add(TextEditingController());
    } else if(equipmentsText.isNotEmpty) {
      equipmentsText.removeAt(equipmentsText.length - 1);
    }
    notifyListeners();
  }

  int sets = 0;

  void updateSets(bool add) {
    if (add) {
      sets++;
    } else if (sets > 0) {
      sets--;
    }
    notifyListeners();
  }

  static TextEditingController exerciseTitle = TextEditingController();
  static TextEditingController exerciseVideo = TextEditingController();
  static TextEditingController exerciseDescription = TextEditingController();

  List<TextEditingController> steps = [];

  void updateSteps(bool add) {
    if (add) {
      steps.add(TextEditingController());
    } else if (steps.isNotEmpty) {
      steps.removeAt(steps.length - 1);
    }
    notifyListeners();
  }

  List<ExerciseElement> exerciseList = [];

  void addExercise() {

    final ExerciseElement exercise = ExerciseElement(
      url: exerciseVideo.text,
      title: exerciseTitle.text,
      description: exerciseDescription.text,
      steps: steps.map((e) => e.text).toList(),
    );

    exerciseList.add(exercise);
    clearExerciseForm();

    notifyListeners();
  }

  void clearExerciseForm() {
    exerciseTitle.clear();
    exerciseVideo.clear();
    exerciseDescription.clear();
    steps = [];
    notifyListeners();
  }

  void removeExercise() {
    exerciseList.removeAt(exerciseList.length - 1);
    notifyListeners();
  }


  Future<void> addWorkoutPlan({
    required String id,
  }) async {


    final data = await _db.collection(tWorkoutPlanPath).doc(id).get();

    await uploadWorkoutPhoto(id).then((value) async {

      final WorkoutPlan workoutPlan = WorkoutPlan(
        category: workoutCategory ?? "",
        purpose: workoutPurpose ?? "",
        difficulty: workoutDifficulty ?? "",
        planName: planName.text,
        description: description.text,
        workoutPicture: workoutPhotoUrl!,
        daysOfThePlan: daysOfThePlan!,
        minutes: minutes.text,
        calories: calories.text,
        equipments: equipmentsText.map((e) => e.text).toList(),
        exercise: Exercise(
          sets: sets,
          exercises: exerciseList,
        ),
        rating: 0,
      );

      final bool hasWorkoutPlans = !data.data()!.containsKey("workoutPlans");

      if (hasWorkoutPlans) {
        await _db.collection(tWorkoutPlanPath).doc(id).set({
          "workoutPlans": [
            workoutPlan.toJson(),
          ],
        })
          .then((value) => debugPrint("Workout plan added successfully!"))
          .onError((error, stackTrace) => "Failed: $error");
      } else {
        final List objects = data["workoutPlans"];

        objects.add(workoutPlan.toJson());
        await _db.collection(tWorkoutPlanPath).doc(id).set({
          "workoutPlans": objects,
        })
          .then((value) => debugPrint("Workout plan added successfully!"))
          .onError((error, stackTrace) => "Failed: $error");
      }
    });


  }

  String? workoutPhotoUrl;

  Future<void> uploadWorkoutPhoto(String id) async {
    final file = File(workoutPicture!.path);
    final ref = FirebaseStorage.instance.ref()
      .child(tWorkoutPlanPath)
      .child(id)
      .child(workoutPicture!.name);
    await ref.putFile(file);

    workoutPhotoUrl = await ref.getDownloadURL();
    notifyListeners();
  }

  void clearWorkoutPlanForm() {
    workoutCategory = null;
    workoutPurpose = null;
    workoutDifficulty = null;
    planName.clear();
    description.clear();
    workoutPicture = null;
    daysOfThePlan = null;
    minutes.clear();
    calories.clear();
    equipmentsText = [];
    exerciseList = [];
    sets = 0;
    workoutPhotoUrl = null;
    notifyListeners();
  }

  String? foodCategory;

  List<String> foodCategoryList = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
    "Drinks",
  ];
}