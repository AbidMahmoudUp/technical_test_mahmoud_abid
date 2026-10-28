import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../providers/register_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/register_scaffold.dart';

class BirthDateScreen extends StatefulWidget {
  const BirthDateScreen({super.key});

  @override
  State<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  late final RegisterProvider _register = context.read<RegisterProvider>();
  late final _day = TextEditingController(text: _register.day);
  late final _month = TextEditingController(text: _register.month);
  late final _year = TextEditingController(text: _register.year);
  final _monthFocus = FocusNode();
  final _yearFocus = FocusNode();

  @override
  void dispose() {
    for (final controller in [_day, _month, _year]) {
      controller.dispose();
    }
    _monthFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  void _continue() => Navigator.pushNamed(context, AppRoutes.registerHeight);

  @override
  Widget build(BuildContext context) {
    final canContinue = context.select<RegisterProvider, bool>(
      (register) => register.canContinueBirthDate,
    );

    return RegisterScaffold(
      title: 'What is your date of birth?',
      onContinue: canContinue ? _continue : null,
      child: Row(
        children: [
          Expanded(
            child: _DatePartField(
              controller: _day,
              maxLength: 2,
              autofocus: true,
              onChanged: _register.setDay,
              nextFocus: _monthFocus,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _DatePartField(
              controller: _month,
              focusNode: _monthFocus,
              maxLength: 2,
              onChanged: _register.setMonth,
              nextFocus: _yearFocus,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _DatePartField(
              controller: _year,
              focusNode: _yearFocus,
              maxLength: 4,
              onChanged: _register.setYear,
            ),
          ),
        ],
      ),
    );
  }
}

class _DatePartField extends StatelessWidget {
  const _DatePartField({
    required this.controller,
    required this.maxLength,
    required this.onChanged,
    this.focusNode,
    this.nextFocus,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      onChanged: (value) {
        onChanged(value);
        if (value.length == maxLength) nextFocus?.requestFocus();
      },
    );
  }
}
