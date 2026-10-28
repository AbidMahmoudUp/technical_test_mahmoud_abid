import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../models/tip.dart';

class TipCard extends StatelessWidget {
  const TipCard({super.key, required this.tip});

  final Tip tip;

  static const width = 219.0;
  static const height = 300.0;

  static const _tint = Color(0xFF574D52);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              left: -48,
              top: -34,
              width: 316,
              height: 566,
              child: Image.asset(tip.image, fit: BoxFit.cover, cacheWidth: 948),
            ),
            Positioned.fill(
              child: ColoredBox(color: _tint.withValues(alpha: 0.35)),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.6114, 0.7794, 0.9395, 1],
                    colors: [
                      Color(0x00574D52),
                      Color(0x00574D52),
                      Color(0xAC574D52),
                      _tint,
                      _tint,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tip.title, style: AppTextStyles.headline),
                  const Spacer(),
                  Text(tip.body, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
