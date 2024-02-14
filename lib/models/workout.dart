class Workout {
  final String name;
  final String image;
  final String rate;
  final String schedule;
  final String categories;
  final String time;
  final String kcal;
  final String exercise;
  final String duration;
  final String days;

  Workout({
    required this.name,
    required this.image,
    required this.rate,
    required this.schedule,
    required this.categories,
    required this.time,
    required this.kcal,
    required this.exercise,
    required this.duration,
    required this.days,
  });

  Workout copyWith({
    String? name,
    String? image,
    String? rate,
    String? schedule,
    String? categories,
    String? time,
    String? kcal,
    String? exercise,
    String? duration,
    String? days,
  }) =>
      Workout(
        name: name ?? this.name,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        schedule: schedule ?? this.schedule,
        categories: categories ?? this.categories,
        time: time ?? this.time,
        kcal: kcal ?? this.kcal,
        exercise: exercise ?? this.exercise,
        duration: duration ?? this.duration,
        days: days ?? this.days,
      );

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    name: json["name"],
    image: json["image"],
    rate: json["rate"],
    schedule: json["schedule"],
    categories: json["categories"],
    time: json["time"],
    kcal: json["kcal"],
    exercise: json["exercise"],
    duration: json["duration"],
    days: json["days"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "rate": rate,
    "schedule": schedule,
    "categories": categories,
    "time": time,
    "kcal": kcal,
    "exercise": exercise,
    "duration": duration,
    "days": days,
  };
}
