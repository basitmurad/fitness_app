class UserModel {
  final String username;
  final String id; // or any other fields you have

  UserModel({required this.username, required this.id});

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      username: json['username'],
      id: json['id'], // Adjust as per your data structure
    );
  }
}
