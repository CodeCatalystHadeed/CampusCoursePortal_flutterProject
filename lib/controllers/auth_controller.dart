import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enums/app_enums.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  static const String _usersKey = 'registered_users';
  static const String _currentUserKey = 'current_user';
  static const String _rememberMeKey = 'remember_me';

  AuthStatus _status = AuthStatus.idle;
  String _errorMessage = '';
  UserModel? _currentUser;
  bool _rememberMe = false;
  bool _isInitialized = false;

  final Map<String, UserModel> _registeredUsers = {};

  AuthStatus get status => _status;
  String get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;
  bool get rememberMe => _rememberMe;
  bool get isLoggedIn => _currentUser != null;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    await _loadRegisteredUsers(prefs);

    _rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    final storedUser = prefs.getString(_currentUserKey);

    if (_rememberMe && storedUser != null) {
      _currentUser = UserModel.fromJson(jsonDecode(storedUser));
    }

    _isInitialized = true;
    _status = AuthStatus.idle;
    notifyListeners();
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required Gender gender,
  }) async {
    _setLoading();
    await Future.delayed(const Duration(milliseconds: 400));

    final normalizedEmail = email.trim().toLowerCase();

    if (_registeredUsers.containsKey(normalizedEmail)) {
      _setError('An account with this email already exists.');
      return;
    }

    final newUser = UserModel(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      email: normalizedEmail,
      password: password,
      gender: gender,
    );

    _registeredUsers[normalizedEmail] = newUser;
    await _saveRegisteredUsers();

    _status = AuthStatus.success;
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    _setLoading();
    await Future.delayed(const Duration(milliseconds: 400));

    final normalizedEmail = email.trim().toLowerCase();
    final user = _registeredUsers[normalizedEmail];

    if (user == null) {
      _setError('No account found with this email. Please register first.');
      return;
    }

    if (user.password != password) {
      _setError('Incorrect password. Please try again.');
      return;
    }

    _currentUser = user;
    _rememberMe = rememberMe;
    await _saveSession();

    _status = AuthStatus.success;
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _rememberMe = false;
    _status = AuthStatus.idle;
    _errorMessage = '';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, false);
    await prefs.remove(_currentUserKey);

    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void resetStatus() {
    _status = AuthStatus.idle;
    _errorMessage = '';
    notifyListeners();
  }

  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = '';
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> _loadRegisteredUsers(SharedPreferences prefs) async {
    final rawUsers = prefs.getStringList(_usersKey) ?? [];
    _registeredUsers.clear();

    for (final rawUser in rawUsers) {
      final user = UserModel.fromJson(jsonDecode(rawUser));
      _registeredUsers[user.email.toLowerCase()] = user;
    }
  }

  Future<void> _saveRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final rawUsers = _registeredUsers.values
        .map((user) => jsonEncode(user.toJson()))
        .toList();
    await prefs.setStringList(_usersKey, rawUsers);
  }

  Future<void> _saveSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, _rememberMe);

    if (_rememberMe && _currentUser != null) {
      await prefs.setString(_currentUserKey, jsonEncode(_currentUser!.toJson()));
    } else {
      await prefs.remove(_currentUserKey);
    }
  }
}
