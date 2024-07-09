import 'dart:convert';

UserModal userModalFromJson(String str) => UserModal.fromJson(json.decode(str));

String userModalToJson(UserModal data) => json.encode(data.toJson());

class UserModal {
  String userId;
  String name;
  String email;
  String age;
  String gender;

  UserModal({
   required this.userId,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    age: json["age"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "userId":userId,
    "name": name,
    "email": email,
    "age": age,
    "gender": gender,
  };
}
