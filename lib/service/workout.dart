import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/rate_screens/feedback.dart';
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
    final num set = workoutPlan.exercise.sets;
    final String workoutId = workoutPlan.id;

    final path = _db
        .collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutId);

    await path.get().then((value) async {
      final map = value.data()!["workoutPlan"];
      final WorkoutPlan clientWorkoutPlan = WorkoutPlan.fromJson(map);

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

              final bool isCompleted = (clientWorkoutPlan.dayCountFinished + 1).toString() == clientWorkoutPlan.daysOfThePlan;

              if (isCompleted) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeedbackFormScreen(
                      id: id,
                      workoutPlan: workoutPlan,
                    )));
              }


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
    });


    isPause = false;

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
            "dayCountFinished": workoutPlan.dayCountFinished + 1,
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
          tWorkoutPlanPath: {
            "isCancelled": !workoutPlan.isCancelled,
            "dayCountFinished": 0,
          }
        }, SetOptions(merge: true))
        .then((value) => debugPrint("Update cancel status!"))
        .onError((error, stackTrace) => debugPrint("Failed to update! $error"));

    notifyListeners();
  }

  Future<void> updateExpertProgram({
    required bool deleteProgram,
    required bool isWorkoutPlan,
    required String id,
    required String expertId,
  }) async {

    if (isWorkoutPlan) {
      final path = _db.collection(tWorkoutPlanPath).doc(expertId);

      await path.get().then((value) async {
        final map = value.data();

        if (map != null) {
          final List<WorkoutPlan> workoutPlanList = (map["${tWorkoutPlanPath}s"] as List).map((e) =>
              WorkoutPlan.fromJson(e)).toList();

          for (int i = 0; i < workoutPlanList.length; i++) {
            if (id == workoutPlanList[i].id) {
              workoutPlanList[i] = workoutPlanList[i].copyWith(
                isDeleted: deleteProgram,
              );
              break; // Exit the loop once the item is found and updated
            }
          }

          final Map<String, dynamic> data = {
            "workoutPlans": workoutPlanList.map((e) => e.toJson()).toList(),
          };

          await path.set(data, SetOptions(merge: true))
              .then((value) => debugPrint("Deleted: $id successfully!"))
              .onError((error, stackTrace) => debugPrint("Failed to delete! $error"));
        }
      });

    } else {
      final path = _db.collection(tWorkoutMealPath).doc(expertId);

      await path.get().then((value) async {
        final map = value.data();

        if (map != null) {
          final List<WorkoutMeal> workoutMealList = (map["${tWorkoutMealPath}s"] as List).map((e) => WorkoutMeal.fromJson(e)).toList();

          for (int i = 0; i < workoutMealList.length; i++) {
            if (id == workoutMealList[i].id) {
              workoutMealList[i] = workoutMealList[i].copyWith(
                isDeleted: deleteProgram,
              );
              break; // Exit the loop once the item is found and updated
            }
          }

          final Map<String, dynamic> data = {
            "workoutMeals": workoutMealList.map((e) => e.toJson()).toList(),
          };


          await path.set(data, SetOptions(merge: true))
              .then((value) => debugPrint("Deleted: $id successfully!"))
              .onError((error, stackTrace) => debugPrint("Failed to delete!: $error"));
        }

      });
    }
  }

  Future<void> followExpert({
    required String expertId,
    required String clientId,
    required ExpertModel expertModel,
  }) async {

    final List<String> expertFollowers = expertModel.followers;

    if (expertFollowers.contains(clientId)) {
      expertFollowers.remove(clientId);
    } else {
      expertFollowers.add(clientId);
    }

    final List<String> followingExperts = await _db.collection(tClientPath).doc(clientId).get().then((value) {
      final map = value.data()!;

      List<dynamic> followingExpertsDynamic = map["followingExperts"];
      return followingExpertsDynamic.map((e) => e.toString()).toList();
    });

    if (followingExperts.contains(expertId)) {
      followingExperts.remove(expertId);
    } else {
      followingExperts.add(expertId);
    }


    // add experts in client follower list
    await _db.collection(tClientPath).doc(clientId).set({
      "followingExperts": followingExperts,
    }, SetOptions(merge: true))
      .then((value) => debugPrint("Update follow/unfollow expert: ${expertModel.uid}!"))
      .onError((error, stackTrace) => debugPrint("Error: $error"));


    // add client in expert followers list
    await _db.collection(tExpertPath).doc(expertId).set({
      "followers": expertFollowers,
    }, SetOptions(merge: true))
        .then((value) => debugPrint("Update follow/unfollow expert: ${clientId}!"))
        .onError((error, stackTrace) => debugPrint("Error: $error"));

    notifyListeners();
  }

  Stream<List<String>>? finishedPlanStream;

  Stream<List<String>> getFinishedPlanStream(String id) {
    return _db.collection("finished").doc(id).snapshots().map((snap) {
      return (snap.data() as List).map((e) => e.toString()).toList();
    });
  }

  void updateFinishedPlanStream(String id) {
    finishedPlanStream = getFinishedPlanStream(id);
    notifyListeners();
  }
}
