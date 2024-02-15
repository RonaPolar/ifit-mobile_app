import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final String birthDate;
  final String email;
  final String gender;
  final String height;
  final String name;
  final String phoneNumber;
  final String photoUrl;
  final String uid;
  final String userType;
  final String weight;
  final List<dynamic>? mealPlans;
  final List<dynamic>? workoutPlans;
  final DateTime dateCreation;

  ClientModel({
    required this.birthDate,
    required this.email,
    required this.gender,
    required this.height,
    required this.name,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
    required this.userType,
    required this.weight,
    this.mealPlans,
    this.workoutPlans,
    required this.dateCreation,
  });

  ClientModel copyWith({
    String? birthDate,
    String? email,
    String? gender,
    String? height,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    String? uid,
    String? userType,
    String? weight,
    List<dynamic>? mealPlans,
    List<dynamic>? workoutPlans,
    DateTime? dateCreation,
  }) =>
      ClientModel(
        birthDate: birthDate ?? this.birthDate,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl: photoUrl ?? this.photoUrl,
        uid: uid ?? this.uid,
        userType: userType ?? this.userType,
        weight: weight ?? this.weight,
        mealPlans: mealPlans ?? this.mealPlans,
        workoutPlans: workoutPlans ?? this.workoutPlans,
        dateCreation: dateCreation ?? this.dateCreation,
      );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    birthDate: json["birth_date"],
    email: json["email"],
    gender: json["gender"],
    height: json["height"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    photoUrl: json["photo_url"],
    uid: json["uid"],
    userType: json["user_type"],
    weight: json["weight"],
    mealPlans: List<dynamic>.from(json["meal_plans"].map((x) => x)),
    workoutPlans: List<dynamic>.from(json["workout_plans"].map((x) => x)),
    dateCreation: (json["date_creation"] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    "birth_date": birthDate,
    "email": email,
    "gender": gender,
    "height": height,
    "name": name,
    "phone_number": phoneNumber,
    "photo_url": photoUrl,
    "uid": uid,
    "user_type": userType,
    "weight": weight,
    "meal_plans": mealPlans != null ? List<dynamic>.from(mealPlans!.map((x) => x)) : [],
    "workout_plans": workoutPlans != null ? List<dynamic>.from(workoutPlans!.map((x) => x)) : [],
    "date_creation": Timestamp.fromDate(dateCreation),
  };
}

class ClientGoalModel {
  final String level;
  final List<String> fitnessGoals;
  final List<String> bodyPart;
  final List<String> goalPlan;
  final String exerciseDuration;
  final String exerciseInAWeek;
  final String healthComplication;

  ClientGoalModel({
    required this.level,
    required this.fitnessGoals,
    required this.bodyPart,
    required this.goalPlan,
    required this.exerciseDuration,
    required this.exerciseInAWeek,
    required this.healthComplication,
  });

  ClientGoalModel copyWith({
    String? level,
    List<String>? fitnessGoals,
    List<String>? bodyPart,
    List<String>? goalPlan,
    String? exerciseDuration,
    String? exerciseInAWeek,
    String? healthComplications,
  }) =>
      ClientGoalModel(
        level: level ?? this.level,
        fitnessGoals: fitnessGoals ?? this.fitnessGoals,
        bodyPart: bodyPart ?? this.bodyPart,
        goalPlan: goalPlan ?? this.goalPlan,
        exerciseDuration: exerciseDuration ?? this.exerciseDuration,
        exerciseInAWeek: exerciseInAWeek ?? this.exerciseInAWeek,
        healthComplication: healthComplications ?? this.healthComplication,
      );

  factory ClientGoalModel.fromJson(Map<String, dynamic> json) => ClientGoalModel(
    level: json["level"],
    fitnessGoals: List<String>.from(json["fitnessGoals"].map((x) => x)),
    bodyPart: List<String>.from(json["bodyPart"].map((x) => x)),
    goalPlan: List<String>.from(json["goalPlan"].map((x) => x)),
    exerciseDuration: json["exerciseDuration"],
    exerciseInAWeek: json["exerciseInAWeek"],
    healthComplication: json["healthComplications"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "fitnessGoals": List<dynamic>.from(fitnessGoals.map((x) => x)),
    "bodyPart": List<dynamic>.from(bodyPart.map((x) => x)),
    "goalPlan": List<dynamic>.from(goalPlan.map((x) => x)),
    "exerciseDuration": exerciseDuration,
    "exerciseInAWeek": exerciseInAWeek,
    "healthComplications": healthComplication,
  };
}




