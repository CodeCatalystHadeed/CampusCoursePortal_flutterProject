enum Gender { male, female, preferNotToSay }

extension GenderExtension on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }

  static Gender fromName(String value) {
    return Gender.values.firstWhere(
      (gender) => gender.name == value,
      orElse: () => Gender.preferNotToSay,
    );
  }
}

enum AuthStatus { idle, loading, success, error }

enum SubjectCategory { technical, business }
