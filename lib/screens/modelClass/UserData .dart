class UserData {
  String? email;
  String? password;
  String? name;
  String? gender;
  int? age;
  double? weight;
  double? targetWeight;

  UserData({
    this.email,
    this.password,
    this.name,
    this.gender,
    this.age,
    this.weight,
    this.targetWeight,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'gender': gender,
      'age': age,
      'weight': weight,
      'targetWeight': targetWeight,
    };
  }
}
