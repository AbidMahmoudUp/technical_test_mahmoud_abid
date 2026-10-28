import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// One scrollable column of the [HeightWheelPicker].
class WheelColumnData {
  const WheelColumnData({
    required this.min,
    required this.max,
    required this.selected,
    required this.unit,
    required this.onChanged,
  });

  final int min;
  final int max;
  final int selected;
  final String unit;
  final ValueChanged<int> onChanged;
}

/// iOS-style wheel: the selected row sits in a rounded band and the
/// other rows curve away and fade out.
class HeightWheelPicker extends StatelessWidget {
  const HeightWheelPicker({super.key, required this.columns});

  final List<WheelColumnData> columns;

  static const height = 320.0;
  static const itemExtent = 40.0;
  static const bandHeight = 64.0;
  static const _columnWidth = 116.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: bandHeight,
            decoration: BoxDecoration(
              color: AppColors.controlSecondary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.075, 0.175, 0.31, 0.5, 0.69, 0.825, 0.925, 1],
              colors: [
                Color(0x00FFFFFF),
                Color(0x33FFFFFF),
                Color(0x66FFFFFF),
                Color(0xCCFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xCCFFFFFF),
                Color(0x66FFFFFF),
                Color(0x33FFFFFF),
                Color(0x00FFFFFF),
              ],
            ).createShader(bounds),
            child: Padding(
              padding: EdgeInsets.only(right: columns.length > 1 ? 10 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final column in columns)
                    SizedBox(
                      key: ValueKey(column.unit),
                      width: _columnWidth,
                      child: _WheelColumn(data: column),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WheelColumn extends StatefulWidget {
  const _WheelColumn({required this.data});

  final WheelColumnData data;

  @override
  State<_WheelColumn> createState() => _WheelColumnState();
}

class _WheelColumnState extends State<_WheelColumn> {
  late final _controller = FixedExtentScrollController(
    initialItem: widget.data.selected - widget.data.min,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Stack(
      alignment: Alignment.center,
      children: [
        ListWheelScrollView.useDelegate(
          controller: _controller,
          itemExtent: HeightWheelPicker.itemExtent,
          diameterRatio: 0.99,
          perspective: 0.001,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) => data.onChanged(data.min + index),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: data.max - data.min + 1,
            builder: (context, index) =>
                Center(child: Text('${data.min + index}', style: _valueStyle)),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.only(left: 82, top: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(data.unit, style: _unitStyle),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static final _valueStyle = AppTextStyles.title.copyWith(
    fontSize: 34,
    height: 1,
    letterSpacing: 0,
  );

  static final _unitStyle = AppTextStyles.bodySmall.copyWith(
    color: AppColors.textSecondary,
  );
}
