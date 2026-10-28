import 'package:flutter/material.dart';

import '../../../shared/widgets/glass_card.dart';

/// 180×180 glass tile used for the app icons and lifestyle photos.
/// An optional [image] sits under the glass layers.
class ShowcaseTile extends StatelessWidget {
  const ShowcaseTile({super.key, this.image, this.child});

  final ImageProvider? image;
  final Widget? child;

  static const size = 180.0;
  static const radius = 40.0;

  static const _fill = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x204A4A4A), Color(0x1A121212)],
  );

  static const _insetShadows = [
    BoxShadow(
      color: Color(0x0AFFFFFF),
      offset: Offset(0, 5.69),
      blurRadius: 22.74,
    ),
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, -22.74),
      blurRadius: 22.74,
    ),
  ];

  static const _outline = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x00FFFFFF), Color(0x4DFFFFFF), Color(0x00FFFFFF)],
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image(image: image!, fit: BoxFit.cover),
          ),
        GlassCard(
          radius: radius,
          fill: _fill,
          insetShadows: _insetShadows,
          outline: _outline,
          child: child == null ? null : Center(child: child),
        ),
      ],
    );
  }
}
