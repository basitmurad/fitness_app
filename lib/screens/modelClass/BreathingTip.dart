class BreathingTip {
  final String title;
  final String description;

  BreathingTip({required this.title, required this.description});

  factory BreathingTip.fromJson(Map<String, dynamic> json) {
    return BreathingTip(
      title: json['title'],
      description: json['description'],
    );
  }
}
