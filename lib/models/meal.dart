import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  final String expertId;
  final String name;
  final String image;
  final String rate;
  final String kcal;
  final String fats;
  final String proteins;
  final String sugar;
  final String categories;

  Meal({
    required this.expertId,
    required this.name,
    required this.image,
    required this.rate,
    required this.kcal,
    required this.fats,
    required this.proteins,
    required this.sugar,
    required this.categories,
  });

  Meal copyWith({
    String? expertId,
    String? name,
    String? image,
    String? rate,
    String? kcal,
    String? fats,
    String? proteins,
    String? sugar,
    String? categories,
  }) =>
      Meal(
        expertId: expertId ?? this.expertId,
        name: name ?? this.name,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        kcal: kcal ?? this.kcal,
        fats: fats ?? this.fats,
        proteins: proteins ?? this.proteins,
        sugar: sugar ?? this.sugar,
        categories: categories ?? this.categories,
      );

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    expertId: json["expert_id"],
    name: json["name"],
    image: json["image"],
    rate: json["rate"],
    kcal: json["kcal"],
    fats: json["fats"],
    proteins: json["proteins"],
    sugar: json["sugar"],
    categories: json["categories"],
  );

  Map<String, dynamic> toJson() => {
    "expert_id": expertId,
    "name": name,
    "image": image,
    "rate": rate,
    "kcal": kcal,
    "fats": fats,
    "proteins": proteins,
    "sugar": sugar,
    "categories": categories,
  };
}

class WorkoutMeal {
  final String expertId;
  final DateTime dateCreated;
  final String id;
  final String foodCategory;
  final String purpose;
  final String foodPlanName;
  final String description;
  final String foodPhoto;
  final String calories;
  final String fats;
  final String sugar;
  final String protein;
  final String expertName;
  final List<String> ingredients;
  final List<String> stepPrep;
  final double rating;
  final bool isFavorite;

  WorkoutMeal({
    required this.expertId,
    required this.dateCreated,
    required this.id,
    required this.foodCategory,
    required this.purpose,
    required this.foodPlanName,
    required this.description,
    required this.foodPhoto,
    required this.calories,
    required this.fats,
    required this.sugar,
    required this.protein,
    required this.expertName,
    required this.ingredients,
    required this.stepPrep,
    required this.rating,
    this.isFavorite = false,
  });

  WorkoutMeal copyWith({
    String? expertId,
    DateTime? dateCreated,
    String? id,
    String? foodCategory,
    String? purpose,
    String? foodPlanName,
    String? description,
    String? foodPhoto,
    String? calories,
    String? fats,
    String? sugar,
    String? protein,
    String? expertName,
    List<String>? ingredients,
    List<String>? stepPrep,
    double? rating,
    bool? isFavorite,
  }) =>
      WorkoutMeal(
        expertId: expertId ?? this.expertId,
        dateCreated: dateCreated ?? this.dateCreated,
        id: id ?? this.id,
        foodCategory: foodCategory ?? this.foodCategory,
        purpose: purpose ?? this.purpose,
        foodPlanName: foodPlanName ?? this.foodPlanName,
        description: description ?? this.description,
        foodPhoto: foodPhoto ?? this.foodPhoto,
        calories: calories ?? this.calories,
        fats: fats ?? this.fats,
        sugar: sugar ?? this.sugar,
        protein: protein ?? this.protein,
        expertName: expertName ?? this.expertName,
        ingredients: ingredients ?? this.ingredients,
        stepPrep: stepPrep ?? this.stepPrep,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory WorkoutMeal.fromJson(Map<String, dynamic> json) => WorkoutMeal(
    expertId: json["expert_id"],
    dateCreated: (json["dateCreated"] as Timestamp).toDate(),
    id: json["id"],
    foodCategory: json["foodCategory"],
    purpose: json["purpose"],
    foodPlanName: json["foodPlanName"],
    description: json["description"],
    foodPhoto: json["foodPhoto"],
    calories: json["calories"],
    fats: json["fats"],
    sugar: json["sugar"],
    protein: json["protein"],
    expertName: json["expertName"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    stepPrep: List<String>.from(json["stepPrep"].map((x) => x)),
    rating: double.parse(json["rating"].toString()),
    isFavorite: json["isFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "expert_id": expertId,
    "dateCreated": Timestamp.fromDate(dateCreated),
    "id": id,
    "foodCategory": foodCategory,
    "purpose": purpose,
    "foodPlanName": foodPlanName,
    "description": description,
    "foodPhoto": foodPhoto,
    "calories": calories,
    "fats": fats,
    "sugar": sugar,
    "protein": protein,
    "expertName": expertName,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "stepPrep": List<dynamic>.from(stepPrep.map((x) => x)),
    "rating": rating,
    "isFavorite": isFavorite,
  };
}


