import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/workout.dart';

class WorkoutProvider extends ChangeNotifier {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  int workoutIndex = 0;

  void updateSkipWorkout({
    required List<ExerciseElement> exerciseList,
  }) {
    final List<ExerciseElement> initialList = exerciseList;

    if (workoutIndex != exerciseList.length - 1) {
      exerciseList.removeAt(workoutIndex);
      exerciseList.add(initialList[workoutIndex]);
    }


    notifyListeners();
  }

  int setFinished = 1;

  Future<void> updateDoneWorkout({
    required List<ExerciseElement> exerciseList,
    required String id,
    required String workoutId,
    required int set,
  }) async {



    if (set == setFinished) { // if you are done with the whole set
      await updateWorkoutDay(id: id, workoutId: workoutId).then((value) {
        setFinished = 1;
      });
    } else if (exerciseList.length - 1 != workoutIndex) { // if you are not done
      // with the whole exercises
      workoutIndex++;
    } else if (exerciseList.length - 1 == workoutIndex && setFinished != set) {
      // if you are done with the exercises but is not finished with the set
      setFinished++;
      workoutIndex = 0;
    }

    notifyListeners();
  }

  Future<void> updateWorkoutDay({
    required String id,
    required String workoutId,
  }) async {

    final path = _db.collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutId);

    final data = await path.get();

    final map = data.data()!["workoutPlan"];
    final WorkoutPlan workoutPlan = WorkoutPlan.fromJson(map);

    await path.set({
      "workoutPlan": {
        "dayCountFinished": workoutPlan.dayCountFinished != null
          ? workoutPlan.dayCountFinished! + 1
          : 1,
      }
    }, SetOptions(merge: true)).then((value) => debugPrint("Day Count Finished Updated!"))
      .onError((error, stackTrace) => debugPrint("Error Updating! $error"));

    notifyListeners();
  }

  void clearExerciseForm() {
    setFinished = 1;
    workoutIndex = 0;
    notifyListeners();
  }

  bool isFavorite = false;

  Future<void> updateAddToFavorite({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {
    final path = _db.collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutPlan.id);

    await path.set({
      tWorkoutPlanPath: {
        "isFavorite": !workoutPlan.isFavorite,
      }
    }, SetOptions(merge: true))
      .then((value) {
        return debugPrint("Update favorites successfully!");
    })
      .onError((error, stackTrace) => debugPrint("Error! $stackTrace"));

    notifyListeners();
  }

  Future<void> cancelWorkout({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {
    final path = _db.collection(tClientPath)
        .doc(id)
        .collection(tWorkoutPlanPath)
        .doc(workoutPlan.id);

    await path.set({
      tWorkoutPlanPath: {
        "isCancelled": !workoutPlan.isCancelled
      }
    }, SetOptions(merge: true))
      .then((value) => debugPrint("Update cancel status!"))
      .onError((error, stackTrace) => debugPrint("Failed to update! $error"));

    notifyListeners();
  }
}