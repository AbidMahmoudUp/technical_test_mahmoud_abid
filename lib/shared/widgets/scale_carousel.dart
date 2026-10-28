import 'package:flutter/material.dart';

/// Horizontally swipeable carousel where the centred item is full size and
/// its neighbours shrink to [minScale] as they move away from the centre.
class ScaleCarousel extends StatefulWidget {
  const ScaleCarousel({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.itemSize,
    required this.pageExtent,
    required this.minScale,
    this.initialPage = 0,
    this.onPageChanged,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  /// Size of the centred, unscaled item.
  final Size itemSize;

  /// Distance between the centres of two neighbouring items.
  final double pageExtent;
  final double minScale;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;

  @override
  State<ScaleCarousel> createState() => _ScaleCarouselState();
}

class _ScaleCarouselState extends State<ScaleCarousel> {
  PageController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  PageController _controllerFor(double width) {
    final fraction = widget.pageExtent / width;
    if (_controller?.viewportFraction != fraction) {
      final page = _controller?.hasClients == true
          ? _controller!.page!.round()
          : widget.initialPage;
      _controller?.dispose();
      _controller = PageController(
        viewportFraction: fraction,
        initialPage: page,
      );
    }
    return _controller!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemSize.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = _controllerFor(constraints.maxWidth);
          return PageView.builder(
            controller: controller,
            itemCount: widget.itemCount,
            clipBehavior: Clip.none,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, index) => AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                final page = controller.position.haveDimensions
                    ? controller.page!
                    : controller.initialPage.toDouble();
                final distance = (page - index).abs().clamp(0.0, 1.0);
                return Transform.scale(
                  scale: 1 - distance * (1 - widget.minScale),
                  child: child,
                );
              },
              child: OverflowBox(
                minWidth: widget.itemSize.width,
                maxWidth: widget.itemSize.width,
                minHeight: widget.itemSize.height,
                maxHeight: widget.itemSize.height,
                child: widget.itemBuilder(context, index),
              ),
            ),
          );
        },
      ),
    );
  }
}
