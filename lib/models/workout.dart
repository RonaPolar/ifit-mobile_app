import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String category;
  final String purpose;
  final String difficulty;
  final String planName;
  final String description;
  final String workoutPicture;

  final double rating;
  final DateTime daysOfThePlan;
  final String calories;
  final String minutes;
  final List<String> equipments;
  final Exercise exercise;

  WorkoutPlan({
    required this.category,
    required this.description,
    required this.rating,
    required this.daysOfThePlan,
    required this.workoutPicture,
    required this.planName,
    required this.difficulty,
    required this.calories,
    required this.minutes,
    required this.purpose,
    required this.equipments,
    required this.exercise,
  });

  WorkoutPlan copyWith({
    String? category,
    String? description,
    double? rating,
    DateTime? daysOfThePlan,
    String? planName,
    String? difficulty,
    String? workoutPicture,
    String? calories,
    String? minutes,
    String? purpose,
    String? name,
    List<String>? equipments,
    Exercise? exercise,
  }) =>
      WorkoutPlan(
        category: category ?? this.category,
        description: description ?? this.description,
        rating: rating ?? this.rating,
        planName: planName ?? this.planName,
        workoutPicture: workoutPicture ?? this.workoutPicture,
        daysOfThePlan: daysOfThePlan ?? this.daysOfThePlan,
        difficulty: difficulty ?? this.difficulty,
        calories: calories ?? this.calories,
        minutes: minutes ?? this.minutes,
        purpose: purpose ?? this.purpose,
        equipments: equipments ?? this.equipments,
        exercise: exercise ?? this.exercise,
      );

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => WorkoutPlan(
    category: json["category"],
    description: json["description"],
    rating: json["rating"]?.toDouble(),
    planName: json["planName"],
    daysOfThePlan: (json["daysOfThePlan"] as Timestamp).toDate(),
    workoutPicture: json["workoutPicture"],
    difficulty: json["difficulty"],
    calories: json["calories"],
    minutes: json["minutes"],
    purpose: json["purpose"],
    equipments: List<String>.from(json["equipments"].map((x) => x)),
    exercise: Exercise.fromJson(json["exercise"]),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "description": description,
    "rating": rating,
    "planName": planName,
    "daysOfThePlan": Timestamp.fromDate(daysOfThePlan),
    "workoutPicture": workoutPicture,
    "difficulty": difficulty,
    "calories": calories,
    "minutes": minutes,
    "purpose": purpose,
    "equipments": List<dynamic>.from(equipments.map((x) => x)),
    "exercise": exercise.toJson(),
  };
}

class Exercise {
  final int sets;
  final List<ExerciseElement> exercises;

  Exercise({
    required this.sets,
    required this.exercises,
  });

  Exercise copyWith({
    int? sets,
    List<ExerciseElement>? exercises,
  }) =>
      Exercise(
        sets: sets ?? this.sets,
        exercises: exercises ?? this.exercises,
      );

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    sets: json["sets"],
    exercises: List<ExerciseElement>.from(json["exercises"].map((x) => ExerciseElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sets": sets,
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
  };
}

class ExerciseElement {
  final String url;
  final String title;
  final String description;
  final List<String> steps;

  ExerciseElement({
    required this.url,
    required this.title,
    required this.description,
    required this.steps,
  });

  ExerciseElement copyWith({
    String? url,
    String? title,
    String? description,
    List<String>? steps,
  }) =>
      ExerciseElement(
        url: url ?? this.url,
        title: title ?? this.title,
        description: description ?? this.description,
        steps: steps ?? this.steps,
      );

  factory ExerciseElement.fromJson(Map<String, dynamic> json) => ExerciseElement(
    url: json["url"],
    title: json["title"],
    description: json["description"],
    steps: List<String>.from(json["steps"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "title": title,
    "description": description,
    "steps": List<dynamic>.from(steps.map((x) => x)),
  };
}



