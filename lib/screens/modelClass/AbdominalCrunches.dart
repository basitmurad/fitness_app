class AbdominalCrunches {
  final String title;
  final String description;
  final List<String> commonMistakes;
  final List<String> focusAreas;
  final String instruction;
  final Multimedia multimedia;

  AbdominalCrunches({
    required this.title,
    required this.description,
    required this.commonMistakes,
    required this.focusAreas,
    required this.instruction,
    required this.multimedia,
  });

  factory AbdominalCrunches.fromJson(Map<String, dynamic> json) {
    return AbdominalCrunches(
      title: json['title'] as String,
      description: json['description'] as String,
      commonMistakes: List<String>.from(json['commonMistakes']
          .map((mistake) => mistake['description'] as String)
          .toList()),
      focusAreas: List<String>.from(json['focusAreas']),
      instruction: json['instruction'] as String,
      multimedia: Multimedia.fromJson(json['multimedia']),
    );
  }
}

class Multimedia {
  final String femaleAnimationPath;
  final String femaleImagePath;
  final String femaleMusclePath;
  final String femaleVideoURL;
  final String maleAnimationPath;
  final String maleImagePath;

  Multimedia({
    required this.femaleAnimationPath,
    required this.femaleImagePath,
    required this.femaleMusclePath,
    required this.femaleVideoURL,
    required this.maleAnimationPath,
    required this.maleImagePath,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) {
    return Multimedia(
      femaleAnimationPath: json['female']['animationPath'] as String,
      femaleImagePath: json['female']['imagePath'] as String,
      femaleMusclePath: json['female']['musclePath'] as String,
      femaleVideoURL: json['female']['videoURL'] as String,
      maleAnimationPath: json['male']['animationPath'] as String,
      maleImagePath: json['male']['imagePath'] as String,
    );
  }
}
