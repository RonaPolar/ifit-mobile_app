import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:image_picker/image_picker.dart';

class ClientProvider extends ChangeNotifier {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage ref = FirebaseStorage.instance;

  Stream<ClientModel>? clientStream;

  Stream<ClientModel> getClient(String uid) {
    return _db.collection(tClientPath).doc(uid).snapshots().map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ClientModel.fromJson(data);
    });
  }

  void updateClientStream({
    required String uid,
  }) {
    clientStream = getClient(uid);
    notifyListeners();
  }

  double bmi = 0;
  String? name;

  void getBmi({
    required ClientModel client,
  }) {

    final double weight = double.parse(client.weight);
    final double height = double.parse(client.height);
    final double heightInMeters = double.parse(client.height)/100;

    bmi = weight / (heightInMeters * heightInMeters);

    if (height != 0.0 && weight != 0.0) {
      // Calculate BMI
      bmi = weight / (heightInMeters * heightInMeters);
    } else {
      print('Height or weight is zero, unable to calculate BMI');
    }
    notifyListeners();
  }

  String get getBMIDescription {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "Normal";
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }

  Stream<List<List<WorkoutPlan>>>? workoutPlanListStream;

  Stream<List<List<WorkoutPlan>>> getWorkoutPlanList() {
    final data = _db.collection(tWorkoutPlanPath).snapshots().map(workoutPlanFromSnapshot);
    return data;
  }

  List<List<WorkoutPlan>> workoutPlanFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((data) {
        final map = (data.data() as Map<String, dynamic>)["workoutPlans"];
        return (map as List).map((data) => WorkoutPlan.fromJson(data)).toList();
      }).toList();
    } catch (e) {
      return [];
    }
  }

  void updateWorkoutPlanListStream() {
    workoutPlanListStream = getWorkoutPlanList();
    notifyListeners();
  }

  Stream<List<List<WorkoutMeal>>>? workoutMealListStream;

  Stream<List<List<WorkoutMeal>>> getWorkoutMealList() {
    final data = _db.collection(tWorkoutMealPath).snapshots().map(workoutMealFromSnapshot);
    return data;
  }

  List<List<WorkoutMeal>> workoutMealFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      final map = (data.data() as Map<String, dynamic>)["workoutMeals"];
      return (map as List).map((data) => WorkoutMeal.fromJson(data)).toList();
    }).toList();
  }

  void updateWorkoutMealListStream() {
    workoutMealListStream = getWorkoutMealList();
    notifyListeners();
  }

  Stream<List<ExpertModel>>? expertListStream;

  Stream<List<ExpertModel>> getExpertListStream() {
    final data = _db.collection(tExpertPath).snapshots().map(expertListFromSnapshot);
    return data;
  }

  List<ExpertModel> expertListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      final map = (data.data() as Map<String, dynamic>);
      return ExpertModel.fromJson(map);
    }).toList();
  }

  void updateExpertListStream() {
    expertListStream = getExpertListStream();
    notifyListeners();
  }

  Stream<List<WorkoutPlan>>? clientWorkoutPlanListStream;

  Stream<List<WorkoutPlan>> getClientWorkoutPlanListStream(String uid) {
    return _db.collection(tClientPath).doc(uid)
      .collection(tWorkoutPlanPath).snapshots().map((doc) {
        return doc.docs.map((data) {
          final map = data.data();
          return WorkoutPlan.fromJson(map[tWorkoutPlanPath]);
        },
      ).toList();
    });
  }

  void updateClientWorkoutPlanListStream({
    required String uid,
  }) {
    clientWorkoutPlanListStream = getClientWorkoutPlanListStream(uid);
    notifyListeners();
  }

  Stream<List<WorkoutMeal>>? clientWorkoutMealListStream;

  Stream<List<WorkoutMeal>> getClientWorkoutMealListStream(String uid) {
    return _db.collection(tClientPath).doc(uid)
      .collection(tWorkoutMealPath).snapshots().map((doc) {
        return doc.docs.map((data) {
          final map = data.data();

          return WorkoutMeal.fromJson(map[tWorkoutMealPath]);
        },
      ).toList();
    });
  }

  void updateClientWorkoutMealListStream({
    required String uid,
  }) {
    clientWorkoutMealListStream = getClientWorkoutMealListStream(uid);
    notifyListeners();
  }

  bool workoutPlanExisting = false;

  Future<void> getWorkoutPlanExisting({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {
    final String workoutId = workoutPlan.id;

    final data = await _db.collection(tClientPath)
        .doc(id).collection(tWorkoutPlanPath).get();

    final List<WorkoutPlan> workoutPlanList = data.docs.map((snapshot) {
      final map = snapshot.data()["workoutPlan"];
      return WorkoutPlan.fromJson(map);
    }).toList();

    if (workoutPlanList.any((element) => element.id == workoutId)) {
      workoutPlanExisting = true;
    } else {
      workoutPlanExisting = false;
    }
    notifyListeners();
  }

  Future<void> addWorkoutPlan({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {

    final String workoutId = workoutPlan.id;

    final data = await _db.collection(tClientPath)
        .doc(id).collection(tWorkoutPlanPath).get();

    final List<WorkoutPlan> workoutPlanList = data.docs.map((snapshot) {
      final map = snapshot.data()[tWorkoutPlanPath];
      return WorkoutPlan.fromJson(map);
    }).toList();

    // if the id of workoutPlan is already in the list
    if (workoutPlanList.any((element) => element.id == workoutId)) {
      debugPrint("$workoutId: Id is already existing");
    } else {
      await _db.collection(tClientPath)
          .doc(id).collection(tWorkoutPlanPath)
          .doc(workoutId).set({
        tWorkoutPlanPath: workoutPlan.toJson(),
      }).then((value) {
        getWorkoutPlanExisting(id: id, workoutPlan: workoutPlan);
        return debugPrint("Workout plan added successfully!");
      }).catchError((error, stackTrace) => debugPrint("Failed! $stackTrace"));
    }
  }

  bool workoutMealExisting = false;

  Future<void> getWorkoutMealExisting({
    required String id,
    required WorkoutMeal workoutMeal,
  }) async {
    final String workoutId = workoutMeal.id;

    final data = await _db.collection(tClientPath)
        .doc(id).collection(tWorkoutMealPath).get();

    final List<WorkoutMeal> workoutMealList = data.docs.map((snapshot) {
      final map = snapshot.data()[tWorkoutMealPath];
      return WorkoutMeal.fromJson(map);
    }).toList();

    if (workoutMealList.any((element) => element.id == workoutId)) {
      workoutMealExisting = true;
    } else {
      workoutMealExisting = false;
    }
    notifyListeners();
  }

  Future<void> addWorkoutMealPlan({
    required String id,
    required WorkoutMeal workoutMeal,
  }) async {

    final String workoutId = workoutMeal.id;

    final data = await _db.collection(tClientPath)
        .doc(id).collection(tWorkoutMealPath).get();

    final List<WorkoutMeal> workoutMealList = data.docs.map((snapshot) {
      final map = snapshot.data()[tWorkoutMealPath];
      return WorkoutMeal.fromJson(map);
    }).toList();

    // if the id of workoutMeal is already in the list
    if (workoutMealList.any((element) => element.id == workoutId)) {
      debugPrint("$workoutId: Id is already existing");
    } else {
      await _db.collection(tClientPath)
          .doc(id).collection(tWorkoutMealPath)
          .doc(workoutId).set({
        tWorkoutMealPath: workoutMeal.toJson(),
      }).then((value) {

        getWorkoutMealExisting(id: id, workoutMeal: workoutMeal);
        return debugPrint("Workout meal added successfully!");
      }).catchError((error, stackTrace) => debugPrint("Failed! $stackTrace"));
    }
    notifyListeners();
  }

  XFile? photoProfile;
  String? photoUrl;

  Future<void> uploadPhotoProfile(BuildContext context, {
    required String id,
  }) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        if (img != null) {
          await storePhotoProfile(id);
        }
        photoProfile = img;
        notifyListeners();
      },
    );
  }

  Future<void> storePhotoProfile(String id) async {
    // store professionId to storage
    final file = File(photoProfile!.path);
    final ref = FirebaseStorage.instance.ref()
        .child(tClientPath)
        .child(photoProfile!.name);
    await ref.putFile(file);

    // store professionId to firestore
    photoUrl = await ref.getDownloadURL();

    _db.collection(tClientPath).doc(id).set({
      "photo_url": photoUrl!,
    }, SetOptions(merge: true))
        .then((value) => debugPrint("Update photo successful!"))
        .onError((error, stackTrace) => debugPrint("Failed uploading photo successful!"));
    notifyListeners();
  }

}
