class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String username;
  final String age;
  final String bio;
  final String foodRestriction;

  const UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.age,
    required this.bio,
    required this.foodRestriction,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "age": age,
      "bio": bio,
      "foodRestriction": foodRestriction,
    };
  }
}
