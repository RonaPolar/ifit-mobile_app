import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
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

  void updateWorkoutPurpose(String? value) {
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
  static TextEditingController workoutDescription = TextEditingController();
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
    final auth = await _db.collection(tExpertPath).doc(id).get();
    final String expertName = auth.get("name");

    await uploadWorkoutPhoto(id).then((value) async {

      final WorkoutPlan workoutPlan = WorkoutPlan(
        category: workoutCategory ?? "",
        purpose: workoutPurpose ?? "",
        difficulty: workoutDifficulty ?? "",
        planName: planName.text,
        description: workoutDescription.text,
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
        expertName: expertName,
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
    workoutDescription.clear();
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

  final List<String> foodCategoryList = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
    "Drinks"
  ];

  void updateFoodCategory(String? value) {
    foodCategory = value;
    notifyListeners();
  }

  static TextEditingController foodPlanName = TextEditingController();
  static TextEditingController foodDescription = TextEditingController();

  XFile? workoutMeal;

  Future<void> uploadWorkoutMeal(BuildContext context) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        workoutMeal = img;
        notifyListeners();
      },
    );
  }

  static TextEditingController mealCalories = TextEditingController();
  static TextEditingController mealFats = TextEditingController();
  static TextEditingController mealSugar = TextEditingController();
  static TextEditingController mealProtein = TextEditingController();

  List<TextEditingController> ingredientsList = [];

  void updateIngredientsList(bool add) {
    if (add) {
      ingredientsList.add(TextEditingController());
    } else if (ingredientsList.isNotEmpty) {
      ingredientsList.removeAt(ingredientsList.length - 1);
    }
    notifyListeners();
  }

  List<TextEditingController> mealPreparationsList = [];

  void updateMealPreparationsList(bool add) {
    if (add) {
      mealPreparationsList.add(TextEditingController());
    } else if (mealPreparationsList.isNotEmpty) {
      mealPreparationsList.removeAt(mealPreparationsList.length - 1);
    }
    notifyListeners();
  }

  String? workoutMealPhoto;

  Future<void> uploadWorkoutMealPhoto(String id) async {
    final file = File(workoutMeal!.path);
    final ref = FirebaseStorage.instance.ref()
        .child(tWorkoutMealPath)
        .child(id)
        .child(workoutMeal!.name);
    await ref.putFile(file);

    workoutMealPhoto = await ref.getDownloadURL();
    notifyListeners();
  }

  Future<void> addWorkoutMeal({
    required String id,
  }) async {

    final data = await _db.collection(tWorkoutPlanPath).doc(id).get();
    final auth = await _db.collection(tExpertPath).doc(id).get();
    final String expertName = auth.get("name");

    await uploadWorkoutMealPhoto(id).then((value) async {
      final WorkoutMeal workoutMeal = WorkoutMeal(
        foodCategory: foodCategory ?? "",
        purpose: workoutPurpose ?? "",
        foodPlanName: foodPlanName.text,
        description: foodDescription.text,
        foodPhoto: workoutMealPhoto!,
        calories: mealCalories.text,
        fats: mealFats.text,
        sugar: mealSugar.text,
        protein: mealSugar.text,
        rating: 0,
        expertName: expertName,
        ingredients: ingredientsList.map((e) => e.text).toList(),
        stepPrep: mealPreparationsList.map((e) => e.text).toList(),
      );

      final Map<String, dynamic>? hasWorkoutMeals = data.data();

      if (hasWorkoutMeals == null) {
        await _db.collection(tWorkoutMealPath).doc(id).set({
          "workoutMeals": [
            workoutMeal.toJson(),
          ],
        })
          .then((value) => debugPrint("Workout meal added successfully!"))
          .onError((error, stackTrace) => "Failed: $error");
      } else {
        final List objects = data["workoutMeals"];

        objects.add(workoutMeal.toJson());
        await _db.collection(tWorkoutMealPath).doc(id).set({
          "workoutMeals": objects,
        })
          .then((value) => debugPrint("Workout meal added successfully!"))
          .onError((error, stackTrace) => "Failed: $error");
      }
    });
  }

  void clearWorkoutMealForm() {
    foodCategory = null;
    workoutPurpose = null;
    foodPlanName.clear();
    foodDescription.clear();
    workoutMeal = null;
    workoutMealPhoto = null;
    mealCalories.clear();
    mealFats.clear();
    mealSugar.clear();
    mealProtein.clear();
    ingredientsList = [];
    mealPreparationsList = [];
    notifyListeners();
  }




}