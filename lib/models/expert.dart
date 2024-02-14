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
  final String birthDate;
  final DateTime dateCreation;
  final String? datejoined;
  final String email;
  final String gender;
  final String name;
  final String phoneNumber;
  final String? photoUrl;
  final String profession;
  final String professionId;
  final String proofOfFieldOfStudy;
  final double? rating;
  final String uid;
  final String userType;
  final bool verified;

  ExpertModel({
    required this.birthDate,
    this.datejoined,
    required this.email,
    required this.gender,
    required this.name,
    required this.phoneNumber,
    this.photoUrl,
    required this.profession,
    required this.professionId,
    required this.proofOfFieldOfStudy,
    this.rating = 0.0,
    required this.uid,
    required this.userType,
    required this.verified,
    required this.dateCreation,
  });

  ExpertModel copyWith({
    String? birthDate,
    String? datejoined,
    String? email,
    String? gender,
    String? name,
    String? phoneNumber,
    String? photoUrl,
    String? profession,
    String? professionId,
    String? proofOfFieldOfStudy,
    double? rating,
    String? uid,
    String? userType,
    bool? verified,
    DateTime? dateCreation,
  }) =>
      ExpertModel(
        birthDate: birthDate ?? this.birthDate,
        datejoined: datejoined ?? this.datejoined,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl: photoUrl ?? this.photoUrl,
        profession: profession ?? this.profession,
        professionId: professionId ?? this.professionId,
        proofOfFieldOfStudy: proofOfFieldOfStudy ?? this.proofOfFieldOfStudy,
        rating: rating ?? this.rating,
        uid: uid ?? this.uid,
        userType: userType ?? this.userType,
        verified: verified ?? this.verified,
        dateCreation: dateCreation ?? this.dateCreation,
      );

  factory ExpertModel.fromJson(Map<String, dynamic> json) => ExpertModel(
    birthDate: json["birth_date"],
    dateCreation: (json["date_creation"] as Timestamp).toDate(),
    datejoined: json["datejoined"],
    email: json["email"],
    gender: json["gender"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    photoUrl: json["photo_url"],
    profession: json["profession"],
    professionId: json["profession_id"],
    proofOfFieldOfStudy: json["proof_of_field_of_study"],
    rating: json["rating"] ?? 0.0,
    uid: json["uid"],
    userType: json["user_type"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "birth_date": birthDate,
    "datejoined": datejoined,
    "email": email,
    "gender": gender,
    "name": name,
    "phone_number": phoneNumber,
    "photo_url": photoUrl,
    "profession": profession,
    "profession_id": professionId,
    "proof_of_field_of_study": proofOfFieldOfStudy,
    "rating": rating,
    "uid": uid,
    "user_type": userType,
    "verified": verified,
    "date_creation": Timestamp.fromDate(dateCreation),
  };
}



