class Schedule {
  final String title;
  final String subtitle;

  Schedule({
    required this.title,
    required this.subtitle,
  });

  factory Schedule.fromJson(json) {
    return Schedule(
      title: json["title"],
      subtitle: json["subtitle"],
    );
  }
}

