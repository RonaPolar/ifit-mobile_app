// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

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
  final List<dynamic> mealPlans;
  final List<dynamic> workoutPlans;
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
    required this.mealPlans,
    required this.workoutPlans,
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
    "meal_plans": List<dynamic>.from(mealPlans.map((x) => x)),
    "workout_plans": List<dynamic>.from(workoutPlans.map((x) => x)),
    "date_creation": Timestamp.fromDate(dateCreation),
  };
}
