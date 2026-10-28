import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../providers/register_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/password_rules.dart';
import '../widgets/register_scaffold.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late final RegisterProvider _register = context.read<RegisterProvider>();
  late final _passwordController = TextEditingController(
    text: _register.password,
  );
  late final _confirmationController = TextEditingController(
    text: _register.confirmation,
  );

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _continue() => Navigator.pushNamed(context, AppRoutes.registerBirthDate);

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterProvider>();

    return RegisterScaffold(
      title: 'Set up a password',
      subtitle: 'Must be at least 8 characters',
      onContinue: register.canContinuePassword ? _continue : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            autofocus: true,
            obscureText: register.obscurePassword,
            onToggleObscure: register.togglePasswordVisibility,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
            onChanged: register.setPassword,
          ),
          if (register.password.isNotEmpty) ...[
            const SizedBox(height: 7),
            const PasswordRules(),
            const SizedBox(height: 21),
          ] else
            const SizedBox(height: 12),
          AppTextField(
            controller: _confirmationController,
            label: 'Confirm password',
            obscureText: register.obscureConfirmation,
            onToggleObscure: register.toggleConfirmationVisibility,
            textInputAction: TextInputAction.done,
            onChanged: register.setConfirmation,
            onSubmitted: (_) =>
                register.canContinuePassword ? _continue() : null,
          ),
        ],
      ),
    );
  }
}
