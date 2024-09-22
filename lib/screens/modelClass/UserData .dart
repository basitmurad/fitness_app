class UserData {
  String? email;
  String? name;
  String? gender;
  String? age;
  String? height;
  String? weight;
  String? targetWeight;

  UserData({
    this.email,
    this.name,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.targetWeight,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'targetWeight': targetWeight,
    };
  }
}
