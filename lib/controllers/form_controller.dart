import '../enums/app_enums.dart';
import '../validators/app_validator.dart';

class FormController {
  static bool isRegistrationFormValid({
    required String firstName,
    required String lastName,
    required String email,
    required Gender? gender,
    required String password,
    required String confirmPassword,
  }) {
    return AppValidator.validateName(firstName, 'First name') == null &&
        AppValidator.validateName(lastName, 'Last name') == null &&
        AppValidator.validateEmail(email) == null &&
        AppValidator.validateDropdown(gender, 'gender') == null &&
        AppValidator.validatePassword(password) == null &&
        AppValidator.validateConfirmPassword(password)(confirmPassword) == null;
  }

  static bool isLoginFormValid({
    required String email,
    required String password,
  }) {
    return AppValidator.validateEmail(email) == null &&
        AppValidator.validateLoginPassword(password) == null;
  }
}
