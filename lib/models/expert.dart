import 'package:cloud_firestore/cloud_firestore.dart';

class Expert {
  final String name;
  final String image;
  final String profession;
  final String rate;
  final String mealCreated;
  final String workoutCreated;
  final String descriptions;

  Expert({
    required this.name,
    required this.image,
    required this.profession,
    required this.rate,
    required this.mealCreated,
    required this.workoutCreated,
    required this.descriptions,
  });

  Expert copyWith({
    String? name,
    String? image,
    String? profession,
    String? rate,
    String? mealCreated,
    String? workoutCreated,
    String? descriptions,
  }) =>
      Expert(
        name: name ?? this.name,
        image: image ?? this.image,
        profession: profession ?? this.profession,
        rate: rate ?? this.rate,
        mealCreated: mealCreated ?? this.mealCreated,
        workoutCreated: workoutCreated ?? this.workoutCreated,
        descriptions: descriptions ?? this.descriptions,
      );

  factory Expert.fromJson(Map<String, dynamic> json) => Expert(
    name: json["name"],
    image: json["image"],
    profession: json["profession"],
    rate: json["rate"],
    mealCreated: json["mealCreated"],
    workoutCreated: json["workoutCreated"],
    descriptions: json["descriptions"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "profession": profession,
    "rate": rate,
    "mealCreated": mealCreated,
    "workoutCreated": workoutCreated,
    "descriptions": descriptions,
  };
}


///
class ExpertModel {
  final DateTime? birthDate;
  final DateTime dateCreation;
  final String email;
  final String gender;
  final String name;
  final String phoneNumber;
  final String profession;
  final String professionId;
  final String proofOfFieldOfStudy;
  final num? rating;
  final String uid;
  final String userType;
  final bool verified;
  final String description;
  final num ratingCount;

  ExpertModel({
    this.birthDate,
    required this.email,
    this.gender = "n/a",
    required this.name,
    this.phoneNumber = "n/a",
    this.profession = "n/a",
    this.professionId = "",
    this.proofOfFieldOfStudy = "",
    this.rating = 0.0,
    this.ratingCount = 0,
    required this.uid,
    required this.userType,
    required this.verified,
    required this.dateCreation,
    this.description = "n/a",
  });

  ExpertModel copyWith({
    DateTime? birthDate,
    String? email,
    String? gender,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    String? profession,
    String? professionId,
    String? proofOfFieldOfStudy,
    num? rating,
    String? uid,
    String? userType,
    bool? verified,
    DateTime? dateCreation,
    String? description,
    num? ratingCount,
  }) =>
      ExpertModel(
        birthDate: birthDate ?? this.birthDate,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profession: profession ?? this.profession,
        professionId: professionId ?? this.professionId,
        proofOfFieldOfStudy: proofOfFieldOfStudy ?? this.proofOfFieldOfStudy,
        rating: rating ?? this.rating,
        uid: uid ?? this.uid,
        userType: userType ?? this.userType,
        verified: verified ?? this.verified,
        dateCreation: dateCreation ?? this.dateCreation,
        description: description ?? this.description,
        ratingCount: ratingCount ?? this.ratingCount,
      );

  factory ExpertModel.fromJson(Map<String, dynamic> json) => ExpertModel(
    birthDate: (json["birth_date"] as Timestamp).toDate(),
    dateCreation: (json["date_creation"] as Timestamp).toDate(),
    email: json["email"],
    gender: json["gender"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    profession: json["profession"],
    professionId: json["profession_id"],
    proofOfFieldOfStudy: json["proof_of_field_of_study"],
    rating: json["rating"] as num,
    uid: json["uid"],
    userType: json["user_type"],
    verified: json["verified"],
    description: json["description"],
    ratingCount: json["ratingCount"] as num,
  );

  Map<String, dynamic> toJson() => {
    "birth_date": birthDate == null
        ? Timestamp.fromDate(DateTime.now())
        : Timestamp.fromDate(birthDate!),
    "email": email,
    "gender": gender,
    "name": name,
    "phone_number": phoneNumber,
    "profession": profession,
    "profession_id": professionId,
    "proof_of_field_of_study": proofOfFieldOfStudy,
    "rating": rating,
    "uid": uid,
    "user_type": userType,
    "verified": verified,
    "date_creation": Timestamp.fromDate(dateCreation),
    "description": description,
    "ratingCount": ratingCount,
  };
}



