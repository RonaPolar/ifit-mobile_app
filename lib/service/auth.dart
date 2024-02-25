import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:image_picker/image_picker.dart';

class Auth extends ChangeNotifier {

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage ref = FirebaseStorage.instance;

  static TextEditingController firstName = TextEditingController();
  static TextEditingController lastName = TextEditingController();
  static TextEditingController name = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController newEmail = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController newPassword = TextEditingController();
  static TextEditingController confirmPassword = TextEditingController();
  static TextEditingController birthday = TextEditingController();
  static TextEditingController phone = TextEditingController();
  static TextEditingController profession = TextEditingController();
  static TextEditingController description = TextEditingController();


  String? registerUserType;

  List<String> userTypeList = [
    "Client",
    "Expert"
  ];

  void updateRegisterUserType(String value) {
    registerUserType = value;
    notifyListeners();
  }

  Future<String?> createUser() async {
    final String path = "${registerUserType}s".toLowerCase();
    showHUD(true);
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text
      );

      String? uid = userCredential.user?.uid;

      await db.collection(path).doc(uid).set({
        'date_creation': FieldValue.serverTimestamp(),
        'uid': uid,
        'name': firstName.text,
        'email': email.text,
        'user_type': registerUserType,
        'verified': false,
      }).then((value) => debugPrint("Added successfully!"));

      showHUD(false);

      return uid;
    } catch (e) {

      showHUD(false);
    }
    return null;
  }

  String? gender;

  List<String> genderList = [
    "Male",
    "Female"
  ];

  void updateGender(String? value) {
    gender = value;
    notifyListeners();
  }

  DateTime? dateOfBirth;

  void updateDateOfBirth(DateTime? value) {
    dateOfBirth = value;
    notifyListeners();
  }

  static TextEditingController weight = TextEditingController();
  static TextEditingController height = TextEditingController();

  String? goalDifficulty;

  List<String> goalDifficultyList = [
    "Beginner",
    "Intermediate",
    "Expert"
  ];

  void updateGoalDifficulty(String? value) {
    goalDifficulty = value;
    notifyListeners();
  }

  String? fitnessGoal;

  List<String> fitnessGoalList = [
    "Loss Weight",
    "Body Toning",
    "Gain Muscles"
  ];

  void updateFitnessGoal(String? value) {
    fitnessGoal = value;
    notifyListeners();
  }

  List<String> specificBody = [];

  List<String> specificBodyList = [
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

  void updateSpecificBody(String value) {
    if (!specificBody.contains(value)) {
      specificBody.add(value);
    } else {
      specificBody.remove(value);
    }
    notifyListeners();
  }

  String? goalPlan;

  List<String> goalPlanList = [
    "Body exercises",
    "Lifting weights",
    "Food restrictions"
  ];

  void updateGoalPlan(String? value) {
    goalPlan = value;
    notifyListeners();
  }

  String? goalDuration;

  List<String> goalDurationList = [
    "Less than 30 minutes",
    "An hour",
    "More than an hour"
  ];

  void updateGoalDuration(String? value) {
    goalDuration = value;
    notifyListeners();
  }

  String? goalInAWeek;

  List<String> goalInAWeekList = [
    "None",
    "Once a week",
    "Twice a week",
    "3-4 times a week",
    "More than",
  ];

  void updateGoalInAWeek(String? value) {
    goalInAWeek = value;
    notifyListeners();
  }

  String? healthComplication;

  List<String> healthComplicationsList = [
    "None",
    "Injuries",
    "Breathing complications (ex: Asthma)",
    "Cardiovascular diseases",
  ];

  void updateHealthComplication(String? value) {
    healthComplication = value;
    notifyListeners();
  }

  Future<void> updateClientPersonalProfile({
    required String id,
  }) async {
    await db.collection(tClientPath).doc(id).update({
      "phone_number": phone.text,
      "gender": gender!,
      "birth_date": dateOfBirth,
      "weight": weight.text,
      "height": height.text,
    }).then((value) => debugPrint("Update successfully! $id"));
  }

  Future<void> updateClientGoalProfile(String id) async {
    final ClientGoalModel clientGoalModel = ClientGoalModel(
      level: goalDifficulty!,
      fitnessGoals: fitnessGoal!,
      bodyPart: specificBody,
      goalPlan: goalPlan!,
      exerciseDuration: goalDuration!,
      exerciseInAWeek: goalInAWeek!,
      healthComplication: healthComplication!,
    );

    await db.collection(tClientPath).doc(id).update({
      "goal": clientGoalModel.toJson(),
    }).then((value) => debugPrint("Update successfully! $id"));
  }

  String userType = "";

  Future<void> login() async {
    debugPrint("Signing in...");
    showHUD(true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      ).then((user) async {
        if (user.user != null) {
          await FirebaseFirestore.instance
              .collection(tExpertPath)
              .where('email', isEqualTo: email.text)
              .get()
              .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.isEmpty) {
              return "";
            } else {
              final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
              userType = data["user_type"];
            }
          });

          await FirebaseFirestore.instance
              .collection(tClientPath)
              .where('email', isEqualTo: email.text)
              .get()
              .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.isEmpty) {
              return "";
            } else {
              final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
              userType = data["user_type"];
            }
          });

          showHUD(false);
          email.clear();
          password.clear();
          notifyListeners();

        }
      });
    } catch (e) {
      showHUD(false);
    }

  }

  Stream<User?> get userStream => FirebaseAuth.instance.authStateChanges();

  /// EXPERTS -------------------->
  XFile? professionId;
  XFile? proofOfStudy;

  Future<void> uploadProfessionId(BuildContext context) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        professionId = img;
        notifyListeners();
      },
    );
  }

  Future<void> uploadProofOfStudy(BuildContext context) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        try {
          proofOfStudy = img;
          notifyListeners();
        } catch (e) {
          print("No image selected");
        }
      },
    );
  }

  String? professionIdUrl;
  String? proofOfStudyUrl;

  Future<void> next({
    required String uid,
  }) async {
    Future.wait([
      storeProfessionalId(),
      storeProofOfStudy(),
    ]).then((value) async {
      await db.collection(tExpertPath).doc(uid).update({
        "profession_id": professionIdUrl,
        "proof_of_field_of_study": proofOfStudyUrl,
        "gender": gender,
        "birth_date": dateOfBirth,
        "phone_number": phone.text,
        "profession": profession.text,
        "description": description.text,
      });
    });
  }

  Future<void> storeProfessionalId() async {
    // store professionId to storage
    final file = File(professionId!.path);
    final ref = FirebaseStorage.instance.ref()
        .child(tExpertPath)
        .child(professionId!.name);
    await ref.putFile(file);

    // store professionId to firestore
    professionIdUrl = await ref.getDownloadURL();
  }

  Future<void> storeProofOfStudy() async {
    // store proof of study to storage
    final file = File(proofOfStudy!.path);
    final ref = FirebaseStorage.instance.ref()
        .child(tExpertPath)
        .child(proofOfStudy!.name);
    await ref.putFile(file);

    // store proof of study to firestore
    proofOfStudyUrl = await ref.getDownloadURL();
  }

  Future<void> editExpertProfile(String id) async {
    final path = db.collection(tExpertPath).doc(id);

    showHUD(true);
    await path.set({
      "name": name.text,
      "email": email.text,
      "phone_number": phone.text,
      "profession": profession.text,
    }, SetOptions(merge: true))
      .then((value) {
        showHUD(false);
        return debugPrint("Profile successfully updated!");
      })
      .onError((error, stackTrace) => debugPrint("Error updating! $error"));

    notifyListeners();
  }

  Future<void> editClientProfile(String id) async {
    final path = db.collection(tClientPath).doc(id);

    showHUD(true);
    await path.set({
      "name": name.text,
      "phone_number": phone.text,
      "gender": gender,
      "height": height.text,
      "weight": weight.text,
    }, SetOptions(merge: true))
        .then((value) {
      showHUD(false);
      return debugPrint("Profile successfully updated!");
    })
        .onError((error, stackTrace) => debugPrint("Error updating! $error"));

    notifyListeners();
  }

  Future<void> updateEmail(String id, {
    bool isClient = true,
  }) async {
    showHUD(true);
    try {

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      User? user = userCredential.user;

      if (user != null) {
        await user.updateEmail(newEmail.text)
            .then((value) => debugPrint("Email updated successfully on auth!"));

        db.collection(isClient ? tClientPath : tExpertPath).doc(id).set({
          "email": newEmail.text,
        }, SetOptions(merge: true))
            .then((value) => debugPrint("Email updated succesfully!"));
      } else {
        print("User is null");
      }

      showHUD(false);
      password.clear();
      email.clear();
      newEmail.clear();
    } catch (e) {
      print("Failed to update email: $e");
      showHUD(false);

    }
  }

  Future<void> updatePassword(String id) async {
    showHUD(true);
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePassword(password.text)
            .then((value) => debugPrint("Password updated successfully on auth!"));
      }

      showHUD(false);
      password.clear();
      newPassword.clear();
      confirmPassword.clear();
    } catch (e) {
      print("Failed to update password: $e");
      showHUD(false);

    }
  }

  Future<void> deleteAccount({
    bool isClient = true,
}) async {
    showHUD(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final User? user = userCredential.user;

      if (user != null) {
        await user.delete()
            .then((value) => debugPrint("Deleted account! ${user.uid}"));

        await db.collection(isClient ? tClientPath : tExpertPath).doc(user.uid).delete()
            .then((value) => debugPrint("Deleted account! ${user.uid}"));
      }
      password.clear();
      email.clear();
      showHUD(false);


    } catch (e) {
      showHUD(false);
      throw e;
    }
  }

  double rating = 0;

  void updateRating(double value) {
    rating = value;
    notifyListeners();
  }

  Future<void> updateAddRating({
    required String id,
    required WorkoutPlan workoutPlan,
  }) async {
    final clientPath = db.collection(tClientPath)
        .doc(id).collection(tWorkoutPlanPath)
        .doc(workoutPlan.id);

    final WorkoutPlan plan =  await clientPath.get().then((value) {
      final map = value.data()!;

      return WorkoutPlan.fromJson(map[tWorkoutPlanPath]);
    });

    final int ratingCount = plan.ratingCount;
    final double totalRating = rating + plan.rating;

    await clientPath.set({
      tWorkoutPlanPath: workoutPlan.copyWith(
        ratingCount: ratingCount + 1,
        rating: totalRating,
        dayCountFinished: workoutPlan.dayCountFinished! + 1,
      ).toJson(),
    }, SetOptions(merge: true)).then((value) => debugPrint("Added rating successfully!"))
      .onError((error, stackTrace) => debugPrint("Error add rating: $error"));
  }

  Future<void> updateProfileAssessment({
    required String id,
  }) async {
    final path = db.collection(tClientPath).doc(id);

    final ClientGoalModel goalModel = await path.get().then((value) {
      final map = value.data()!;

      return ClientGoalModel.fromJson(map["goal"]);
    });

    await path.set({
      "goal": goalModel.copyWith(
        fitnessGoals: fitnessGoal,
        level: goalDifficulty,
        bodyPart: specificBody,
      ).toJson(),
      "height": height.text,
      "weight": weight.text,
    }, SetOptions(merge: true)).then((value) => debugPrint("Update feedback assessment!"))
      .onError((error, stackTrace) => debugPrint("Error feedback! $error"));
  }
}