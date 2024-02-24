import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifit/models/workout.dart';

class ClientModel {
  final DateTime? birthDate;
  final DateTime dateCreation;
  final String email;
  final String gender;
  final ClientGoalModel? clientGoalModel;
  final String height;
  final String name;
  final String phoneNumber;
  final String? photoUrl;
  final String uid;
  final String userType;
  final String weight;
  final List<WorkoutPlan> workoutPlanList;

  ClientModel({
    this.birthDate,
    required this.email,
    this.gender = "n/a",
    this.height = "0",
    required this.name,
    this.phoneNumber = "n/a",
    required this.photoUrl,
    required this.uid,
    required this.userType,
    this.weight = "0",
    required this.dateCreation,
    this.clientGoalModel,
    required this.workoutPlanList,
  });

  ClientModel copyWith({
    DateTime? birthDate,
    String? email,
    String? gender,
    String? height,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    String? uid,
    String? userType,
    String? weight,
    DateTime? dateCreation,
    ClientGoalModel? clientGoalModel,
    List<WorkoutPlan>? workoutPlanList,
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
        dateCreation: dateCreation ?? this.dateCreation,
        clientGoalModel: clientGoalModel ?? this.clientGoalModel,
        workoutPlanList: workoutPlanList ?? this.workoutPlanList,
      );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    birthDate: (json["birth_date"] as Timestamp).toDate(),
    email: json["email"],
    gender: json["gender"],
    height: json["height"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    photoUrl: json["photo_url"],
    uid: json["uid"],
    userType: json["user_type"],
    weight: json["weight"],
    dateCreation: (json["date_creation"] as Timestamp).toDate(),
    clientGoalModel: ClientGoalModel.fromJson(json["goal"]),
    workoutPlanList: json["workoutPlans"] != null
        ? List<WorkoutPlan>.from(json["workoutPlans"].map((x) => x))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "birth_date": birthDate == null
        ? DateTime.now()
        : Timestamp.fromDate(birthDate!),
    "email": email,
    "gender": gender,
    "height": height,
    "name": name,
    "phone_number": phoneNumber,
    "photo_url": photoUrl,
    "uid": uid,
    "user_type": userType,
    "weight": weight,
    "date_creation": Timestamp.fromDate(dateCreation),
    "goal": clientGoalModel?.toJson(),
    "workoutPlans": List<dynamic>.from(workoutPlanList.map((x) => x)),
  };
}

class ClientGoalModel {
  final String level;
  final String fitnessGoals;
  final List<String> bodyPart;
  final String goalPlan;
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
    String? fitnessGoals,
    List<String>? bodyPart,
    String? goalPlan,
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
    fitnessGoals: json["fitnessGoals"],
    bodyPart: List<String>.from(json["bodyPart"].map((x) => x)),
    goalPlan: json["goalPlan"],
    exerciseDuration: json["exerciseDuration"],
    exerciseInAWeek: json["exerciseInAWeek"],
    healthComplication: json["healthComplications"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "fitnessGoals": fitnessGoals,
    "bodyPart": List<dynamic>.from(bodyPart.map((x) => x)),
    "goalPlan": goalPlan,
    "exerciseDuration": exerciseDuration,
    "exerciseInAWeek": exerciseInAWeek,
    "healthComplications": healthComplication,
  };
}




