import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// 56px bar under the status bar with an optional back arrow on the left,
/// close button on the right and a custom [center] (e.g. a progress bar).
class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key, this.onBack, this.onClose, this.center});

  final VoidCallback? onBack;
  final VoidCallback? onClose;
  final Widget? center;

  static const height = 56.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: onBack == null
                ? null
                : _BarIcon(icon: Icons.arrow_back, onTap: onBack!),
          ),
          Expanded(child: center ?? const SizedBox.shrink()),
          SizedBox(
            width: 56,
            child: onClose == null
                ? null
                : _BarIcon(icon: Icons.close, onTap: onClose!),
          ),
        ],
      ),
    );
  }
}

class _BarIcon extends StatelessWidget {
  const _BarIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 22, color: AppColors.textPrimary.withValues(alpha: 0.7)),
    );
  }
}
