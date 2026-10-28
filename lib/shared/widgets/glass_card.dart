import 'package:flutter/material.dart';

/// Tappable card with the Figma "glass" treatment: a faint gradient fill,
/// inset shadows (top highlight, bottom shade) and an optional hairline border.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    this.child,
    this.onTap,
    this.radius = 20,
    this.fill = defaultFill,
    this.insetShadows = defaultInsetShadows,
    this.outline,
  });

  final Widget? child;
  final VoidCallback? onTap;
  final double radius;
  final Gradient fill;
  final List<BoxShadow> insetShadows;

  /// Gradient painted as a 0.5px border, e.g. [hairline].
  final Gradient? outline;

  static const defaultFill = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x08FFFFFF), Color(0x00FFFFFF)],
  );

  static const defaultInsetShadows = [
    BoxShadow(color: Color(0x0AFFFFFF), offset: Offset(0, 5), blurRadius: 20),
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, -20), blurRadius: 20),
  ];

  /// Diagonal light streak used on pill buttons.
  static const hairline = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x03FFFFFF), Color(0x26FFFFFF), Color(0x03FFFFFF)],
  );

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);

    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(gradient: fill, borderRadius: borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: CustomPaint(
            painter: _InsetShadowPainter(
              borderRadius,
              insetShadows,
              outline: outline,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Paints shadows inside the rounded rect, like CSS `box-shadow: inset`, and
/// an optional gradient hairline border.
class _InsetShadowPainter extends CustomPainter {
  const _InsetShadowPainter(this.borderRadius, this.shadows, {this.outline});

  final BorderRadius borderRadius;
  final List<BoxShadow> shadows;
  final Gradient? outline;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = borderRadius.toRRect(Offset.zero & size);
    final bounds = (Offset.zero & size).inflate(size.longestSide);

    canvas.save();
    canvas.clipRRect(rrect);
    for (final shadow in shadows) {
      final outside = Path()
        ..fillType = PathFillType.evenOdd
        ..addRect(bounds)
        ..addRRect(rrect.shift(shadow.offset));
      canvas.drawPath(
        outside,
        Paint()
          ..color = shadow.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurSigma),
      );
    }
    canvas.restore();

    if (outline != null) {
      canvas.drawRRect(
        rrect.deflate(0.25),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5
          ..shader = outline!.createShader(Offset.zero & size),
      );
    }
  }

  @override
  bool shouldRepaint(_InsetShadowPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.shadows != shadows ||
      oldDelegate.outline != outline;
}
