import 'package:flutter/material.dart';

/// Row of thin segments; the first [filled] ones are lit with a soft glow.
class SegmentedProgress extends StatelessWidget {
  const SegmentedProgress({
    super.key,
    required this.total,
    required this.filled,
  });

  final int total;
  final int filled;

  static const _gap = 5.0;
  static const _litColor = Colors.white;
  static const _idleColor = Color(0x33FFFFFF);
  static const _glow = BoxShadow(
    color: Color(0x70FFFFFF),
    blurRadius: 8,
    spreadRadius: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: _gap),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 1,
              decoration: BoxDecoration(
                color: i < filled ? _litColor : _idleColor,
                boxShadow: i < filled ? const [_glow] : null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
