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

class WorkoutPlan {
  final String calories;
  final String category;
  final String daysOfThePlan;
  final String description;
  final String difficulty;
  final String minutes;
  final String planName;
  final String purpose;

  WorkoutPlan({
    required this.calories,
    required this.category,
    required this.daysOfThePlan,
    required this.description,
    required this.difficulty,
    required this.minutes,
    required this.planName,
    required this.purpose,
  });

  WorkoutPlan copyWith({
    String? calories,
    String? category,
    String? daysOfThePlan,
    String? description,
    String? difficulty,
    String? minutes,
    String? planName,
    String? purpose,
  }) =>
      WorkoutPlan(
        calories: calories ?? this.calories,
        category: category ?? this.category,
        daysOfThePlan: daysOfThePlan ?? this.daysOfThePlan,
        description: description ?? this.description,
        difficulty: difficulty ?? this.difficulty,
        minutes: minutes ?? this.minutes,
        planName: planName ?? this.planName,
        purpose: purpose ?? this.purpose,
      );

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => WorkoutPlan(
    calories: json["calories"],
    category: json["category"],
    daysOfThePlan: json["daysOfThePlan"],
    description: json["description"],
    difficulty: json["difficulty"],
    minutes: json["minutes"],
    planName: json["planName"],
    purpose: json["purpose"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "category": category,
    "daysOfThePlan": daysOfThePlan,
    "description": description,
    "difficulty": difficulty,
    "minutes": minutes,
    "planName": planName,
    "purpose": purpose,
  };
}

