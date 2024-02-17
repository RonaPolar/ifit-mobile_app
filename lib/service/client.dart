import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:uuid/uuid.dart';

class ClientProvider extends ChangeNotifier {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Stream<List<List<WorkoutPlan>>>? workoutPlanListStream;

  Stream<List<List<WorkoutPlan>>> getWorkoutPlanList() {
    final data = _db.collection(tWorkoutPlanPath).snapshots().map(workoutPlanFromSnapshot);
    return data;
  }

  List<List<WorkoutPlan>> workoutPlanFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((data) {
      final map = (data.data() as Map<String, dynamic>)["workoutPlans"];
      return (map as List).map((data) => WorkoutPlan.fromJson(data)).toList();
    }).toList();
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
      final map = snapshot.data()["workoutPlan"];
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

}
