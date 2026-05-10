import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../controllers/form_controller.dart';
import '../enums/app_enums.dart';
import '../theme/app_theme.dart';
import '../validators/app_validator.dart';
import '../widgets/app_widgets.dart';

class RegisterScreen extends StatefulWidget {
  final AuthController authController;

  const RegisterScreen({super.key, required this.authController});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Gender? _selectedGender;

  bool _showPassword = false;
  bool _showConfirmPassword = false;
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateFormValidity() {
    final isValid = FormController.isRegistrationFormValid(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      gender: _selectedGender,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    setState(() {
      _isFormValid = isValid;
    });
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      _updateFormValidity();
      return;
    }

    await widget.authController.register(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      gender: _selectedGender!,
    );

    if (!mounted) return;

    if (widget.authController.status == AuthStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful. Please log in.'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.authController.status == AuthStatus.loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(
                  title: 'Join the portal',
                  subtitle:
                      'Create your student account with secure password rules and simple validation feedback.',
                  icon: Icons.person_add_alt_1_rounded,
                ),
                const SizedBox(height: 24),
                AppCard(
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'First Name',
                        hint: 'Enter your first name',
                        controller: _firstNameController,
                        validator: (value) =>
                            AppValidator.validateName(value, 'First name'),
                        prefixIcon: Icons.person_outline_rounded,
                        onChanged: (_) => _updateFormValidity(),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Last Name',
                        hint: 'Enter your last name',
                        controller: _lastNameController,
                        validator: (value) =>
                            AppValidator.validateName(value, 'Last name'),
                        prefixIcon: Icons.person_outline_rounded,
                        onChanged: (_) => _updateFormValidity(),
                      ),
                      const SizedBox(height: 16),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Gender>(
                        initialValue: _selectedGender,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            AppValidator.validateDropdown(value, 'gender'),
                        decoration: const InputDecoration(
                          hintText: 'Select gender',
                          prefixIcon: Icon(
                            Icons.wc_rounded,
                            color: AppColors.muted,
                          ),
                        ),
                        items: Gender.values
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender.label),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                          _updateFormValidity();
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        hint: 'At least 6 chars, uppercase, special char',
                        controller: _passwordController,
                        validator: AppValidator.validatePassword,
                        obscureText: !_showPassword,
                        prefixIcon: Icons.lock_outline_rounded,
                        onChanged: (_) => _updateFormValidity(),
                        suffixIcon: IconButton(
                          tooltip:
                              _showPassword ? 'Hide password' : 'Show password',
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      _PasswordRules(
                        password: _passwordController.text,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Confirm Password',
                        hint: 'Re-enter password',
                        controller: _confirmPasswordController,
                        validator: AppValidator.validateConfirmPassword(
                          _passwordController.text,
                        ),
                        obscureText: !_showConfirmPassword,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.verified_user_outlined,
                        onChanged: (_) => _updateFormValidity(),
                        suffixIcon: IconButton(
                          tooltip: _showConfirmPassword
                              ? 'Hide password'
                              : 'Show password',
                          icon: Icon(
                            _showConfirmPassword
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              _showConfirmPassword = !_showConfirmPassword;
                            });
                          },
                        ),
                      ),
                      if (widget.authController.status == AuthStatus.error) ...[
                        const SizedBox(height: 14),
                        _ErrorBox(
                          message: widget.authController.errorMessage,
                        ),
                      ],
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Register',
                        icon: Icons.check_circle_outline_rounded,
                        isLoading: isLoading,
                        onPressed: _isFormValid ? _handleRegister : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: isLoading ? null : () => Navigator.pop(context),
                    child: const Text('Already have an account? Login'),
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

class _PasswordRules extends StatelessWidget {
  final String password;

  const _PasswordRules({
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RuleRow(
          text: 'Minimum 6 characters',
          passed: password.length >= 6,
        ),
        _RuleRow(
          text: 'At least 1 uppercase letter',
          passed: RegExp(r'[A-Z]').hasMatch(password),
        ),
        _RuleRow(
          text: 'At least 1 special character',
          passed: RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password),
        ),
      ],
    );
  }
}

class _RuleRow extends StatelessWidget {
  final String text;
  final bool passed;

  const _RuleRow({
    required this.text,
    required this.passed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(
            passed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 16,
            color: passed ? AppColors.success : AppColors.muted,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: passed ? AppColors.success : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;

  const _ErrorBox({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE7E2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: AppColors.danger,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
