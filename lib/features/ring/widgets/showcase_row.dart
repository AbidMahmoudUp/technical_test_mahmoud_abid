import 'package:flutter/material.dart';

/// A large centred tile flanked by two smaller tiles that bleed off-screen.
class ShowcaseRow extends StatelessWidget {
  const ShowcaseRow({
    super.key,
    required this.leading,
    required this.center,
    required this.trailing,
  });

  final Widget leading;
  final Widget center;
  final Widget trailing;

  static const centerSize = 180.0;
  static const sideSize = 148.0;
  static const _gap = 44.0;

  /// Distance between the centres of the middle tile and a side tile.
  static const pageExtent = centerSize / 2 + _gap + sideSize / 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: centerSize,
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(dimension: sideSize, child: leading),
            const SizedBox(width: _gap),
            SizedBox.square(dimension: centerSize, child: center),
            const SizedBox(width: _gap),
            SizedBox.square(dimension: sideSize, child: trailing),
          ],
        ),
      ),
    );
  }
}
