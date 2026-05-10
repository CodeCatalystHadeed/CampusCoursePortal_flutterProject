# Campus Course Portal

A Flutter Multi-Screen Authentication Application

## Student Information

- Name: Muhammad Hadeed
- Class: BSSE-8B
- Student ID: SE221003

## Project Title
Flutter Multi-Screen Authentication Application

## Project Overview
Campus Course Portal is a simple, clean Flutter application built for the multi-screen application development assignment. It includes registration, login, form validation, Remember Me persistence, dashboard navigation, and subject detail screens.

## Features Implemented
- Registration screen with First Name, Last Name, Email, Gender, Password, and Confirm Password fields.
- Reusable validation class for empty fields, email, password, dropdown, and confirm password checks.
- Password rules: minimum 6 characters, at least 1 uppercase letter, and at least 1 special character.
- Real-time validation feedback on interacted fields.
- Register button remains disabled until the registration form is valid.
- Login screen with email validation and show/hide password icon.
- Remember Me checkbox with session persistence using `shared_preferences`.
- Dashboard screen displays user name, email, and avatar placeholder.
- Dynamic subject list:
  - Mobile App Development
  - Software Re-engineering
  - Management Information Systems (MIS)
- Detail screen displays subject header, banner placeholder, description, objectives, and schedule details.
- Enums used for gender, authentication state, and subject category.
- Controller/service layer used for authentication, form validation checks, subject data, and navigation.

## Folder Structure
```text
lib/
  controllers/
    auth_controller.dart
    form_controller.dart
    navigation_controller.dart
    subject_data.dart
  enums/
    app_enums.dart
  models/
    user_model.dart
  screens/
    login_screen.dart
    register_screen.dart
    dashboard_screen.dart
    detail_screen.dart
  theme/
    app_theme.dart
  validators/
    app_validator.dart
  widgets/
    app_widgets.dart
```

## Screenshots

The following screenshots show the main screens of the Campus Course Portal application.

### Authentication Screens

<table>
  <tr>
    <td align="center"><b>Login Screen</b></td>
    <td align="center"><b>Registration Screen</b></td>
  </tr>
  <tr>
    <td align="center">
      <img src="screenshots/02_login_screen.png" width="300" alt="Login Screen">
    </td>
    <td align="center">
      <img src="screenshots/01_register_screen_updated.png" width="300" alt="Registration Screen">
    </td>
  </tr>
</table>

### Application Screens

<table>
  <tr>
    <td align="center"><b>Dashboard Screen</b></td>
    <td align="center"><b>Course Detail Screen</b></td>
  </tr>
  <tr>
    <td align="center">
      <img src="screenshots/03_dashboard_screen.png" width="300" alt="Dashboard Screen">
    </td>
    <td align="center">
      <img src="screenshots/04_detail_screen.png" width="300" alt="Course Detail Screen">
    </td>
  </tr>
</table>

## How to Run
```bash
flutter pub get
flutter run
```

## Testing Checklist
1. Register a new user with valid data.
2. Try invalid email and weak passwords to confirm validation messages.
3. Confirm the Register button remains disabled until all fields are valid.
4. Log in using registered credentials.
5. Toggle password visibility on the Login screen.
6. Check Remember Me and restart the app to verify session persistence.
7. Open Dashboard and tap each subject.
8. Confirm Detail screen receives and displays the selected subject.
9. Logout and confirm the app returns to Login screen.
