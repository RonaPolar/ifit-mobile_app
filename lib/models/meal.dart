class Meal {
  final String name;
  final String image;
  final String rate;
  final String kcal;
  final String fats;
  final String proteins;
  final String sugar;
  final String categories;

  Meal({
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
  final String calories;
  final String category;
  final String description;
  final String fats;
  final String planName;
  final String purpose;
  final String sugar;
  final String protein;

  WorkoutMeal({
    required this.calories,
    required this.category,
    required this.description,
    required this.fats,
    required this.planName,
    required this.purpose,
    required this.sugar,
    required this.protein,
  });

  WorkoutMeal copyWith({
    String? calories,
    String? category,
    String? description,
    String? fats,
    String? planName,
    String? purpose,
    String? sugar,
    String? protein,
  }) =>
      WorkoutMeal(
        calories: calories ?? this.calories,
        category: category ?? this.category,
        description: description ?? this.description,
        fats: fats ?? this.fats,
        planName: planName ?? this.planName,
        purpose: purpose ?? this.purpose,
        sugar: sugar ?? this.sugar,
        protein: protein ?? this.protein,
      );

  factory WorkoutMeal.fromJson(Map<String, dynamic> json) => WorkoutMeal(
    calories: json["calories"],
    category: json["category"],
    description: json["description"],
    fats: json["fats"],
    planName: json["planName"],
    purpose: json["purpose"],
    sugar: json["sugar"],
    protein: json["protein"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "category": category,
    "description": description,
    "fats": fats,
    "planName": planName,
    "purpose": purpose,
    "sugar": sugar,
    "protein": protein,
  };
}

