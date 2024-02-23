import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/start_workout/countdown.dart';

class WorkoutProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  int workoutIndex = 0;
  int skippedIndex = 0;

  void updateSkipWorkout({
    required List<ExerciseElement> exerciseList,
  }) {
    skippedIndex++;
    workoutIndex++;

    notifyListeners();
  }

  int setFinished = 0;

  bool restart = false;

  void updateRestart(bool value) {
    restart = value;
    notifyListeners();
  }

  void updateSkipExercise() {
    skippedIndex++;
    notifyListeners();
  }

  Future<void> updateDoneWorkout({
    required BuildContext context,
    required WorkoutPlan workoutPlan,
    required String id,
    required bool skip,
  }) async {
    final List<ExerciseElement> exerciseList = workoutPlan.exercise.exercises;
    final int set = workoutPlan.exercise.sets;
    final String workoutId = workoutPlan.id;

    if (skip) {
      skippedIndex++;
    }

    if (exerciseList.length - 1 != workoutIndex) {
      workoutIndex++;
    } else {
      if ((setFinished + 1) != set) {
        workoutIndex = 0;
        skippedIndex = 0;
        setFinished++;

        Navigator.of(context)
          ..pop()
          ..pop();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CountdownTimerScreen(
              workoutPlan: workoutPlan,
              id: id,
            )));
      } else {
        if ((exerciseList.length - skippedIndex) > skippedIndex) {
          await updateWorkoutDay(
            id: id,
            workoutId: workoutId,
          ).then((value) {
            Navigator.of(context)
              ..pop()
              ..pop();
            setFinished = 0;
            workoutIndex = 0;
            skippedIndex = 0;
          });
        } else {
          Navigator.of(context)
            ..pop()
            ..pop();
          setFinished = 0;
          workoutIndex = 0;
          skippedIndex = 0;
        }

      }
    }

    print(exerciseList.length - 1);
    print(workoutIndex);

    notifyListeners();
  }

  bool isPause = false;

  void pauseTimer() {
    isPause = !isPause;
    notifyListeners();
  }

  Future<void> updateWorkoutDay({
    required String id,
    required String workoutId,
  }) async {
    final path = _db
        .collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutId);

    final data = await path.get();

    final map = data.data()!["workoutPlan"];
    final WorkoutPlan workoutPlan = WorkoutPlan.fromJson(map);

    await path
        .set({
          "workoutPlan": {
            "dayCountFinished": workoutPlan.dayCountFinished != null
                ? workoutPlan.dayCountFinished! + 1
                : 1,
          }
        }, SetOptions(merge: true))
        .then((value) => debugPrint("Day Count Finished Updated!"))
        .onError((error, stackTrace) => debugPrint("Error Updating! $error"));

    notifyListeners();
  }

  void clearExerciseForm({
    required WorkoutPlan workoutPlan,
  }) {
    setFinished = 0;
    workoutIndex = 0;
    isPause = false;
    skippedIndex = 0;
    notifyListeners();
  }

  bool isFavorite = false;

  Future<void> updateAddToFavorite({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {
    final path = _db
        .collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutPlan.id);

    await path
        .set({
          tWorkoutPlanPath: {
            "isFavorite": !workoutPlan.isFavorite,
          }
        }, SetOptions(merge: true))
        .then((value) => debugPrint("Update favorites successfully!"))
        .onError((error, stackTrace) => debugPrint("Error! $stackTrace"));

    notifyListeners();
  }

  Future<void> cancelWorkout({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {
    final path = _db
        .collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutPlan.id);

    await path
        .set({
          tWorkoutPlanPath: {"isCancelled": !workoutPlan.isCancelled}
        }, SetOptions(merge: true))
        .then((value) => debugPrint("Update cancel status!"))
        .onError((error, stackTrace) => debugPrint("Failed to update! $error"));

    notifyListeners();
  }
}
