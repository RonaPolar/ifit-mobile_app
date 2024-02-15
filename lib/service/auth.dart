import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:image_picker/image_picker.dart';

class Auth extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage ref = FirebaseStorage.instance;

  static TextEditingController firstName = TextEditingController();
  static TextEditingController lastName = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController birthday = TextEditingController();
  static TextEditingController phone = TextEditingController();
  static TextEditingController profession = TextEditingController();


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

    return uid;
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

  List<String> fitnessGoal = [];

  List<String> fitnessGoalList = [
    "Loss Weight",
    "Body Toning",
    "Gain Muscles"
  ];

  void updateFitnessGoal(String value) {
    if (!fitnessGoal.contains(value)) {
      fitnessGoal.add(value);
    } else {
      fitnessGoal.remove(value);
    }
    notifyListeners();
  }

  List<String> specificBody = [];

  /// TODO: update this to latest
  List<String> specificBodyList = [
    'Upper body',
    'Abdominal',
    'Lower body',
    'Full body'
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
      fitnessGoals: fitnessGoal,
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

        notifyListeners();

      } else {
      }
    });
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
        "birth_date": birthday.text,
        "phone_number": phone.text,
        "profession": profession.text,
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

}