import '../enums/app_enums.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password; // Demo only. Real apps should hash passwords server-side.
  final Gender gender;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
  });

  String get fullName => '$firstName $lastName'.trim();

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender.name,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      gender: GenderExtension.fromName(json['gender'] as String? ?? ''),
    );
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    Gender? gender,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
    );
  }
}

class SubjectModel {
  final String name;
  final String code;
  final String description;
  final String objectives;
  final String schedule;
  final String instructor;
  final String iconEmoji;
  final int colorValue;
  final SubjectCategory category;

  const SubjectModel({
    required this.name,
    required this.code,
    required this.description,
    required this.objectives,
    required this.schedule,
    required this.instructor,
    required this.iconEmoji,
    required this.colorValue,
    required this.category,
  });
}
