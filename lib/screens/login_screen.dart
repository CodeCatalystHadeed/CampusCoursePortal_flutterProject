import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../controllers/form_controller.dart';
import '../controllers/navigation_controller.dart';
import '../enums/app_enums.dart';
import '../theme/app_theme.dart';
import '../validators/app_validator.dart';
import '../widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  final AuthController authController;

  const LoginScreen({super.key, required this.authController});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.authController.resetStatus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateFormValidity() {
    final isValid = FormController.isLoginFormValid(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (_isFormValid != isValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      _updateFormValidity();
      return;
    }

    await widget.authController.login(
      email: _emailController.text,
      password: _passwordController.text,
      rememberMe: widget.authController.rememberMe,
    );

    if (!mounted) return;

    if (widget.authController.status == AuthStatus.success) {
      NavigationController.goToDashboard(context, widget.authController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.authController.status == AuthStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(
                  title: 'Welcome back',
                  subtitle: 'Access your subjects, schedule, and course details from one calm student portal.',
                  icon: Icons.eco_rounded,
                ),
                const SizedBox(height: 26),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        label: 'Email Address',
                        hint: 'student@example.com',
                        controller: _emailController,
                        validator: AppValidator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail_outline_rounded,
                        onChanged: (_) => _updateFormValidity(),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        controller: _passwordController,
                        validator: AppValidator.validateLoginPassword,
                        obscureText: !_showPassword,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.lock_outline_rounded,
                        onChanged: (_) => _updateFormValidity(),
                        suffixIcon: IconButton(
                          tooltip: _showPassword ? 'Hide password' : 'Show password',
                          icon: Icon(_showPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: widget.authController.rememberMe,
                            activeColor: AppColors.primary,
                            onChanged: isLoading ? null : widget.authController.toggleRememberMe,
                          ),
                          const Text('Remember Me', style: TextStyle(color: AppColors.ink)),
                        ],
                      ),
                      if (widget.authController.status == AuthStatus.error) ...[
                        const SizedBox(height: 8),
                        _ErrorBox(message: widget.authController.errorMessage),
                      ],
                      const SizedBox(height: 18),
                      CustomButton(
                        text: 'Login',
                        icon: Icons.login_rounded,
                        isLoading: isLoading,
                        onPressed: _isFormValid ? _handleLogin : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            widget.authController.resetStatus();
                            NavigationController.goToRegister(context, widget.authController);
                          },
                    child: const Text('Create a new account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;

  const _ErrorBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE7E2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(message, style: const TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600)),
    );
  }
}
