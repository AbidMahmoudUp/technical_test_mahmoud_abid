import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../providers/register_provider.dart';
import '../widgets/height_wheel_picker.dart';
import '../widgets/register_scaffold.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/unit_toggle.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterProvider>();

    return RegisterScaffold(
      title: 'What is your height?',
      subtitle: 'This helps us provide accurate, meaningful insights',
      topBarCenter: const StepProgressBar(progress: 0.6),
      onContinue: register.canContinueHeight
          ? () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.ringStart,
              ModalRoute.withName(AppRoutes.welcome),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitToggle<HeightUnit>(
            options: const {HeightUnit.ftIn: 'Ft/in', HeightUnit.cm: 'Cm'},
            selected: register.heightUnit,
            onChanged: register.setHeightUnit,
          ),
          const SizedBox(height: 49),
          HeightWheelPicker(
            key: ValueKey(register.heightUnit),
            columns: switch (register.heightUnit) {
              HeightUnit.ftIn => [
                WheelColumnData(
                  min: RegisterProvider.feetRange.min,
                  max: RegisterProvider.feetRange.max,
                  selected: register.feet,
                  unit: 'ft',
                  onChanged: register.setFeet,
                ),
                WheelColumnData(
                  min: RegisterProvider.inchesRange.min,
                  max: RegisterProvider.inchesRange.max,
                  selected: register.inches,
                  unit: 'in',
                  onChanged: register.setInches,
                ),
              ],
              HeightUnit.cm => [
                WheelColumnData(
                  min: RegisterProvider.cmRange.min,
                  max: RegisterProvider.cmRange.max,
                  selected: register.centimeters,
                  unit: 'cm',
                  onChanged: register.setCentimeters,
                ),
              ],
            },
          ),
        ],
      ),
    );
  }
}
