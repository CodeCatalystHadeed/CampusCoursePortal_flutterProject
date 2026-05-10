import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _authController.initialize();
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _authController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Campus Course Portal',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          home: _buildHome(),
        );
      },
    );
  }

  Widget _buildHome() {
    if (!_authController.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_authController.isLoggedIn) {
      return DashboardScreen(authController: _authController);
    }

    return LoginScreen(authController: _authController);
  }
}
