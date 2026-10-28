import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/scale_carousel.dart';
import '../providers/tips_provider.dart';
import 'tip_card.dart';

/// Swipeable tips: the centred card is 219×300 and its neighbours shrink to
/// 190×260.
class TipsCarousel extends StatelessWidget {
  const TipsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final tipsProvider = context.read<TipsProvider>();
    final tips = tipsProvider.tips;

    return ScaleCarousel(
      itemCount: tips.length,
      itemSize: const Size(TipCard.width, TipCard.height),
      pageExtent: 212.5,
      minScale: 190 / TipCard.width,
      initialPage: tipsProvider.currentIndex,
      onPageChanged: tipsProvider.showTip,
      itemBuilder: (context, index) => TipCard(tip: tips[index]),
    );
  }
}
