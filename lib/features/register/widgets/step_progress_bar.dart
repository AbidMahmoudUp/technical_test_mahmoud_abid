import 'package:flutter/material.dart';

/// Thin 1px progress line shown in the top bar of later register steps.
class StepProgressBar extends StatelessWidget {
  const StepProgressBar({super.key, required this.progress, this.width = 220});

  final double progress;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: 1,
        child: Stack(
          children: [
            Container(color: Colors.white.withValues(alpha: 0.2)),
            FractionallySizedBox(
              widthFactor: progress.clamp(0, 1),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
