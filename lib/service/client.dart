import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/workout.dart';

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

}
