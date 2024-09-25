class JumpingJack {
  final String title;
  final String instruction;
  final List<Map<String, String>> breathingTips;
  final List<Map<String, String>> commonMistakes;
  final List<String> focusAreas;
  final String animationPath;
  final String imagePathDarkTheme;
  final String imagePathLightTheme;
  final String musclePath;
  final String videoURL;

  JumpingJack({
    required this.title,
    required this.instruction,
    required this.breathingTips,
    required this.commonMistakes,
    required this.focusAreas,
    required this.animationPath,
    required this.imagePathDarkTheme,
    required this.imagePathLightTheme,
    required this.musclePath,
    required this.videoURL,
  });

  factory JumpingJack.fromJson(Map<String, dynamic> json) {
    return JumpingJack(
      title: json['title'] ?? '',
      instruction: json['instruction'] ?? '',
      breathingTips: List<Map<String, String>>.from(
        (json['breathingTips'] ?? []).map((tip) => {
          'title': tip['title'] ?? '',
          'description': tip['description'] ?? '',
        }),
      ),
      commonMistakes: List<Map<String, String>>.from(
        (json['commonMistakes'] ?? []).map((mistake) => {
          'title': mistake['title'] ?? '',
          'description': mistake['description'] ?? '',
        }),
      ),
      focusAreas: List<String>.from(json['focusAreas'] ?? []),
      animationPath: json['multimedia']['female']['animationPath'] ?? '',
      imagePathDarkTheme: json['multimedia']['female']['imagePath']['darkTheme'] ?? '',
      imagePathLightTheme: json['multimedia']['female']['imagePath']['lightTheme'] ?? '',
      musclePath: json['multimedia']['female']['musclePath'] ?? '',
      videoURL: json['multimedia']['female']['videoURL'] ?? '',
    );
  }
}
