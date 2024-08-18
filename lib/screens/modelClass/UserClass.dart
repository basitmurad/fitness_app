class UserClass{
  final String userId;
  final String name;
  final String email;
  final String gender;
  final String? profileImageUrl;



  UserClass({
    required this.userId,
    required this.name,
    required this.email,
    required this.gender,
    this.profileImageUrl,
  });

  // Factory constructor to create a User from a JSON object
  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      userId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  // Method to convert a User object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'email': email,
      'gender': gender,
      'profileImageUrl': profileImageUrl,
    };
  }

  // Override the toString method to make it easier to print the User object
  @override
  String toString() {
    return 'User{id: $userId, name: $name, email: $email, gender: $gender, profileImageUrl: $profileImageUrl}';
  }







}