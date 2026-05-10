class AppValidator {
  static String? validateEmptyField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateName(String? value, String fieldName) {
    final emptyError = validateEmptyField(value, fieldName);
    if (emptyError != null) return emptyError;

    if (value!.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emptyError = validateEmptyField(value, 'Email');
    if (emptyError != null) return emptyError;

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    if (!emailRegex.hasMatch(value!.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final emptyError = validateEmptyField(value, 'Password');
    if (emptyError != null) return emptyError;

    if (value!.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least 1 special character';
    }
    return null;
  }

  static String? Function(String?) validateConfirmPassword(
    String originalPassword,
  ) {
    return (String? value) {
      final emptyError = validateEmptyField(value, 'Confirm password');
      if (emptyError != null) return emptyError;

      if (value != originalPassword) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  static String? validateLoginPassword(String? value) {
    return validateEmptyField(value, 'Password');
  }

  static String? validateDropdown<T>(T? value, String fieldName) {
    if (value == null) {
      return 'Please select $fieldName';
    }
    return null;
  }
}
