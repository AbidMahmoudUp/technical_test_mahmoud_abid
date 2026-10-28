import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_text_styles.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppAssets.logo, width: 25, height: 21),
        const SizedBox(width: 10),
        const Text('Welcome to Velia', style: AppTextStyles.caption),
      ],
    );
  }
}
