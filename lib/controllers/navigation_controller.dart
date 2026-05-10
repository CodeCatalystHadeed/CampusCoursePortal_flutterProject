import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../screens/dashboard_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import 'auth_controller.dart';

class NavigationController {
  static void goToRegister(BuildContext context, AuthController authController) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterScreen(authController: authController),
      ),
    );
  }

  static void goToLogin(BuildContext context, AuthController authController) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen(authController: authController)),
      (_) => false,
    );
  }

  static void goToDashboard(BuildContext context, AuthController authController) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen(authController: authController)),
    );
  }

  static void goToDetail(BuildContext context, SubjectModel subject) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(subject: subject)),
    );
  }
}
