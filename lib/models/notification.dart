import 'package:cloud_firestore/cloud_firestore.dart';

class NotifModel {
  final String id;
  final String photoUrl;
  final String title;
  final DateTime dateCreated;
  final String planId;
  final bool? read;

  NotifModel({
    required this.id,
    required this.photoUrl,
    required this.title,
    required this.dateCreated,
    required this.planId,
    this.read = false,
  });

  NotifModel copyWith({
    String? id,
    String? photoUrl,
    String? title,
    DateTime? dateCreated,
    String? planId,
    bool? read,
  }) =>
      NotifModel(
        id: id ?? this.id,
        photoUrl: photoUrl ?? this.photoUrl,
        title: title ?? this.title,
        dateCreated: dateCreated ?? this.dateCreated,
        planId: planId ?? this.planId,
        read: read ?? this.read,
      );

  factory NotifModel.fromJson(Map<String, dynamic> json) => NotifModel(
    id: json["id"],
    photoUrl: json["photoUrl"],
    title: json["title"],
    dateCreated: (json["dateCreated"] as Timestamp).toDate(),
    planId: json["planId"],
    read: json["read"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photoUrl": photoUrl,
    "title": title,
    "dateCreated": Timestamp.fromDate(dateCreated),
    "planId": planId,
    "read": read,
  };
}
