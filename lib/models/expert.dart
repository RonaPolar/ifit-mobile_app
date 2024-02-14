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
