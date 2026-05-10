# Campus Course Portal

## Student Information

**Name:** Muhammad Hadeed  
**Class:** BSSE-8B  

## Project Overview

Campus Course Portal is a multi-screen Flutter application developed for the Flutter Multi-Screen Application Development assignment. The app includes user registration, login authentication, form validation, session persistence, dashboard navigation, and subject detail screens.

## Features

- User registration with first name, last name, email, gender, password, and confirm password
- Email validation
- Secure password validation:
  - Minimum 6 characters
  - At least 1 uppercase letter
  - At least 1 special character
- Confirm password matching
- Real-time validation feedback
- Disabled register button until the form is valid
- Login screen with email and password validation
- Show/hide password toggle using eye icon
- Remember Me checkbox with basic session persistence
- Dashboard screen showing user name and avatar placeholder
- Dynamic subject list
- Detail screen for selected subject
- Logout functionality
- Reusable validator class
- Enum implementation for gender, authentication state, and subject category
- Controller/service layer for authentication, form handling, subject data, and navigation logic

## Screenshots

### Registration Screen

![Registration Screen](screenshots/01_register_screen_updated.png)

### Login Screen

![Login Screen](screenshots/02_login_screen.png)

### Dashboard Screen

![Dashboard Screen](screenshots/03_dashboard_screen.png)

### Detail Screen

![Detail Screen](screenshots/04_detail_screen.png)

## Application Screens

### 1. Registration Screen

The Registration Screen allows a student to create an account by entering first name, last name, email address, gender, password, and confirm password. The form validates all fields and only enables the Register button when all inputs are valid.

### 2. Login Screen

The Login Screen validates the user's email and password. It also includes a show/hide password icon and a Remember Me checkbox for basic session persistence.

### 3. Dashboard Screen

The Dashboard Screen displays the logged-in user's name, an avatar placeholder, and a list of subjects. Tapping a subject opens its detail screen.

### 4. Detail Screen

The Detail Screen displays the selected subject name, banner placeholder, course description, objectives, and class schedule details.

## Subjects Included

- Mobile App Development
- Software Re-engineering
- Management Information Systems (MIS)

## Project Structure

```text
lib/
├── controllers/
│   ├── auth_controller.dart
│   ├── form_controller.dart
│   ├── navigation_controller.dart
│   └── subject_data.dart
├── enums/
│   └── app_enums.dart
├── models/
│   ├── subject_model.dart
│   └── user_model.dart
├── screens/
│   ├── dashboard_screen.dart
│   ├── detail_screen.dart
│   ├── login_screen.dart
│   └── register_screen.dart
├── theme/
│   └── app_theme.dart
├── validators/
│   └── app_validator.dart
├── widgets/
│   └── app_widgets.dart
└── main.dart
```

## How to Run the Project

1. Clone the repository:

```bash
git clone https://github.com/CodeCatalystHadeed/my_flutter_app.git
```

2. Open the project folder:

```bash
cd my_flutter_app
```

3. Get Flutter dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

For web testing, run:

```bash
flutter run -d chrome
```

## Technologies Used

- Flutter
- Dart
- shared_preferences

## Assignment Requirements Covered

| Requirement | Status |
|---|---|
| Project title | Included |
| Student name and class | Included |
| Screenshots of the application | Included |
| Registration Screen | Completed |
| Login Screen | Completed |
| Dashboard Screen | Completed |
| Detail Screen | Completed |
| Form Validation | Completed |
| Custom Validator Class | Completed |
| Enum Implementation | Completed |
| Controller Layer Architecture | Completed |
| Navigation and Data Passing | Completed |
| Session Persistence | Completed |

## Note

Screenshots are stored inside the `screenshots/` folder and displayed in this README using relative GitHub paths.
