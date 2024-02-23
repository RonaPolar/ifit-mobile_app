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
  final String expertId;
  final DateTime dateCreated;
  final String expertName;
  final String purpose;
  final String minutes;
  final double rating;
  final String description;
  final WorkoutPlanExercise exercise;
  final String planName;
  final String calories;
  final String workoutPicture;
  final String daysOfThePlan;
  final String difficulty;
  final List<String> equipments;
  final String id;
  final String category;
  final bool isFavorite;
  final bool isCancelled;
  final int? dayCountFinished;
  final bool? isDeleted;

  WorkoutPlan({
    required this.expertId,
    required this.dateCreated,
    required this.expertName,
    required this.purpose,
    required this.minutes,
    required this.rating,
    required this.description,
    required this.exercise,
    required this.planName,
    required this.calories,
    required this.workoutPicture,
    required this.daysOfThePlan,
    required this.difficulty,
    required this.equipments,
    required this.id,
    required this.category,
    this.isCancelled = false,
    this.isFavorite = false,
    this.dayCountFinished,
    this.isDeleted = false,
  });

  WorkoutPlan copyWith({
    String? expertId,
    DateTime? dateCreated,
    bool? isCancelled,
    String? expertName,
    String? purpose,
    String? minutes,
    double? rating,
    String? description,
    WorkoutPlanExercise? exercise,
    String? planName,
    String? calories,
    String? workoutPicture,
    String? daysOfThePlan,
    String? difficulty,
    List<String>? equipments,
    String? id,
    String? category,
    bool? isFavorite,
    int? dayCountFinished,
    bool? isDeleted,
  }) =>
      WorkoutPlan(
        expertId: expertId ?? this.expertId,
        dateCreated: dateCreated ?? this.dateCreated,
        isCancelled: isCancelled ?? this.isCancelled,
        expertName: expertName ?? this.expertName,
        purpose: purpose ?? this.purpose,
        minutes: minutes ?? this.minutes,
        rating: rating ?? this.rating,
        description: description ?? this.description,
        exercise: exercise ?? this.exercise,
        planName: planName ?? this.planName,
        calories: calories ?? this.calories,
        workoutPicture: workoutPicture ?? this.workoutPicture,
        daysOfThePlan: daysOfThePlan ?? this.daysOfThePlan,
        difficulty: difficulty ?? this.difficulty,
        equipments: equipments ?? this.equipments,
        id: id ?? this.id,
        category: category ?? this.category,
        isFavorite: isFavorite ?? this.isFavorite,
        dayCountFinished: dayCountFinished ?? this.dayCountFinished,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => WorkoutPlan(
    expertId: json["expert_id"],
    dateCreated: (json["dateCreated"] as Timestamp).toDate(),
    isCancelled: json["isCancelled"],
    expertName: json["expertName"],
    purpose: json["purpose"],
    minutes: json["minutes"],
    rating: double.parse(json["rating"].toString()),
    description: json["description"],
    exercise: WorkoutPlanExercise.fromJson(json["exercise"]),
    planName: json["planName"],
    calories: json["calories"],
    workoutPicture: json["workoutPicture"],
    daysOfThePlan: json["daysOfThePlan"],
    difficulty: json["difficulty"],
    equipments: List<String>.from(json["equipments"].map((x) => x)),
    id: json["id"],
    category: json["category"],
    isFavorite: json["isFavorite"],
    dayCountFinished: json["dayCountFinished"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "expert_id": expertId,
    "dateCreated": Timestamp.fromDate(dateCreated),
    "isCancelled": isCancelled,
    "expertName": expertName,
    "purpose": purpose,
    "minutes": minutes,
    "rating": rating,
    "description": description,
    "exercise": exercise.toJson(),
    "planName": planName,
    "calories": calories,
    "workoutPicture": workoutPicture,
    "daysOfThePlan": daysOfThePlan,
    "difficulty": difficulty,
    "equipments": List<dynamic>.from(equipments.map((x) => x)),
    "id": id,
    "category": category,
    "isFavorite": isFavorite,
    "dayCountFinished": dayCountFinished,
    "isDeleted": isDeleted,
  };
}

class WorkoutPlanExercise {
  final List<ExerciseElement> exercises;
  final int sets;

  WorkoutPlanExercise({
    required this.exercises,
    required this.sets,
  });

  WorkoutPlanExercise copyWith({
    List<ExerciseElement>? exercises,
    int? sets,
  }) =>
      WorkoutPlanExercise(
        exercises: exercises ?? this.exercises,
        sets: sets ?? this.sets,
      );

  factory WorkoutPlanExercise.fromJson(Map<String, dynamic> json) => WorkoutPlanExercise(
    exercises: List<ExerciseElement>.from(json["exercises"].map((x) => ExerciseElement.fromJson(x))),
    sets: json["sets"],
  );

  Map<String, dynamic> toJson() => {
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
    "sets": sets,
  };
}

class ExerciseElement {
  final ExerciseDuration exerciseDuration;
  final String description;
  final String title;
  final List<String> steps;
  final String url;

  ExerciseElement({
    required this.exerciseDuration,
    required this.description,
    required this.title,
    required this.steps,
    required this.url,
  });

  ExerciseElement copyWith({
    ExerciseDuration? exerciseDuration,
    String? description,
    String? title,
    List<String>? steps,
    String? url,
  }) =>
      ExerciseElement(
        exerciseDuration: exerciseDuration ?? this.exerciseDuration,
        description: description ?? this.description,
        title: title ?? this.title,
        steps: steps ?? this.steps,
        url: url ?? this.url,
      );

  factory ExerciseElement.fromJson(Map<String, dynamic> json) => ExerciseElement(
    exerciseDuration: ExerciseDuration.fromJson(json["exerciseDuration"]),
    description: json["description"],
    title: json["title"],
    steps: List<String>.from(json["steps"].map((x) => x)),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "exerciseDuration": exerciseDuration.toJson(),
    "description": description,
    "title": title,
    "steps": List<dynamic>.from(steps.map((x) => x)),
    "url": url,
  };
}

class ExerciseDuration {
  final String time;
  final bool type;

  ExerciseDuration({
    required this.time,
    required this.type,
  });

  ExerciseDuration copyWith({
    String? time,
    bool? type,
  }) =>
      ExerciseDuration(
        time: time ?? this.time,
        type: type ?? this.type,
      );

  factory ExerciseDuration.fromJson(Map<String, dynamic> json) => ExerciseDuration(
    time: json["time"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "type": type,
  };
}

