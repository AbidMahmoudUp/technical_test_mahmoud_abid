import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/scale_carousel.dart';
import '../providers/ring_onboarding_provider.dart';
import 'showcase_row.dart';
import 'showcase_tile.dart';

/// Swipeable row of lifestyle photos framed like the app tiles.
class PhotoCardRow extends StatelessWidget {
  const PhotoCardRow({super.key});

  @override
  Widget build(BuildContext context) {
    final onboarding = context.read<RingOnboardingProvider>();
    final photos = onboarding.highlightPhotos;
    final pixels =
        (ShowcaseTile.size * MediaQuery.devicePixelRatioOf(context)).round();

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ScaleCarousel(
        itemCount: photos.length,
        itemSize: const Size.square(ShowcaseTile.size),
        pageExtent: ShowcaseRow.pageExtent,
        minScale: ShowcaseRow.sideSize / ShowcaseRow.centerSize,
        initialPage: onboarding.highlightIndex,
        onPageChanged: onboarding.showHighlight,
        itemBuilder: (context, index) => ShowcaseTile(
          // Photos are landscape, so sizing by height keeps cover crisp.
          image: ResizeImage(AssetImage(photos[index]), height: pixels),
        ),
      ),
    );
  }
}
