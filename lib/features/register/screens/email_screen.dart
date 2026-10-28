import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../providers/register_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/register_scaffold.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  late final _controller = TextEditingController(
    text: context.read<RegisterProvider>().email,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() => Navigator.pushNamed(context, AppRoutes.registerPassword);

  @override
  Widget build(BuildContext context) {
    final canContinue = context.select<RegisterProvider, bool>(
      (register) => register.canContinueEmail,
    );

    return RegisterScaffold(
      title: 'Let’s get started',
      subtitle: 'We will send you an email to confirm it',
      onContinue: canContinue ? _continue : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _controller,
            label: 'Email',
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            onChanged: context.read<RegisterProvider>().setEmail,
            onSubmitted: (_) => canContinue ? _continue() : null,
          ),
          const SizedBox(height: 19),
          const _LoginLink(),
        ],
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  static const _linkColor = Color(0xFF5278BC);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.tips),
      child: Text(
        'Already have an account? Log in',
        style: AppTextStyles.bodySmall.copyWith(color: _linkColor),
      ),
    );
  }
}
