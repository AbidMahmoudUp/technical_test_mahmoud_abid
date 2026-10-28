import 'package:flutter/material.dart';

/// Fixed-size product render, decoded at a resolution suited to its box.
class RingIllustration extends StatelessWidget {
  const RingIllustration({
    super.key,
    required this.asset,
    required this.width,
    required this.height,
    this.padding = EdgeInsets.zero,
  });

  final String asset;
  final double width;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return Padding(
      padding: padding,
      child: Image.asset(
        asset,
        width: width,
        height: height,
        fit: BoxFit.contain,
        cacheWidth: (width * dpr).round(),
      ),
    );
  }
}
