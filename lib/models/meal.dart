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
